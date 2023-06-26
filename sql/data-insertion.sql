--  =================================================================================
--	Purpose:    Create database for cityconnect bus
--  Author:     Yuna Ukawa
--  Date:       May 8, 2023
--  =================================================================================

--  ======== USER GUIDE =============================================================
--  1.  Excecute 'CREATE DATABASE cityconnect;' in a new query first.
--  2.  Open CityConnectBus.sql in the zip file.
--  3.  Excecute the query.
--  4.  The database is now ready to be used.
--  5.  If you want to excecute the query again, uncomment 'DROP TABLE' statements.
--      The order of these statements MATTERS due to foreign key constraints.
--  6.  To access the userViews, they can be found in the file labeled userView#.sql
--      with the corresponding number to the view you want to see!
--  =================================================================================

--CREATE DATABASE cityconnect;
USE cityconnect;
--DROP TABLE fleet_management;
--DROP TABLE salary;
--DROP TABLE customer_history;
--DROP TABLE timetable;
--DROP TABLE driver;
--DROP TABLE bus;
--DROP TABLE stops;
--DROP TABLE customer;
--DROP TABLE routes;
--DROP TABLE stations;

CREATE TABLE stations
( station_id    smallint,
  station_name  varchar(20),
  CONSTRAINT st_pk_stid PRIMARY KEY (station_id)
);
INSERT INTO stations
VALUES (1, 'Est'), (2, 'Meadow Park'), (3, 'Central Terminal'), (4, 'Downtown Square'), (5, 'Lake View'), (6, 'River Reach'), (7, 'West Bridge');
SELECT * FROM stations;

CREATE TABLE routes
( route_id      smallint,
  route_name    varchar(20),
  origin_id     smallint,
  dest_id       smallint,
  CONSTRAINT rt_pk_rtid PRIMARY KEY (route_id),
  CONSTRAINT rt_fk_orid FOREIGN KEY (origin_id) REFERENCES stations(station_id),
  CONSTRAINT rt_fk_dstid FOREIGN KEY (dest_id) REFERENCES stations(station_id)
);
INSERT INTO routes
VALUES (1, 'Main', 1, 5), (2, 'Main', 5, 1), (3, 'River', 1, 7), (4, 'River', 7, 1);
SELECT * FROM routes;

CREATE TABLE stops
( station_id    smallint,
  route_id      smallint,
  stop_num      smallint,
  CONSTRAINT stop_pk PRIMARY KEY (station_id, route_id),
  CONSTRAINT stop_fk_stid FOREIGN KEY (station_id) REFERENCES stations(station_id),
  CONSTRAINT stop_fk_rtid FOREIGN KEY (route_id) REFERENCES routes(route_id)
);
INSERT INTO stops
VALUES (1, 1, 1), (1, 2, 2), (1, 3, 1), (1, 4, 2),
       (2, 1, 1), (2, 2, 2), (2, 3, 1), (2, 4, 2),
       (3, 1, 1), (3, 2, 2), (3, 3, 3), (3, 4, 2),
       (4, 1, 1), (4, 2, 2),
       (5, 1, 1), (5, 2, 2),
       (6, 3, 1), (6, 4, 2),
       (7, 3, 1), (7, 4, 2);
SELECT * FROM stops;

CREATE TABLE bus
( bus_id    int,
  make      varchar(30),
  model     varchar(30),
  yr        int,
  CONSTRAINT bus_pk_busid PRIMARY KEY (bus_id)
);
INSERT INTO bus VALUES 
(350001, 'Mitsubishi', 'Aero Ace', 2019),
(350002, 'Mitsubishi', 'Aero Ace', 2019),
(350003, 'Mitsubishi', 'Aero Star', 2021),
(350004, 'Mitsubishi', 'Aero Star', 2021),
(400005, 'Nissan', 'Civilian', 2021),
(400006, 'Mitsubishi', 'Aero Star', 2022),
(400007, 'Hino', 'Selega', 2023);
SELECT * FROM bus;

CREATE TABLE driver
( driver_id     int,
  driver_name   varchar(30),
  CONSTRAINT dr_pk_drid PRIMARY KEY (driver_id)
);
INSERT INTO driver
VALUES (350001, 'Teddy Park'), (350002, 'Sophia Nguyen'), (350003, 'Jackson Chen'), (360004, 'Isabella Patel');
SELECT * FROM driver;

CREATE TABLE customer
( customer_id     int,
  customer_name   varchar(30),
  CONSTRAINT cus_pk_cusid PRIMARY KEY (customer_id)
);
INSERT INTO customer
VALUES (350001, 'Yuna Ukawa'), (360002, 'Liam Rodriguez');
SELECT * FROM customer;

