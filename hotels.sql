-- 🚀 INIT DATABASE
CREATE DATABASE IF NOT EXISTS hotelhub;
USE hotelhub;

-- ❌ DROP IF EXISTS (clean reset)
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS guests;
DROP TABLE IF EXISTS hotels;

-- 🏨 HOTELS TABLE: includes total room capacity
CREATE TABLE hotels (
  hotel_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  location VARCHAR(255),
  type VARCHAR(100),
  total_rooms INT NOT NULL
);

-- 👤 GUESTS TABLE
CREATE TABLE guests (
  guest_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE,
  phone VARCHAR(50)
);

-- 📦 ORDERS / BOOKINGS TABLE
CREATE TABLE orders (
  order_id INT PRIMARY KEY AUTO_INCREMENT,
  guest_id INT,
  hotel_id INT,
  checkin_date DATE,
  checkout_date DATE,
  rooms_booked INT,
  booked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
  FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

-- 🌆 SAMPLE HOTELS
INSERT INTO hotels (name, location, type, total_rooms) VALUES
('Marina Bay Luxe', 'Singapore', 'Luxury', 50),
('Skyline Stay', 'Singapore', 'Business', 80),
('Seaside Serenity', 'Sentosa', 'Resort', 60),
('Orchard Zen Retreat', 'Singapore', 'Boutique', 25),
('Ocean Breeze Resort', 'Sentosa', 'Luxury', 120),
('Hilltop Haven', 'Bukit Timah', 'Eco-Lodge', 40),
('Forest Edge Inn', 'Woodlands', 'Budget', 60);

-- 👥 SAMPLE GUESTS
INSERT INTO guests (name, email, phone) VALUES
('Alex Tan', 'alex.tan@example.com', '81234567'),
('Rachel Lim', 'rachel.lim@example.com', '82345678'),
('Ken Wong', 'ken.wong@example.com', '83456789'),
('Priya Nair', 'priya.nair@example.com', '84567890'),
('James Lee', 'james.lee@example.com', '85678901'),
('Fatima Zahra', 'fatima.z@example.com', '86789012'),
('Hiroshi Yamamoto', 'hiroshi.y@example.com', '87890123'),
('Natalie Teo', 'natalie.teo@example.com', '85678999'),
('Tommy Yeo', 'tommy.yeo@example.com', '89011234'),
('Susan Chua', 'susan.chua@example.com', '88990123');

-- 🗓 SAMPLE BOOKINGS
INSERT INTO orders (guest_id, hotel_id, checkin_date, checkout_date, rooms_booked) VALUES
(1, 1, '2025-07-25', '2025-07-27', 2),
(2, 2, '2025-07-23', '2025-07-24', 5),
(3, 3, '2025-07-28', '2025-07-30', 3),
(4, 1, '2025-07-26', '2025-07-28', 1),
(5, 4, '2025-07-20', '2025-07-21', 2),
(6, 5, '2025-08-01', '2025-08-03', 10),
(7, 6, '2025-08-02', '2025-08-05', 4),
(8, 7, '2025-08-05', '2025-08-07', 6),
(9, 1, '2025-08-03', '2025-08-05', 8),
(10, 3, '2025-08-11', '2025-08-13', 2);
