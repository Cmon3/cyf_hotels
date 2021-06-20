DROP TABLE IF EXISTS bank_details;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS hotels;

CREATE TABLE customers (
  id        SERIAL PRIMARY KEY,
  name      VARCHAR(30) NOT NULL,
  email     VARCHAR(120) NOT NULL,
  address   VARCHAR(120),
  city      VARCHAR(30),
  postcode  VARCHAR(12),
  country   VARCHAR(20)
);

create table hotels (
	id 			SERIAL primary key,
	hotel_name 	VARCHAR(30) not NULL,
	rooms 		INT,
	postcode 	VARCHAR(12)
);

CREATE TABLE bookings (
  id               SERIAL PRIMARY KEY,
  customer_id      INT REFERENCES customers(id),
  hotel_id         INT REFERENCES hotels(id),
  checkin_date     DATE NOT NULL,
  nights           INT NOT NULL
);

create table bank_details (
	id			SERIAL primary key,
	customer_id INT references customers(id),
	bank_name 	VARCHAR(30),
	iban_code 	VARCHAR(20) not NULL	
);



INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('John Smith','j.smith@johnsmith.org','11 New Road','Liverpool','L10 2AB','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Simon L','ccccc@gmail.com','11 New Road','Barcelona','L10 2AB','Spain');
INSERT INTO hotels (hotel_name, rooms, postcode) VALUES ('Triple Point Hotel', 10, 'CM194JS');
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (1, 1, '2019-10-01', 2);

INSERT INTO hotels (hotel_name, rooms, postcode) values ('Royal Cosmos Hotel', 5, 'TR209AX'); 
INSERT INTO hotels (hotel_name, rooms, postcode) values ('Pacific Petal Motel', 15, 'BN180TG');

SELECT * FROM customers;
SELECT * FROM hotels;
SELECT * FROM bookings;

SELECT name,address FROM customers;
SELECT * FROM hotels WHERE rooms > 7;
SELECT name,address FROM customers WHERE id = 1;
SELECT * FROM bookings WHERE checkin_date > '2019/10/01';
SELECT * FROM bookings WHERE checkin_date > '2019/10/01' AND nights >= 2;
SELECT * FROM hotels WHERE postcode = 'CM194JS' OR postcode = 'TR209AX';

select * from customers where name = 'Laurence Lebihan';
select name from customers where country = 'UK';
select address, city, postcode from customers where name = 'Melinda Marsh';
select * from hotels where postcode = 'DGQ127';
select * from hotels where rooms > 11;
select * from hotels where rooms > 6 and rooms < 15;
select * from hotels where rooms = 10 or rooms = 20;
select * from bookings where customer_id = 1;
select * from bookings where nights > 4;
select * from bookings where checkin_date > '2020-01-01';
select * from bookings where checkin_date < '2020-01-01' and nights < 4;





