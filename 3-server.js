// (A) LOAD REQUIRED MODULES
// npm i express body-parser multer
const express = require("express"),
      bodyParser = require("body-parser"),
      multer = require("multer"),
      path = require("path");

// (B) SETTINGS
const portHTTP = 80;

// (C) EXPRESS SERVER
const app = express(),
      forms = multer();
app.use("/assets", express.static(path.join(__dirname, "assets")));
app.use(forms.array());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// (D) EXPRESS HANDLERS
// (D1) HOME PAGE - BOOKING FORM
app.get("/", (req, res) => res.sendFile(path.join(__dirname, "1-booking.html")));

// (D2) PROCESS BOOKING FORM WITHOUT EMAIL
app.post("/book", (req, res) => {
  console.log("Booking received:");
  console.log(req.body); // You can save this to a database or log file if needed
  res.redirect("/thankyou"); // Redirect user to thank-you page
});

// (D3) THANK YOU
app.get("/thankyou", (req, res) => res.sendFile(path.join(__dirname, "2-thank-you.html")));

// (E) START!
app.listen(portHTTP, () => {
  console.log(`Server running on port ${portHTTP}`);
});
