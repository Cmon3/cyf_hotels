drop table if exists bookings;
drop table if exists hotels;
drop table if exists customers;

CREATE TABLE customers (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(30) NOT NULL,
  email    VARCHAR(120) NOT NULL,
  address  VARCHAR(120),
  city     VARCHAR(30),
  postcode VARCHAR(12),
  country  VARCHAR(20)
);

CREATE TABLE hotels (
  id       SERIAL PRIMARY KEY,
  name     VARCHAR(120) NOT NULL,
  rooms    INT NOT NULL,
  postcode VARCHAR(10)
);

CREATE TABLE bookings (
  id            SERIAL PRIMARY KEY,
  customer_id   INT REFERENCES customers(id),
  hotel_id      INT REFERENCES hotels(id),
  checkin_date  DATE NOT NULL,
  nights        INT NOT NULL
);

INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('John Smith','j.smith@johnsmith.org','11 New Road','Liverpool','L10 2AB','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Sue Jones','s.jones1234@gmail.com','120 Old Street','London','N10 3CD','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Alice Evans','alice.evans001@hotmail.com','3 High Road','Manchester','m13 4ef','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Mohammed Trungpa','mo.trungpa@hotmail.com','25 Blue Road','Manchester','M25 6GH','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Steven King','steve.king123@hotmail.com','19 Bed Street','Newtown', 'xy2 3ac','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Nadia Sethuraman','nadia.sethuraman@mail.com','135 Green Street','Manchester','M10 4BG','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Melinda Marsh','mel.marsh-123@gmail.com','7 Preston Road','Oldham','OL3 5XZ','UK');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('MartÃ­n Sommer','martin.sommer@dfgg.net','C/ Romero, 33','Madrid','28016','Spain');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Laurence Lebihan','laurence.lebihan@xmzx.net','12, rue des Bouchers','Marseille','13008','France');
INSERT INTO customers (name, email, address, city, postcode, country) VALUES ('Keith Stewart','keith.stewart@gmail.com','84 Town Lane','Tadworth','td5 7ng','UK');

INSERT INTO hotels (name, rooms, postcode) VALUES ('Golden Cavern Resort', 10, 'L10ABC');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Elder Lake Hotel', 5, 'L10ABC');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Pleasant Mountain Hotel', 7, 'ABCDE1');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Azure Crown Resort & Spa', 18, 'DGQ127');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Jade Peaks Hotel', 4, 'DGQ127');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Elegant Resort', 14, 'DGQ127');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Cozy Hotel', 20, 'AYD189');
INSERT INTO hotels (name, rooms, postcode) VALUES ('Snowy Echo Motel', 15, 'AYD189');

INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (1, 1, '2019-10-01', 2);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (1, 1, '2019-12-10', 6);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (1, 3, '2019-07-20', 4);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (2, 3, '2020-03-10', 4);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (2, 5, '2020-04-01', 1);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (3, 1, '2019-11-01', 1);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (3, 2, '2019-11-23', 2);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (4, 8, '2019-12-23', 3);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (4, 2, '2019-09-16', 5);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (6, 5, '2019-09-14', 2);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (6, 6, '2020-01-14', 5);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (8, 4, '2020-02-01', 3);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (8, 5, '2020-01-03', 7);
INSERT INTO bookings (customer_id, hotel_id, checkin_date, nights) VALUES (8, 8, '2019-12-25', 4);

---SECOND WEEK EXERCISES

ALTER TABLE customers ADD COLUMN date_of_birth DATE;
ALTER TABLE customers RENAME column date_of_birth TO birthdate;
ALTER TABLE customers DROP COLUMN birthdate;

CREATE TABLE test;
DROP TABLE test;

UPDATE hotels SET postcode='L10XYZ' WHERE name='Elder Lake Hotel';
SELECT * FROM hotels;
update hotels h set h.rooms=25 where h.name='Cozy Hotel';
select * from customers;
update customers set address='2 Blue Street', city='Glasgow', postcode='G11ABC' where name='Nadia Sethuraman';
update bookings set nights=5 where customer_id=1 and hotel_id=1;
select nights from bookings where customer_id=1 and hotel_id=1;

DELETE FROM bookings WHERE customer_id=8 and checkin_date='2020-01-03';
DELETE FROM bookings WHERE customer_id=6;
DELETE FROM customers WHERE id=6;

select h."name", c."name", b.checkin_date, b.nights from bookings b 
inner join customers c on c.id = b.customer_id 
inner join hotels h on h.id = b.hotel_id; 

select * from bookings b
inner join customers c on c.id = b.customer_id 
inner join hotels h on h.id = b.hotel_id 
where c.email = 'j.smith@johnsmith.org'

select * from hotels h;

---Exercise 5

select * from bookings b 
inner join customers c on c.id = b.customer_id 
where b.checkin_date > '2020-01-01'

select c."name", b.checkin_date, b.nights from customers c 
inner join bookings b on b.customer_id = c.id 
inner join hotels h on h.id = b.hotel_id 
where h."name" = 'Jade Peaks Hotel'; 

select b.checkin_date, c."name", h."name", b.nights from bookings b 
inner join customers c on c.id = b.customer_id 
inner join hotels h on h.id = b.hotel_id 
where b.nights >= 5;

---Exercise 6

select * from customers c 
where c."name" LIKE 'S%'; 

select * from hotels h 
where h."name" like '%Hotel%';

select b.checkin_date, c."name", h."name", b.nights from bookings b 
inner join customers c on c.id = b.customer_id 
inner join hotels h on h.id = b.hotel_id 
ORDER BY b.nights DESC
limit 5;

---Class 30/06/21
INSERT INTO hotels (name, rooms, postcode) VALUES ('New Hotel', 5, 'ABC001') returning id as hotelId;
SELECT * FROM hotels ORDER BY name;
SELECT * FROM hotels WHERE name LIKE 'New Hotel' ORDER BY name;

---Class 03/07/21
SELECT * FROM customers WHERE name='John Smith';
SELECT * FROM customers ORDER BY name;
SELECT * FROM customers WHERE id=1;

SELECT b.checkin_date, b.nights, h."name", h.postcode FROM bookings b 
inner join customers c on c.id = b.customer_id 
inner join hotels h on h.id = b.hotel_id
where customer_id =3;

UPDATE customers c SET email='j.smith@johnsmith.org' WHERE c.id=3 returning c.id, c.email;
UPDATE customers c SET c.name='Otelo Perez', email='fbdhfb@gmail.com', address='This street', city='Bcn', postcode='hdhd123', country='Spain' WHERE c.id=2;

DELETE FROM bookings WHERE customer_id=3;
DELETE FROM customers WHERE id=3;

DELETE FROM bookings WHERE hotel_id=1;
DELETE FROM hotels WHERE id=1;