CREATE TABLE timetable
( timetable_id      int,
  route_id          smallint,
  bus_id            int,
  driver_id         int,
  est               time,
  meadow_park       time,
  central_terminal  time,
  downtown_square   time,
  lake_view         time,
  river_reach       time,
  west_bridge       time,
  CONSTRAINT tt_pk_ttid PRIMARY KEY (timetable_id),
  CONSTRAINT tt_fk_rtid FOREIGN KEY (route_id) REFERENCES routes(route_id),
  CONSTRAINT tt_fk_busid FOREIGN KEY (bus_id) REFERENCES bus(bus_id),
  CONSTRAINT tt_fk_drid FOREIGN KEY (driver_id) REFERENCES driver(driver_id)
);
INSERT INTO timetable VALUES
(1, 1, 350004, 350001, '5:00', '5:10', '5:30', '5:35', '5:45', NULL, NULL),
(2, 2, 350004, 350001, '6:45', '6:35', '6:15', '6:10', '6:00', NULL, NULL),
(3, 1, 350002, 360004, '6:00', '6:10', '6:30', '6:35', '6:45', NULL, NULL),
(4, 2, 350002, 360004, '7:45', '7:35', '7:15', '7:10', '7:00', NULL, NULL),
(5, 1, 350004, 350001, '7:00', '7:10', '7:30', '7:35', '7:45', NULL, NULL),
(6, 2, 350004, 350001, '8:45', '8:35', '8:15', '8:10', '8:00', NULL, NULL),
(7, 1, 350002, 360004, '8:00', '8:10', '8:30', '8:35', '8:45', NULL, NULL),
(8, 2, 350002, 360004, '9:45', '9:35', '9:15', '9:10', '9:00', NULL, NULL),
(9, 1, 350004, 350002, '9:00', '9:10', '9:30', '9:35', '9:45', NULL, NULL),
(10, 2, 350004, 350002, '10:45', '10:35', '10:15', '10:10', '10:00', NULL, NULL),
(11, 1, 350002, 360004, '10:00', '10:10', '10:30', '10:35', '10:45', NULL, NULL),
(12, 2, 350002, 360004, '11:45', '11:35', '11:15', '11:10', '11:00', NULL, NULL),
(13, 1, 350004, 350002, '11:00', '11:10', '11:30', '11:35', '11:45', NULL, NULL),
(14, 2, 350004, 350002, '12:45', '12:35', '12:15', '12:10', '12:00', NULL, NULL),
(15, 1, 350002, 360004, '12:00', '12:10', '12:30', '12:35', '12:45', NULL, NULL),
(16, 4, 400005, 350002, '7:00', '6:50', '6:30', NULL, NULL, '6:15', '6:05'),
(17, 3, 400005, 350002, '7:15', '7:25', '7:45', NULL, NULL, '8:00', '8:10'),
(18, 4, 400007, 350003, '8:05', '7:55', '7:35', NULL, NULL, '7:20', '7:10'),
(19, 3, 400007, 350003, '8:20', '8:30', '8:50', NULL, NULL, '9:05', '9:15'),
(20, 4, 400005, 350003, '10:15', '10:05', '9:45', NULL, NULL, '9:30', '9:20'),
(21, 3, 400005, 350001, '9:25', '9:35', '9:55', NULL, NULL, '10:10', '10:20'),
(22, 4, 400005, 350001, '11:20', '11:10', '10:50', NULL, NULL, '10:35', '10:25'),
(23, 3, 400007, 350003, '10:30', '10:40', '11:00', NULL, NULL, '11:15', '11:25'),
(24, 4, 400007, 350003, '12:25', '12:15', '11:55', NULL, NULL, '11:40', '11:30'),
(25, 3, 400005, 350001, '11:35', '11:45', '12:05', NULL, NULL, '12:20', '12:30'),
(26, 4, 400005, 350001, '13:30', '13:20', '13:00', NULL, NULL, '12:45', '12:35'),
(27, 3, 400007, 350003, '12:40', '12:50', '13:10', NULL, NULL, '13:25', '13:35');
SELECT * FROM timetable;

CREATE TABLE customer_history
( history_id        int,
  customer_id       int,
  date_time         datetime2,
  enter_station_id  smallint,
  exit_station_id   smallint,
  charges           smallmoney,
  credits           smallmoney,
  balance           smallmoney,
  CONSTRAINT his_pk_hisid PRIMARY KEY (history_id),
  CONSTRAINT his_fk_cusid FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
  CONSTRAINT his_fk_entr FOREIGN KEY (enter_station_id) REFERENCES stations(station_id),
  CONSTRAINT his_fk_exit FOREIGN KEY (exit_station_id) REFERENCES stations(station_id)
);
INSERT INTO customer_history VALUES
(1, 350001, '2040-04-28 12:20', 1, 4, 2.40, 0, 6.00),
(2, 350001, '2040-04-28 20:30', 4, 1, 2.40, 0, 3.60),
(3, 350001, '2040-05-02 09:20', 1, 3, 1.60, 0, 2.00),
(4, 350001, '2040-05-04 09:20', 1, 3, 1.60, 0, 0.40),
(5, 350001, '2040-05-04 20:40', NULL, NULL, 0, 50.00, 48.80),
(6, 350001, '2040-05-04 20:45', 3, 1, 1.60, 0, 48.80);
SELECT * FROM customer_history;

CREATE TABLE salary
( yr            int,
  mnth          char(3),
  driver_id     int,
  hourly        smallmoney,
  hrs           smallint,
  CONSTRAINT slry_pk PRIMARY KEY (yr, mnth, driver_id),
  CONSTRAINT slry_fk_drid FOREIGN KEY (driver_id) REFERENCES driver(driver_id)
);
INSERT INTO salary VALUES
(2040, 'APR', 350001, 25.30, 177),
(2040, 'APR', 350002, 18.00, 100),
(2040, 'APR', 350003, 18.00, 80),
(2040, 'APR', 360004, 16.20, 111);
SELECT * FROM salary;

CREATE TABLE fleet_management
( bus_id        int,
  maintenance   date,
  CONSTRAINT flmg_pk PRIMARY KEY (bus_id, maintenance),
  CONSTRAINT flmg_fk_busid FOREIGN KEY (bus_id) REFERENCES bus(bus_id)
);
INSERT INTO fleet_management VALUES 
(350001, '2040-04-10'),
(350002, '2040-04-10'),
(350003, '2040-04-15'),
(350004, '2040-04-15'),
(400005, '2040-05-01'),
(400005, '2040-02-03'),
(400006, '2040-05-01'),
(400007, '2040-02-07'),
(400007, '2040-05-07');
SELECT * FROM fleet_management;
