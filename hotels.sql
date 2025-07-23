
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS activities;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS guests;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS hotels;

SET FOREIGN_KEY_CHECKS = 1;

CREATE DATABASE IF NOT EXISTS hotelhub;
USE hotelhub;

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
    checkin_date DATETIME,
    checkout_date DATETIME,
    rooms_booked INT DEFAULT 1,
    status VARCHAR(20) DEFAULT 'Booked',  -- Booked, Checked-In, Completed, Canceled
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


-- Prevent overlapping bookings
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
      AND NEW.checkout_date > checkin_date
      AND status != 'Canceled';

    IF overlap_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Room is already booked for the selected dates.';
    END IF;
END$$
DELIMITER ;

-- After booking: reduce availability and log check-in
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

-- Cancel logic: allow cancel if at least 2 hours before check-in
DELIMITER $$
CREATE TRIGGER before_order_update
BEFORE UPDATE ON orders
FOR EACH ROW
BEGIN
    IF NEW.status = 'Canceled' AND OLD.status = 'Booked' THEN
        IF TIMESTAMPDIFF(HOUR, NOW(), OLD.checkin_date) < 2 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Cannot cancel within 2 hours of check-in.';
        END IF;
    END IF;
END$$
DELIMITER ;

-- After cancel: restore availability and log cancellation
DELIMITER $$
CREATE TRIGGER after_order_update
AFTER UPDATE ON orders
FOR EACH ROW
BEGIN
    IF OLD.status = 'Booked' AND NEW.status = 'Canceled' THEN
        UPDATE rooms
        SET available_count = available_count + OLD.rooms_booked
        WHERE room_id = OLD.room_id;

        INSERT INTO activities (guest_id, hotel_id, activity)
        VALUES (OLD.guest_id, OLD.hotel_id, 'Booking Canceled');
    END IF;
END$$
DELIMITER ;

-- Insert Orders
INSERT INTO orders (guest_id, hotel_id, room_id, checkin_date, checkout_date, rooms_booked) VALUES
(7, 1, 173, '2025-08-04 14:00:00', '2025-08-06 14:00:00', 1),
(5, 2, 170, '2025-09-13 14:00:00', '2025-09-15 14:00:00', 1),
(19, 5, 113, '2025-09-09 14:00:00', '2025-09-10 14:00:00', 1),
(6, 2, 145, '2025-09-18 14:00:00', '2025-09-20 14:00:00', 1),
(2, 1, 87, '2025-08-27 14:00:00', '2025-08-30 14:00:00', 1),
(1, 4, 94, '2025-09-08 14:00:00', '2025-09-10 14:00:00', 1),
(5, 5, 138, '2025-08-22 14:00:00', '2025-08-26 14:00:00', 1),
(7, 5, 141, '2025-08-06 14:00:00', '2025-08-07 14:00:00', 1),
(2, 3, 35, '2025-08-08 14:00:00', '2025-08-10 14:00:00', 1),
(8, 4, 122, '2025-08-16 14:00:00', '2025-08-17 14:00:00', 1),
(15, 6, 61, '2025-08-12 14:00:00', '2025-08-16 14:00:00', 1),
(13, 4, 146, '2025-08-20 14:00:00', '2025-08-22 14:00:00', 1),
(2, 2, 77, '2025-08-16 14:00:00', '2025-08-19 14:00:00', 1),
(9, 2, 121, '2025-09-06 14:00:00', '2025-09-10 14:00:00', 1),
(18, 3, 130, '2025-08-14 14:00:00', '2025-08-15 14:00:00', 1),
(20, 3, 118, '2025-09-27 14:00:00', '2025-09-30 14:00:00', 1),
(16, 6, 95, '2025-08-12 14:00:00', '2025-08-14 14:00:00', 1),
(15, 5, 148, '2025-09-27 14:00:00', '2025-09-30 14:00:00', 1),
(7, 5, 92, '2025-09-08 14:00:00', '2025-09-11 14:00:00', 1),
(8, 3, 144, '2025-08-02 14:00:00', '2025-08-03 14:00:00', 1),
(13, 1, 119, '2025-08-06 14:00:00', '2025-08-10 14:00:00', 1),
(13, 4, 34, '2025-08-23 14:00:00', '2025-08-27 14:00:00', 1),
(18, 3, 141, '2025-08-16 14:00:00', '2025-08-17 14:00:00', 1),
(9, 6, 21, '2025-08-25 14:00:00', '2025-08-27 14:00:00', 1),
(10, 1, 71, '2025-08-12 14:00:00', '2025-08-13 14:00:00', 1),
(18, 4, 80, '2025-08-06 14:00:00', '2025-08-07 14:00:00', 1),
(12, 6, 25, '2025-08-23 14:00:00', '2025-08-27 14:00:00', 1),
(1, 6, 30, '2025-08-01 14:00:00', '2025-08-04 14:00:00', 1),
(14, 6, 31, '2025-08-03 14:00:00', '2025-08-04 14:00:00', 1),
(10, 1, 100, '2025-09-20 14:00:00', '2025-09-24 14:00:00', 1),
(15, 1, 129, '2025-08-14 14:00:00', '2025-08-15 14:00:00', 1),
(11, 6, 117, '2025-09-18 14:00:00', '2025-09-21 14:00:00', 1),
(5, 2, 143, '2025-09-21 14:00:00', '2025-09-25 14:00:00', 1),
(18, 4, 115, '2025-08-03 14:00:00', '2025-08-05 14:00:00', 1),
(1, 4, 32, '2025-08-01 14:00:00', '2025-08-02 14:00:00', 1),
(12, 1, 47, '2025-09-03 14:00:00', '2025-09-05 14:00:00', 1),
(7, 3, 112, '2025-08-13 14:00:00', '2025-08-16 14:00:00', 1),
(9, 4, 9, '2025-09-13 14:00:00', '2025-09-17 14:00:00', 1),
(18, 4, 116, '2025-08-01 14:00:00', '2025-08-04 14:00:00', 1),
(4, 2, 78, '2025-08-24 14:00:00', '2025-08-27 14:00:00', 1),
(19, 5, 133, '2025-09-01 14:00:00', '2025-09-05 14:00:00', 1),
(20, 1, 12, '2025-09-22 14:00:00', '2025-09-26 14:00:00', 1),
(6, 4, 44, '2025-09-13 14:00:00', '2025-09-17 14:00:00', 1),
(7, 4, 30, '2025-09-23 14:00:00', '2025-09-25 14:00:00', 1),
(8, 2, 79, '2025-08-07 14:00:00', '2025-08-09 14:00:00', 1),
(1, 4, 95, '2025-08-29 14:00:00', '2025-08-31 14:00:00', 1),
(15, 1, 38, '2025-08-09 14:00:00', '2025-08-10 14:00:00', 1),
(18, 2, 31, '2025-09-20 14:00:00', '2025-09-22 14:00:00', 1),
(17, 3, 141, '2025-09-30 14:00:00', '2025-10-01 14:00:00', 1),
(16, 3, 145, '2025-08-03 14:00:00', '2025-08-04 14:00:00', 1);
