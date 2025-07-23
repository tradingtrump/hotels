// (A) LOAD REQUIRED MODULES
const express = require("express"),
      bodyParser = require("body-parser"),
      multer = require("multer"),
      path = require("path"),
      mysql = require("mysql2");

// (B) EXPRESS SETUP
const app = express(),
      forms = multer();
app.use("/assets", express.static(path.join(__dirname, "assets")));
app.use(forms.array());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// (C) DATABASE CONNECTION
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "n3u3da!",
  database: "hotelhub"
});

db.connect(err => {
  if (err) throw err;
  console.log("Connected to MySQL!");
});

// (D) EXPRESS ROUTES

// (D1) HOME PAGE (LOAD BOOKING FORM)
app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "1-booking.html"));
});

// (D2) HOTEL INFO + AVAILABILITY QUERY
app.get("/hotels/:hotel_id", (req, res) => {
  const { hotel_id } = req.params;
  db.query("SELECT * FROM hotels WHERE hotel_id = ?", [hotel_id], (err, hotel) => {
    if (err || hotel.length === 0) return res.sendStatus(404);

    const today = new Date().toISOString().slice(0, 10);
    db.query(
      `SELECT SUM(rooms_booked) AS booked FROM orders 
       WHERE hotel_id = ? AND checkout_date > ?`,
      [hotel_id, today],
      (err2, result) => {
        if (err2) return res.sendStatus(500);
        const booked = result[0].booked || 0;
        const available = hotel[0].total_rooms - booked;
        res.json({
          name: hotel[0].name,
          type: hotel[0].type,
          total_rooms: hotel[0].total_rooms,
          rooms_available: available
        });
      }
    );
  });
});

// (D3) MAKE BOOKING
app.post("/book", (req, res) => {
  const { name, email, phone, hotel_id, checkin_date, checkout_date, rooms_booked } = req.body;

  // (D3-1) Create guest if not exists
  db.query("SELECT guest_id FROM guests WHERE email = ?", [email], (err, result) => {
    if (err) return res.sendStatus(500);

    const addBooking = (guestId) => {
      db.query(
        `INSERT INTO orders (guest_id, hotel_id, checkin_date, checkout_date, rooms_booked)
         VALUES (?, ?, ?, ?, ?)`,
        [guestId, hotel_id, checkin_date, checkout_date, rooms_booked],
        (err2) => {
          if (err2) return res.sendStatus(500);
          res.redirect("/thankyou");
        }
      );
    };

    if (result.length > 0) {
      addBooking(result[0].guest_id);
    } else {
      db.query(
        `INSERT INTO guests (name, email, phone) VALUES (?, ?, ?)`,
        [name, email, phone],
        (err3, insertResult) => {
          if (err3) return res.sendStatus(500);
          addBooking(insertResult.insertId);
        }
      );
    }
  });
});

// (D4) THANK YOU PAGE
app.get("/thankyou", (req, res) => {
  res.sendFile(path.join(__dirname, "2-thank-you.html"));
});

// (E) START SERVER
const portHTTP = 80;
app.listen(portHTTP, () => {
  console.log(`Server running on port ${portHTTP}`);
});
