
CREATE DATABASE IF NOT EXISTS hotelhub;
USE hotelhub;

DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS ratings;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS guests;
DROP TABLE IF EXISTS hotels;


CREATE TABLE hotels (
    hotel_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    location VARCHAR(255) DEFAULT 'Guangzhou',
    type VARCHAR(100),
    total_rooms INT NOT NULL,
    description TEXT
);

CREATE TABLE rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    hotel_id INT,
    room_type VARCHAR(50),
    price DECIMAL(10,2),
    available_count INT NOT NULL,
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

CREATE TABLE guests (
    guest_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    phone VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    hotel_id INT,
    room_id INT,
    checkin_date DATE,
    checkout_date DATE,
    rooms_booked INT DEFAULT 1,
    booked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id),
    FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE activities (
    activity_id INT PRIMARY KEY AUTO_INCREMENT,
    guest_id INT,
    hotel_id INT,
    activity VARCHAR(50),
    activity_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (guest_id) REFERENCES guests(guest_id),
    FOREIGN KEY (hotel_id) REFERENCES hotels(hotel_id)
);

-- Insert Hotels
INSERT INTO hotels (name, type, total_rooms, description) VALUES
('The Garden Hotel Guangzhou', 'Luxury', 30, 'Elegant stay in the city center'),
('White Swan Hotel', 'Luxury', 30, 'Historic riverside property on Shamian Island'),
('The Ritz-Carlton Guangzhou', 'Luxury', 30, 'High-end property near Canton Tower'),
('Four Seasons Hotel Guangzhou', 'Luxury', 30, 'Located in IFC building with city views'),
('Grand Hyatt Guangzhou', 'Business', 30, 'Modern and upscale hotel'),
('Hilton Guangzhou Tianhe', 'Business', 30, 'Convenient for business travelers');

