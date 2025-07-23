// (A) LOAD REQUIRED MODULES
const express = require("express"),
      bodyParser = require("body-parser"),
      multer = require("multer"),
      path = require("path"),
      db = require("./db");

// (B) SETTINGS
const portHTTP = 3000; // Development port
const app = express(),
      forms = multer();

app.use("/assets", express.static(path.join(__dirname, "assets")));
app.use(forms.array());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// (C) ROUTES

// (C1) Home page
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "1-booking.html"));
});

// (C2) List all available hotels
app.get("/hotels", (req, res) => {
  const sql = `
    SELECT h.hotel_id, h.name, h.location, h.type, h.description,
           MIN(r.price) AS min_price, MAX(r.price) AS max_price
    FROM hotels h
    JOIN rooms r ON h.hotel_id = r.hotel_id
    WHERE r.available_count > 0
    GROUP BY h.hotel_id
    ORDER BY h.name
  `;
  db.query(sql, (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// (C3) Get available room types for a hotel (with date validation)
app.get("/hotels/:hotel_id/rooms", (req, res) => {
  const { hotel_id } = req.params;
  const { checkin, checkout } = req.query;

  if (!checkin || !checkout) {
    return res.status(400).json({ error: "Check-in and check-out dates are required." });
  }

  if (new Date(checkout) <= new Date(checkin)) {
    return res.status(400).json({ error: "Invalid date range: Check-out must be after check-in." });
  }

  const sql = `
    SELECT r.room_type, r.price,
           (SUM(r.available_count) -
             IFNULL((
               SELECT SUM(o.rooms_booked)
               FROM orders o
               WHERE o.room_id IN (
                 SELECT room_id FROM rooms WHERE hotel_id = ? AND room_type = r.room_type
               )
               AND o.status IN ('Booked','Checked-In')
               AND o.checkin_date < ?
               AND o.checkout_date > ?
             ), 0)
           ) AS total_available
    FROM rooms r
    WHERE r.hotel_id = ?
    GROUP BY r.room_type, r.price
    HAVING total_available > 0
    ORDER BY r.price ASC
  `;

  db.query(sql, [hotel_id, checkout, checkin, hotel_id], (err, results) => {
    if (err) return res.status(500).json({ error: err.message });
    res.json(results);
  });
});

// (C4) Make a booking by room_type
app.post("/book", (req, res) => {
  const { name, email, phone, hotel_id, room_type, checkin_date, checkout_date, rooms_booked } = req.body;

  if (!name || !email || !hotel_id || !room_type || !checkin_date || !checkout_date) {
    return res.status(400).json({ error: "Missing required fields." });
  }

  if (new Date(checkout_date) <= new Date(checkin_date)) {
    return res.status(400).json({ error: "Invalid date range: Check-out must be after check-in." });
  }

  console.log("Booking request:", { name, email, hotel_id, room_type, checkin_date, checkout_date, rooms_booked });

  db.query("SELECT guest_id FROM guests WHERE email = ?", [email], (err, result) => {
    if (err) return res.status(500).json({ error: err.message });

    const addBooking = (guestId) => {
      // Check availability for requested rooms
      const checkSQL = `
        SELECT SUM(r.available_count) -
               IFNULL((
                 SELECT SUM(o.rooms_booked)
                 FROM orders o
                 WHERE o.room_id IN (
                   SELECT room_id FROM rooms WHERE hotel_id = ? AND room_type = ?
                 )
                 AND o.status IN ('Booked','Checked-In')
                 AND o.checkin_date < ?
                 AND o.checkout_date > ?
               ), 0) AS available
        FROM rooms r
        WHERE r.hotel_id = ? AND r.room_type = ?
      `;

      db.query(checkSQL, [hotel_id, room_type, checkout_date, checkin_date, hotel_id, room_type], (err5, availability) => {
        if (err5) return res.status(500).json({ error: err5.message });

        const availableRooms = availability[0].available || 0;
        if (rooms_booked > availableRooms) {
          return res.status(400).json({ error: `Only ${availableRooms} rooms are available for ${room_type}.` });
        }

        // Get any available room_id for booking
        db.query(
          `SELECT room_id FROM rooms WHERE hotel_id = ? AND room_type = ? LIMIT 1`,
          [hotel_id, room_type],
          (err4, rows) => {
            if (err4) return res.status(500).json({ error: err4.message });
            if (rows.length === 0) return res.status(400).json({ error: "No available room of this type for selected dates." });

            const selectedRoomId = rows[0].room_id;
            db.query(
              `INSERT INTO orders (guest_id, hotel_id, room_id, checkin_date, checkout_date, rooms_booked)
               VALUES (?, ?, ?, ?, ?, ?)`,
              [guestId, hotel_id, selectedRoomId, checkin_date, checkout_date, rooms_booked || 1],
              (err2) => {
                if (err2) return res.status(500).json({ error: err2.message });
                res.redirect("/thankyou");
              }
            );
          }
        );
      });
    };

    if (result.length > 0) {
      addBooking(result[0].guest_id);
    } else {
      db.query(
        `INSERT INTO guests (name, email, phone) VALUES (?, ?, ?)`,
        [name, email, phone],
        (err3, insertResult) => {
          if (err3) return res.status(500).json({ error: err3.message });
          addBooking(insertResult.insertId);
        }
      );
    }
  });
});

// (C5) Thank you page
app.get("/thankyou", (req, res) => {
  res.sendFile(path.join(__dirname, "2-thank-you.html"));
});

// (D) START SERVER
app.listen(portHTTP, () => {
  console.log(`Server running on port ${portHTTP}`);
});
