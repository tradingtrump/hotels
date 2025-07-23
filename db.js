const mysql = require("mysql2");
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: //ENTER YOUR PASSWORD//
  database: "hotelhub"
});
db.connect(err => {
  if (err) throw err;
  console.log("Connected to MySQL!");
});
module.exports = db;