-- Insert Rooms
INSERT INTO rooms (hotel_id, room_type, price, available_count) VALUES
(1, 'Standard', 200.0, 1),
(1, 'Standard', 200.0, 1),
(1, 'Standard', 200.0, 1),
(1, 'Standard', 200.0, 1),
(1, 'Standard', 200.0, 1),
(1, 'Standard', 200.0, 1),
(1, 'Standard', 200.0, 1),
(1, 'Standard', 200.0, 1),
(1, 'Standard', 200.0, 1),
(1, 'Standard', 200.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Deluxe', 350.0, 1),
(1, 'Suite', 500.0, 1),
(1, 'Suite', 500.0, 1),
(1, 'Suite', 500.0, 1),
(1, 'Suite', 500.0, 1),
(1, 'Suite', 500.0, 1),
(1, 'Suite', 500.0, 1),
(1, 'Suite', 500.0, 1),
(1, 'Suite', 500.0, 1),
(1, 'Suite', 500.0, 1),
(1, 'Suite', 500.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Standard', 200.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Deluxe', 350.0, 1),
(2, 'Suite', 500.0, 1),
(2, 'Suite', 500.0, 1),
(2, 'Suite', 500.0, 1),
(2, 'Suite', 500.0, 1),
(2, 'Suite', 500.0, 1),
(2, 'Suite', 500.0, 1),
(2, 'Suite', 500.0, 1),
(2, 'Suite', 500.0, 1),
(2, 'Suite', 500.0, 1),
(2, 'Suite', 500.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Standard', 200.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Deluxe', 350.0, 1),
(3, 'Suite', 500.0, 1),
(3, 'Suite', 500.0, 1),
(3, 'Suite', 500.0, 1),
(3, 'Suite', 500.0, 1),
(3, 'Suite', 500.0, 1),
(3, 'Suite', 500.0, 1),
(3, 'Suite', 500.0, 1),
(3, 'Suite', 500.0, 1),
(3, 'Suite', 500.0, 1),
(3, 'Suite', 500.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Standard', 200.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Deluxe', 350.0, 1),
(4, 'Suite', 500.0, 1),
(4, 'Suite', 500.0, 1),
(4, 'Suite', 500.0, 1),
(4, 'Suite', 500.0, 1),
(4, 'Suite', 500.0, 1),
(4, 'Suite', 500.0, 1),
(4, 'Suite', 500.0, 1),
(4, 'Suite', 500.0, 1),
(4, 'Suite', 500.0, 1),
(4, 'Suite', 500.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Standard', 200.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Deluxe', 350.0, 1),
(5, 'Suite', 500.0, 1),
(5, 'Suite', 500.0, 1),
(5, 'Suite', 500.0, 1),
(5, 'Suite', 500.0, 1),
(5, 'Suite', 500.0, 1),
(5, 'Suite', 500.0, 1),
(5, 'Suite', 500.0, 1),
(5, 'Suite', 500.0, 1),
(5, 'Suite', 500.0, 1),
(5, 'Suite', 500.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Standard', 200.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Deluxe', 350.0, 1),
(6, 'Suite', 500.0, 1),
(6, 'Suite', 500.0, 1),
(6, 'Suite', 500.0, 1),
(6, 'Suite', 500.0, 1),
(6, 'Suite', 500.0, 1),
(6, 'Suite', 500.0, 1),
(6, 'Suite', 500.0, 1),
(6, 'Suite', 500.0, 1),
(6, 'Suite', 500.0, 1),
(6, 'Suite', 500.0, 1);

-- Insert Guests
INSERT INTO guests (name, email, phone) VALUES
('Guest1', 'guest1@example.com', '13800000001'),
('Guest2', 'guest2@example.com', '13800000002'),
('Guest3', 'guest3@example.com', '13800000003'),
('Guest4', 'guest4@example.com', '13800000004'),
('Guest5', 'guest5@example.com', '13800000005'),
('Guest6', 'guest6@example.com', '13800000006'),
('Guest7', 'guest7@example.com', '13800000007'),
('Guest8', 'guest8@example.com', '13800000008'),
('Guest9', 'guest9@example.com', '13800000009'),
('Guest10', 'guest10@example.com', '13800000010'),
('Guest11', 'guest11@example.com', '13800000011'),
('Guest12', 'guest12@example.com', '13800000012'),
('Guest13', 'guest13@example.com', '13800000013'),
('Guest14', 'guest14@example.com', '13800000014'),
('Guest15', 'guest15@example.com', '13800000015'),
('Guest16', 'guest16@example.com', '13800000016'),
('Guest17', 'guest17@example.com', '13800000017'),
('Guest18', 'guest18@example.com', '13800000018'),
('Guest19', 'guest19@example.com', '13800000019'),
('Guest20', 'guest20@example.com', '13800000020');


-- Trigger: Prevent overlapping bookings for the same room
DELIMITER $$
CREATE TRIGGER before_order_insert
BEFORE INSERT ON orders
FOR EACH ROW
BEGIN
    DECLARE overlap_count INT;
    SELECT COUNT(*) INTO overlap_count
    FROM orders
    WHERE room_id = NEW.room_id
      AND NEW.checkin_date < checkout_date
      AND NEW.checkout_date > checkin_date;

    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Room is already booked for the selected dates.';
    END IF;
END$$
DELIMITER ;

-- Trigger: After insert, update availability and log activity
DELIMITER $$
CREATE TRIGGER after_order_insert
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE rooms
    SET available_count = available_count - NEW.rooms_booked
    WHERE room_id = NEW.room_id AND available_count >= NEW.rooms_booked;

    INSERT INTO activities (guest_id, hotel_id, activity)
    VALUES (NEW.guest_id, NEW.hotel_id, 'Check-In');
END$$
DELIMITER ;

-- Insert Orders
INSERT INTO orders (guest_id, hotel_id, room_id, checkin_date, checkout_date, rooms_booked) VALUES
(5, 5, 177, '2025-09-17', '2025-09-21', 1),
(6, 5, 29, '2025-09-03', '2025-09-06', 1),
(20, 2, 88, '2025-09-02', '2025-09-03', 1),
(6, 5, 23, '2025-08-07', '2025-08-10', 1),
(12, 5, 1, '2025-09-22', '2025-09-24', 1),
(13, 5, 101, '2025-08-13', '2025-08-17', 1),
(4, 1, 51, '2025-08-30', '2025-08-31', 1),
(14, 6, 179, '2025-08-03', '2025-08-05', 1),
(7, 1, 135, '2025-09-25', '2025-09-26', 1),
(15, 5, 44, '2025-09-30', '2025-10-04', 1),
(11, 6, 29, '2025-08-31', '2025-09-03', 1),
(6, 2, 156, '2025-08-21', '2025-08-22', 1),
(7, 3, 144, '2025-09-17', '2025-09-21', 1),
(4, 6, 10, '2025-09-25', '2025-09-27', 1),
(19, 5, 140, '2025-08-02', '2025-08-03', 1),
(2, 1, 3, '2025-09-03', '2025-09-04', 1),
(8, 2, 163, '2025-09-08', '2025-09-12', 1),
(8, 3, 13, '2025-08-10', '2025-08-14', 1),
(16, 6, 150, '2025-08-18', '2025-08-20', 1),
(6, 3, 70, '2025-08-16', '2025-08-17', 1),
(2, 4, 180, '2025-09-13', '2025-09-17', 1),
(13, 4, 28, '2025-09-27', '2025-09-30', 1),
(11, 4, 154, '2025-09-11', '2025-09-14', 1),
(13, 3, 154, '2025-08-05', '2025-08-09', 1),
(7, 2, 152, '2025-09-06', '2025-09-10', 1),
(14, 1, 17, '2025-08-30', '2025-09-02', 1),
(17, 5, 98, '2025-09-15', '2025-09-16', 1),
(8, 6, 144, '2025-08-16', '2025-08-19', 1),
(19, 1, 115, '2025-08-20', '2025-08-23', 1),
(11, 2, 105, '2025-09-05', '2025-09-09', 1),
(18, 1, 15, '2025-08-13', '2025-08-16', 1),
(10, 5, 125, '2025-08-01', '2025-08-03', 1),
(18, 5, 158, '2025-08-13', '2025-08-15', 1),
(7, 4, 100, '2025-08-28', '2025-08-30', 1),
(18, 3, 79, '2025-09-02', '2025-09-06', 1),
(7, 3, 34, '2025-08-21', '2025-08-22', 1),
(13, 4, 63, '2025-09-27', '2025-09-28', 1),
(6, 2, 52, '2025-09-28', '2025-10-01', 1),
(3, 5, 86, '2025-08-29', '2025-09-01', 1),
(17, 3, 166, '2025-08-28', '2025-08-30', 1),
(1, 4, 132, '2025-09-11', '2025-09-13', 1),
(17, 6, 82, '2025-09-02', '2025-09-03', 1),
(8, 3, 83, '2025-08-27', '2025-08-31', 1),
(4, 5, 124, '2025-09-15', '2025-09-18', 1),
(15, 3, 98, '2025-08-28', '2025-08-29', 1),
(12, 2, 118, '2025-08-09', '2025-08-12', 1),
(14, 6, 141, '2025-08-08', '2025-08-10', 1),
(1, 2, 140, '2025-08-16', '2025-08-19', 1),
(11, 1, 101, '2025-08-20', '2025-08-24', 1),
(15, 4, 122, '2025-08-22', '2025-08-25', 1);