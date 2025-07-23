const mysql = require("mysql2");
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "lcy011209",
  database: "hotelhub"
});
db.connect(err => {
  if (err) throw err;
  console.log("Connected to MySQL!");
});
module.exports = db;
