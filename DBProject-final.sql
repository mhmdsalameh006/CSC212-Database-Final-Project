--1 DB CREATION 
CREATE DATABASE LAB_MGMT_SYST ;
USE LAB_MGMT_SYST ;

--2 CREATE TABLE

CREATE TABLE campus
(
    campus_id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE laboratory 
(
    lab_id INT PRIMARY KEY,
    name VARCHAR(100),
    floor_number INT,
    lab_type VARCHAR(50),
    capacity INT,
    campus_id INT,
    FOREIGN KEY (campus_id) REFERENCES campus(campus_id)
);

CREATE TABLE users 
(
    user_id INT PRIMARY KEY,
    first_name VARCHAR (20),
    middle_name VARCHAR (20),
    last_name VARCHAR (20),
    email VARCHAR(100),
    role VARCHAR(20)
);

CREATE TABLE course 
(
    course_id INT PRIMARY KEY,
    course_code VARCHAR(10),
    course_name VARCHAR(100),
    course_date DATE,
    course_time TIME
);
-- I faced an error in insterting data so i had to drop all the tables that have any connections ( foreign key with the course table)
DROP TABLE booking_creation;
DROP TABLE booking;
DROP TABLE course;

CREATE TABLE course 
(
    course_id INT PRIMARY KEY,
    course_code VARCHAR(10),
    course_name VARCHAR(100),
    course_date VARCHAR(20),
    course_time TIME
);

CREATE TABLE booking
(
    booking_id INT PRIMARY KEY,
    start_datetime DATETIME,
    end_datetime DATETIME,
    user_id INT,
    lab_id INT,
    course_id INT UNIQUE, 
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (lab_id) REFERENCES laboratory(lab_id),
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE equipment
(
    equipment_id INT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(80),
    status VARCHAR(30),
    lab_id INT,
    FOREIGN KEY (lab_id) REFERENCES laboratory(lab_id)
);

CREATE TABLE booking_creation
(
    creation_id INT PRIMARY KEY,
    user_id INT,
    booking_id INT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (booking_id) REFERENCES booking(booking_id)
);

--3 Inserting Data

INSERT INTO campus VALUES
(1, 'Cola');

INSERT INTO laboratory VALUES
(200, 'Computer Lab', 2, 'Interior & Graphic Design', 24, 1),
(201, 'Electronics Lab', 2, 'Engineering & Sciences', 24, 1),
(202, 'Networking Lab', 2, 'Engineering & Sciences ', 24, 1),
(204, ' Computer Lab' , 2 , 'Business' , 24, 1),
(205, ' Computer Lab' , 2 , 'Engineering & Sciences' , 24, 1),
(206, ' Computer Lab' , 2 , 'Engineering & Sciences' , 24, 1),
(207, ' Computer Lab' , 2 , 'Interior & Graphic Design' , 24, 1),
(715, 'HVAC', 7, 'Engineering', 24, 1),
(800, 'Analog Communication', 8, 'Engineering', 24, 1),
(801, 'Combustion Engine', 8, 'Engineering ', 24, 1),
(802, 'Dynamics of Machinary', 8, 'Engineering', 24, 1),
(804, ' Robotics ' , 8 , 'Engineering' , 24, 1),
(805, ' Simulation Lab' , 8 , 'Engineering ' , 24, 1),
(815, ' Manifacturing Process Lab' , 8 , 'Engineering' , 24, 1);

INSERT INTO users VALUES
(1, 'Ibrahim','',' Hamid', 'Ibrahim.Hamid@aul.edu.lb', 'Administrator'),
(2, 'Mohammd Omar','Gh','Salame', 'mohamad.salameh@aul.edu.lb', 'Administrator'),
(3, 'Sandy','Ma' ,'Al Cheikh', 'sma002@live.aul.edu.lb', 'Administrator'),
(4, ' Ziad' ,' ' ,'Miski' , 'ziad.miski@aul.edu.lb' , ' Certiport Admin'),
(5 , ' Noura', ' ' ,'Al Rifai' , 'na016@live.aul.edu.lb', ' Instructor '),
(6, ' Issa' , '  ','Kamar' , 'km001@live.aul.edu.lb' , 'Instructor') ,
(7, ' Sahar' ,' ' ,' Shebaro','ss004@live.aul.edu.lb', 'Instructor'),
(8, 'Khaled' ,' ' , 'Ghoson' , '---', 'Instructor'),
(9, 'Khaled' ,' ', ' Al Zein' , '---', 'Instructor'),
(10, 'Tarek' , ' '  ,'Al Masri' , '---', 'Instructor'),
(11, 'Haneen', ' ' ,'Al Meer' , '---', 'Instructor');


INSERT INTO course VALUES
(111, 'CSC222L', 'Database Systems Lab', 'F', '8:00:00'),
(112, 'CCN211', 'Networking 1', 'TTH', '11:00:00'),
(113, 'CCN211L', 'Networking 1 Lab', 'F', '12:30:00'),
(114, 'MIS212L' ,' MIS Lab', 'F' , '8:00:00');

INSERT INTO booking VALUES
(202025001, '2026-02-10 80:00:00', '2026-02-10 9:30:00', 5, 206, 111);
INSERT INTO booking VALUES
(202025002, '2026-02-11 12:30:00', '2026-02-11 2:00:00', 6, 205, 113);

INSERT INTO equipment VALUES
(001, 'Dell PC', 'Computer', 'Available', 101),
(002, 'Oscilloscope', 'Electronics', 'Maintenance', 102),
(003, 'Router', 'Networking', 'In Use', 103);
-- can be enhanced by adding a column for the quantity and adding another column for the location of the equipment ( in which lab)

-- 4 Extras 
UPDATE equipment
SET status = 'Available'
WHERE equipment_id = 002;

SELECT * FROM laboratory;
SELECT first_name, middle_name, last_name, email FROM users;
SELECT * FROM booking;



SELECT
    l.lab_id,
    l.name AS lab_name,
    l.floor_number,
    c.name AS campus_name
FROM laboratory l
INNER JOIN campus c ON l.campus_id = c.campus_id;


SELECT 
    b.booking_id,
    u.first_name,
    u.last_name,
    l.name AS lab_name,
    b.start_datetime,
    b.end_datetime
FROM booking b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN laboratory l ON b.lab_id = l.lab_id;

SELECT
    b.booking_id,
    c.course_code,
    c.course_name,
    b.start_datetime,
    b.end_datetime
FROM booking b
INNER JOIN course c ON b.course_id = c.course_id;

CREATE VIEW vw_booking_report AS
SELECT
    b.booking_id,
    b.start_datetime,
    b.end_datetime,
    u.first_name,
    u.middle_name,
    u.last_name,
    l.name AS lab_name,
    l.floor_number,
    c.name AS campus_name
FROM booking b
INNER JOIN users u ON b.user_id = u.user_id
INNER JOIN laboratory l ON b.lab_id = l.lab_id
INNER JOIN campus c ON l.campus_id = c.campus_id;
