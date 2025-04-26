CREATE DATABASE flight_db;
USE  flight_db;



CREATE TABLE customer
(
    customer_id INT NOT NULL AUTO_INCREMENT,
    customer_name VARCHAR(70),
    customer_status VARCHAR(70),
    customer_Total_mileage  INT,

    PRIMARY KEY (customer_id)

);

INSERT INTO customer (customer_name, customer_status, customer_Total_mileage)
VALUES
    ('Agustine Riviera', 'Silver', 115235),
    ('Alaina Sepulvida', 'None', 6008),
    ('Tom Jones', 'Gold', 205767),
    ('Sam Rio', 'None', 2653),
    ('Jessica James', 'Silver', 127656),
    ('Ana Janco', 'Silver', 136773),
    ('Jennifer Cortez', 'Gold', 300582),
    ('Christian Janco', 'Silver', 14642);

CREATE TABLE aircraft
(

    aircraft_name VARCHAR(70),
    aircraft_number_of_seats INT,

    PRIMARY KEY (aircraft_name)

);

INSERT INTO aircraft (aircraft_name, aircraft_number_of_seats) VALUES
                                                                   ('Boeing 747', 400),
                                                                   ('Airbus A330', 236),
                                                                   ('Boeing 777', 264);

CREATE TABLE flight
(
    flight_id INT NOT NULL AUTO_INCREMENT,
    flight_number VARCHAR(5),
    flight_aircraft_id INT,
    flight_aircraft_name VARCHAR(70),
    flight_mileage  INT,

    PRIMARY KEY (flight_id),
    FOREIGN KEY (flight_aircraft_name) REFERENCES aircraft(aircraft_name)
);

INSERT INTO flight (flight_number, flight_mileage, flight_aircraft_name) VALUES
                                                                              ('DL143', 135, 'Boeing 747'),
                                                                              ('DL122', 4370, 'Airbus A330'),
                                                                              ('DL53', 2078, 'Boeing 777'),
                                                                              ('DL222', 1765, 'Boeing 777'),
                                                                              ('DL37', 531, 'Boeing 747');




CREATE TABLE booking
(
    booking_id INT NOT NULL AUTO_INCREMENT,
    booking_flight_number VARCHAR(5),
    booking_customer_id INT,

    PRIMARY KEY (booking_id),
    FOREIGN KEY (booking_customer_id) REFERENCES customer(customer_id),
        FOREIGN KEY (booking_flight_number) REFERENCES flight(flight_number)
);

INSERT INTO Booking (booking_customer_id, booking_flight_number) VALUES
                                                                     (1, 'DL143'),
                                                                     (1, 'DL122'),
                                                                     (2, 'DL122'),
                                                                     (1, 'DL143'),
                                                                     (3, 'DL122'),
                                                                     (3, 'DL53'),
                                                                     (1, 'DL143'),
                                                                     (4, 'DL143'),
    (1, 'DL143'),
                                                                    (3, 'DL222'),
                                                                     (5, 'DL143'),
                                                                     (4, 'DL143'),
                                                                     (6, 'DL222'),
                                                                     (7, 'DL222'),
                                                                     (5, 'DL122'),
                                                                     (4, 'DL37'),
(8, 'DL222');







SELECT flight_number, COUNT(*)
FROM flight
GROUP BY flight_number;

SELECT flight_number, AVG(flight_mileage)
FROM flight
GROUP BY flight_number;

SELECT aircraft_name,AVG(aircraft_number_of_seats)
FROM aircraft
GROUP BY aircraft_name;
;

SELECT customer_status, customer_name, AVG(customer_Total_mileage) AS avg_mileage
FROM customer
GROUP BY customer_status
;

SELECT customer_status, MAX(customer_Total_mileage)
FROM customers
GROUP BY customer_status
    ;

SELECT aircraft_name, COUNT(*)
FROM aircraft
WHERE aircraft_name LIKE '%Boeing%'
GROUP BY aircraft_name
;

SELECT COUNT(*)
    FROM flight
    WHERE flight_mileage >= 300 AND flight_mileage <= 2000
;

SELECT c.customer_status, AVG(flight_mileage)
FROM booking b
         JOIN customer c ON b.booking_customer_id = c.customer_id
         JOIN flight f ON b.booking_flight_number = f.flight_number
GROUP BY customer_status
;

SELECT a.aircraft_name, COUNT(*) AS total_bookings
FROM booking b
         JOIN customers c ON b.booking_customer_id = c.customer_id
         JOIN flight f ON b.booking_flight_number = f.flight_number
         JOIN aircraft a ON f.flight_aircraft_name = a.aircraft_name
WHERE c.customer_status = 'Gold'
GROUP BY a.aircraft_name
ORDER BY total_bookings DESC
LIMIT 5;