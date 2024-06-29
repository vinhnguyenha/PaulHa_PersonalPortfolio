CREATE  SCHEMA carpark_management;
USE carpark_management;

-- TABLE For Car Park
CREATE TABLE IF NOT EXISTS `Car_park` (
	`car_park_id` INT UNSIGNED NOT NULL, -- can't contain null values or negative numbers
    `map_reference` VARCHAR(10) NOT NULL, -- can't contain null values
    `car_park_description` VARCHAR(200) NULL, -- can contain null values
    PRIMARY KEY (car_park_id)
);

-- TABLE For Swipe Card
CREATE TABLE IF NOT EXISTS `Swipe_card` (
	`swipe_card_id` INT UNSIGNED NOT NULL,
    `name_on_card` VARCHAR(100) NOT NULL,
	`staff_number` 	VARCHAR(10) NULL,
    `contact_phone` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`swipe_card_id`)
);

-- TABLE For Spot Reservation Parking Area
CREATE TABLE IF NOT EXISTS `Spot_reservation_parking_area`(
	`parking_area_id` INT UNSIGNED NOT NULL,
    `car_park_id` INT UNSIGNED NOT NULL,
    `area_name` VARCHAR(45) NULL,
    PRIMARY KEY (`parking_area_id`),
    INDEX `fk_spot_reservation_parking_area_car_park_id_idx` (`car_park_id` ASC) VISIBLE,
    CONSTRAINT `fk_spot_reservation_parking_area_car_park_id`
		FOREIGN KEY (`parking_area_id`)
        REFERENCES `Car_park` (`car_park_id`)
);

-- TABLE For Spot Area Entry Attempt
CREATE TABLE IF NOT EXISTS `Spot_Area_Entry_Attempt`(
	`attempt_id` INT UNSIGNED NOT NULL, -- can't contain null values or negative numbers
    `swipe_card_id` INT UNSIGNED NOT NULL,
    `parking_area_id` INT UNSIGNED NOT NULL,
    `date and time of entry` DATETIME NOT NULL,
    PRIMARY KEY (`attempt_id`),
    INDEX `fk_spot_area_entry_attempt_swipe_card_idx` (`swipe_card_id` ASC) VISIBLE,
    INDEX `fk_spot_area_entry_attempt_parking_area_id_idx` (`parking_area_id` ASC) VISIBLE,
    CONSTRAINT `fk_spot_area_entry_attempt_swipe_card`
		FOREIGN KEY (`swipe_card_id`)
        REFERENCES `Swipe_card` (`swipe_card_id`),
	CONSTRAINT `fk_spot_area_entry_attempt_parking_area_id`
		FOREIGN KEY (`parking_area_id`)
        REFERENCES `Spot_reservation_parking_area` (`parking_area_id`)
);

-- TABLE For Car
CREATE TABLE IF NOT EXISTS `Car` (
	`car_number_plate` VARCHAR(10) NOT NULL,
    `car_brand` VARCHAR(45) NOT NULL,
    `car_model`	VARCHAR(45) NOT NULL,
    PRIMARY KEY (`car_number_plate`)
);

-- TABLE For Spot Reservation
CREATE TABLE IF NOT EXISTS `Spot_reservation` (
	`spot_reservation_id` INT UNSIGNED NOT NULL,
    `swipe_card_id` INT UNSIGNED NOT NULL,
    `car_number_plate` VARCHAR(10) NOT NULL,
    `payment_amount` DECIMAL(5,2) NOT NULL,
    `when_created` DATETIME NOT NULL,
    PRIMARY KEY (`spot_reservation_id`),
    INDEX `fk_spot_reservation_swipe_card_id_idx` (`swipe_card_id` ASC) VISIBLE,
    INDEX `fk_spot_reservation_car_number_plate_idx` (`car_number_plate` ASC) VISIBLE,
    CONSTRAINT `fk_spot_reservation_swipe_card_id`
		FOREIGN KEY (`swipe_card_id`)
        REFERENCES `Swipe_card` (`swipe_card_id`),
	CONSTRAINT `fk_spot_reservation_car_number_plate`
		FOREIGN KEY (`car_number_plate`)
        REFERENCES `Car` (`car_number_plate`)
);

-- TABLE For Timeslot
CREATE TABLE IF NOT EXISTS `Timeslot` (
	`year` YEAR NOT NULL,
    `semester` CHAR(2) NOT NULL,
    PRIMARY KEY (`year`, `semester`)
);

-- TABLE For Numbered parking spot
CREATE TABLE IF NOT EXISTS `Numbered_parking_spot` (
	`parking_spot_id` INT UNSIGNED NOT NULL,
    `parking_area_id` INT UNSIGNED NOT NULL,
    `location_description` VARCHAR(100) NULL,
    PRIMARY KEY (`parking_spot_id`),
    INDEX `fk_numbered_parking_spot_parking_area_id_idx` (`parking_area_id` ASC) VISIBLE,
    CONSTRAINT `fk_numbered_parking_spot_parking_area_id`
		FOREIGN KEY (`parking_area_id`)
        REFERENCES `Spot_reservation_parking_area` (`parking_area_id`)
);

-- TABLE For Allocation
CREATE TABLE IF NOT EXISTS `Allocation` (
	`parking_spot_id` INT UNSIGNED NOT NULL,
	`year` YEAR NOT NULL,
    `semester` CHAR(2) NOT NULL,
    `spot_reservation_id` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`parking_spot_id`, `year`, `semester`),
	INDEX `fk_Allocation_Timeslot_idx` (`year` ASC, `semester` ASC) VISIBLE,
	INDEX `fk_allocation_spot_reservation_id_idx` (`spot_reservation_id` ASC) VISIBLE,
    CONSTRAINT `fk_allocation_parking_spot_id`
		FOREIGN KEY (`parking_spot_id`)
        REFERENCES `Numbered_parking_spot` (`parking_spot_id`),    
    CONSTRAINT `fk_allocation_year`
		FOREIGN KEY (`year`)
        REFERENCES `Timeslot` (`year`) , 
	CONSTRAINT `fk_Allocation_Timeslot`
		FOREIGN KEY (`year` , `semester`)
		REFERENCES `Timeslot` (`year` , `semester`),
    CONSTRAINT `fk_allocation_reservation_id`
		FOREIGN KEY (`spot_reservation_id`)
        REFERENCES `Spot_reservation` (`spot_reservation_id`) 
);

-- Insert data into Car_park table
INSERT INTO `Car_park` (`car_park_id`, `map_reference`, `car_park_description`) VALUES
(1, 'A1', 'Main Car Park - North Wing'),
(2, 'A2', 'Main Car Park - East Wing'),
(3, 'A3', 'Main Car Park - South Wing'),
(4, 'B1', 'Secondary Car Park - North Wing'),
(5, 'B2', 'Secondary Car Park - East Wing'),
(6, 'B3', 'Secondary Car Park - South Wing'),
(7, 'C1', 'Overflow Car Park - Area 1'),
(8, 'C2', 'Overflow Car Park - Area 2'),
(9, 'C3', 'Overflow Car Park - Area 3'),
(10, 'D1', 'VIP Car Park - North Wing'),
(11, 'D2', 'VIP Car Park - East Wing'),
(12, 'D3', 'VIP Car Park - South Wing'),
(13, 'E1', 'Staff Car Park - North Wing'),
(14, 'E2', 'Staff Car Park - East Wing'),
(15, 'E3', 'Staff Car Park - South Wing'),
(16, 'F1', 'Visitor Car Park - Area 1'),
(17, 'F2', 'Visitor Car Park - Area 2'),
(18, 'F3', 'Visitor Car Park - Area 3'),
(19, 'G1', 'Event Car Park - Area 1'),
(20, 'G2', 'Event Car Park - Area 2');

-- Insert data into Swipe_card table
INSERT INTO `Swipe_card` (`swipe_card_id`, `name_on_card`, `staff_number`, `contact_phone`) VALUES
(1, 'John Doe', 'S123456', '555-1234'),
(2, 'Jane Smith', 'S654321', '555-5678'),
(3, 'Robert Brown', 'S789012', '555-9012'),
(4, 'Emily Davis', 'S345678', '555-3456'),
(5, 'Michael Wilson', 'S901234', '555-7890'),
(6, 'Sarah Johnson', 'S567890', '555-1235'),
(7, 'David Taylor', 'S234567', '555-5679'),
(8, 'Laura Martinez', 'S890123', '555-9013'),
(9, 'James Anderson', 'S456789', '555-3457'),
(10, 'Sophia Thomas', 'S012345', '555-7891'),
(11, 'Daniel Lee', 'S678901', '555-1236'),
(12, 'Olivia Harris', 'S234568', '555-5670'),
(13, 'Matthew Clark', 'S890124', '555-9014'),
(14, 'Ava Lewis', 'S456790', '555-3458'),
(15, 'Andrew Robinson', 'S012346', '555-7892'),
(16, 'Isabella Walker', 'S678902', '555-1237'),
(17, 'Joshua Young', 'S234569', '555-5671'),
(18, 'Amelia King', 'S890125', '555-9015'),
(19, 'William Wright', 'S456791', '555-3459'),
(20, 'Mia Scott', 'S012347', '555-7893');

-- Insert data into Spot_reservation_parking_area table
INSERT INTO `Spot_reservation_parking_area` (`parking_area_id`, `car_park_id`, `area_name`) VALUES
(1, 1, 'Area A'),
(2, 1, 'Area B'),
(3, 2, 'Area C'),
(4, 2, 'Area D'),
(5, 3, 'Area E'),
(6, 3, 'Area F'),
(7, 4, 'Area G'),
(8, 4, 'Area H'),
(9, 5, 'Area I'),
(10, 5, 'Area J'),
(11, 6, 'Area K'),
(12, 6, 'Area L'),
(13, 7, 'Area M'),
(14, 7, 'Area N'),
(15, 8, 'Area O'),
(16, 8, 'Area P'),
(17, 9, 'Area Q'),
(18, 9, 'Area R'),
(19, 10, 'Area S'),
(20, 10, 'Area T');

-- Insert data into Spot_Area_Entry_Attempt table
INSERT INTO `Spot_Area_Entry_Attempt` (`attempt_id`, `swipe_card_id`, `parking_area_id`, `date and time of entry`) VALUES
(1, 1, 1, '2024-06-27 08:00:00'),
(2, 2, 2, '2024-06-27 08:05:00'),
(3, 3, 3, '2024-06-27 08:10:00'),
(4, 4, 4, '2024-06-27 08:15:00'),
(5, 5, 5, '2024-06-27 08:20:00'),
(6, 6, 6, '2024-06-27 08:25:00'),
(7, 7, 7, '2024-06-27 08:30:00'),
(8, 8, 8, '2024-06-27 08:35:00'),
(9, 9, 9, '2024-06-27 08:40:00'),
(10, 10, 10, '2024-06-27 08:45:00'),
(11, 11, 11, '2024-06-27 08:50:00'),
(12, 12, 12, '2024-06-27 08:55:00'),
(13, 13, 13, '2024-06-27 09:00:00'),
(14, 14, 14, '2024-06-27 09:05:00'),
(15, 15, 15, '2024-06-27 09:10:00'),
(16, 16, 16, '2024-06-27 09:15:00'),
(17, 17, 17, '2024-06-27 09:20:00'),
(18, 18, 18, '2024-06-27 09:25:00'),
(19, 19, 19, '2024-06-27 09:30:00'),
(20, 20, 20, '2024-06-27 09:35:00');

-- Insert data into Car table
INSERT INTO `Car` (`car_number_plate`, `car_brand`, `car_model`) VALUES
('ABC123', 'Toyota', 'Camry'),
('DEF456', 'Honda', 'Civic'),
('GHI789', 'Ford', 'Focus'),
('JKL012', 'Chevrolet', 'Malibu'),
('MNO345', 'Nissan', 'Altima'),
('PQR678', 'Hyundai', 'Elantra'),
('STU901', 'Kia', 'Optima'),
('VWX234', 'Mazda', '3'),
('YZA567', 'Volkswagen', 'Jetta'),
('BCD890', 'Subaru', 'Impreza'),
('EFG123', 'BMW', '3 Series'),
('HIJ456', 'Mercedes', 'C-Class'),
('KLM789', 'Audi', 'A4'),
('NOP012', 'Lexus', 'IS'),
('QRS345', 'Infiniti', 'Q50'),
('TUV678', 'Acura', 'TLX'),
('WXY901', 'Volvo', 'S60'),
('ZAB234', 'Jaguar', 'XE'),
('CDE567', 'Alfa Romeo', 'Giulia'),
('FGH890', 'Tesla', 'Model 3');

-- Insert data into Spot_reservation table
INSERT INTO `Spot_reservation` (`spot_reservation_id`, `swipe_card_id`, `car_number_plate`, `payment_amount`, `when_created`) VALUES
(1, 1, 'ABC123', 100.00, '2024-06-27 08:00:00'),
(2, 2, 'DEF456', 150.00, '2024-06-27 08:05:00'),
(3, 3, 'GHI789', 120.00, '2024-06-27 08:10:00'),
(4, 4, 'JKL012', 130.00, '2024-06-27 08:15:00'),
(5, 5, 'MNO345', 110.00, '2024-06-27 08:20:00'),
(6, 6, 'PQR678', 140.00, '2024-06-27 08:25:00'),
(7, 7, 'STU901', 115.00, '2024-06-27 08:30:00'),
(8, 8, 'VWX234', 160.00, '2024-06-27 08:35:00'),
(9, 9, 'YZA567', 135.00, '2024-06-27 08:40:00'),
(10, 10, 'BCD890', 125.00, '2024-06-27 08:45:00'),
(11, 11, 'EFG123', 145.00, '2024-06-27 08:50:00'),
(12, 12, 'HIJ456', 155.00, '2024-06-27 08:55:00'),
(13, 13, 'KLM789', 165.00, '2024-06-27 09:00:00'),
(14, 14, 'NOP012', 175.00, '2024-06-27 09:05:00'),
(15, 15, 'QRS345', 185.00, '2024-06-27 09:10:00'),
(16, 16, 'TUV678', 195.00, '2024-06-27 09:15:00'),
(17, 17, 'WXY901', 205.00, '2024-06-27 09:20:00'),
(18, 18, 'ZAB234', 215.00, '2024-06-27 09:25:00'),
(19, 19, 'CDE567', 225.00, '2024-06-27 09:30:00'),
(20, 20, 'FGH890', 235.00, '2024-06-27 09:35:00');

-- Insert data into Timeslot table
INSERT INTO `Timeslot` (`year`, `semester`) VALUES
(2024, 'S1'),
(2024, 'S2'),
(2023, 'S1'),
(2023, 'S2'),
(2022, 'S1'),
(2022, 'S2'),
(2021, 'S1'),
(2021, 'S2'),
(2020, 'S1'),
(2020, 'S2'),
(2019, 'S1'),
(2019, 'S2'),
(2018, 'S1'),
(2018, 'S2'),
(2017, 'S1'),
(2017, 'S2'),
(2016, 'S1'),
(2016, 'S2'),
(2015, 'S1'),
(2015, 'S2');

-- Insert data into Numbered_parking_spot table
INSERT INTO `Numbered_parking_spot` (`parking_spot_id`, `parking_area_id`, `location_description`) VALUES
(1, 1, 'Near entrance A'),
(2, 2, 'Near entrance B'),
(3, 3, 'Near entrance C'),
(4, 4, 'Near entrance D'),
(5, 5, 'Near entrance E'),
(6, 6, 'Near entrance F'),
(7, 7, 'Near entrance G'),
(8, 8, 'Near entrance H'),
(9, 9, 'Near entrance I'),
(10, 10, 'Near entrance J'),
(11, 11, 'Near entrance K'),
(12, 12, 'Near entrance L'),
(13, 13, 'Near entrance M'),
(14, 14, 'Near entrance N'),
(15, 15, 'Near entrance O'),
(16, 16, 'Near entrance P'),
(17, 17, 'Near entrance Q'),
(18, 18, 'Near entrance R'),
(19, 19, 'Near entrance S'),
(20, 20, 'Near entrance T');

-- Insert data into Allocation table
INSERT INTO `Allocation` (`parking_spot_id`, `year`, `semester`, `spot_reservation_id`) VALUES
(1, 2024, 'S1', 1),
(2, 2024, 'S1', 2),
(3, 2024, 'S1', 3),
(4, 2024, 'S1', 4),
(5, 2024, 'S1', 5),
(6, 2024, 'S1', 6),
(7, 2024, 'S1', 7),
(8, 2024, 'S1', 8),
(9, 2024, 'S1', 9),
(10, 2024, 'S1', 10),
(11, 2024, 'S1', 11),
(12, 2024, 'S1', 12),
(13, 2024, 'S1', 13),
(14, 2024, 'S1', 14),
(15, 2024, 'S1', 15),
(16, 2024, 'S1', 16),
(17, 2024, 'S1', 17),
(18, 2024, 'S1', 18),
(19, 2024, 'S1', 19),
(20, 2024, 'S1', 20);


-- List each staff number and the number of swipe card records that exist for each staff number. Sort by the largest number of records
-- first to the smallest number of records being last.

SELECT `staff_number`, COUNT(`swipe_card_id`) AS 'Number of cards'
FROM `Swipe_card`
GROUP BY `staff_number`
ORDER BY COUNT(`swipe_card_id`) DESC;

-- List the distinct staff names and staff numbers (from the staff card) of all staff who have 2 or more spot reservations. Sort by
-- staff surname in ascending dictionary order.

SELECT `Swipe_card`.`name_on_card`, `Swipe_card`.`staff_number`
FROM  `Swipe_card` 
RIGHT JOIN `Spot_reservation` ON `Swipe_card`.`swipe_card_id` = `Spot_reservation`.`swipe_card_id`
GROUP BY `name_on_card`, `staff_number`
HAVING COUNT(`spot_reservation_id`) >= 2
ORDER BY `name_on_card`ASC;

-- no result shown, add more data
INSERT INTO `Spot_reservation` (`spot_reservation_id`, `swipe_card_id`, `car_number_plate`, `payment_amount`, `when_created`) VALUES
(21, 1, 'ABC123', 200.00, '2024-06-28 08:00:00'),
(22, 1, 'DEF456', 210.00, '2024-06-28 08:05:00'),
(23, 2, 'GHI789', 220.00, '2024-06-28 08:10:00'),
(24, 2, 'JKL012', 230.00, '2024-06-28 08:15:00'),
(25, 3, 'MNO345', 240.00, '2024-06-28 08:20:00'),
(26, 3, 'PQR678', 250.00, '2024-06-28 08:25:00');

-- Show all entry attempts for a chosen swipe card
-- Chosen swipe card: 1
SELECT *
FROM `Spot_area_entry_attempt`
WHERE `swipe_card_id` = 1;

INSERT INTO `Spot_area_entry_attempt` (`attempt_id`, `swipe_card_id`, `parking_area_id`, `date and time of entry`) VALUES
(21, 1, 1, '2024-06-28 08:00:00'),
(22, 1, 2, '2024-06-28 08:10:00'),
(23, 1, 3, '2024-06-28 08:20:00');


-- List the details of each Car Park and the total number of numbered parking spots in each car park.

SELECT `Car_park`.`car_park_id`, `Car_park`.`map_reference`, `Car_park`.`car_park_description`, COUNT(`Numbered_parking_spot`.`parking_spot_id`) AS `No of Spots in each Car Park`
FROM `Car_park`
LEFT JOIN `Spot_reservation_parking_area` ON `Car_park`.`car_park_id`= `Spot_reservation_parking_area`.`car_park_id`
LEFT JOIN `Numbered_parking_spot` ON `Numbered_parking_spot`.`parking_area_id` = `Spot_reservation_parking_area`.`parking_area_id`
GROUP BY `Car_park`.`car_park_id`;

-- How many cars has each swipe card ever been associated with? List each swipe card id and count of different number plates.

SELECT `Swipe_card`.`swipe_card_id`, COUNT(Distinct `Spot_reservation`.`car_number_plate`) AS `No of cars associated with this card_id`
FROM `Swipe_card` 
LEFT JOIN `Spot_reservation` ON `Swipe_card`.`swipe_card_id` = `Spot_reservation`.`swipe_card_id` 
-- LEFT JOIN INSTEAD OF INNER JOIN because I want to show all swipe cards, including those without any cars associated with them.
GROUP BY `Swipe_card`.`swipe_card_id`;

-- For a given timeslot (any year and semester), how many parking spots are not allocated in each car park?
-- Chosen year and semester: Year 2023, Semester 1

SELECT `Car_park`.`car_park_id`, COUNT(`Numbered_parking_spot`.`parking_spot_id`) AS `Count of Unallocated Spots`
FROM `Car_park`
LEFT JOIN `Spot_reservation_parking_area` ON `Car_park`.`car_park_id`= `Spot_reservation_parking_area`.`car_park_id`
LEFT JOIN `Numbered_parking_spot` ON `Numbered_parking_spot`.`parking_area_id` = `Spot_reservation_parking_area`.`parking_area_id`
LEFT JOIN `Allocation` ON `Numbered_parking_spot`.`parking_spot_id` = `Allocation`.`parking_spot_id`
AND `Allocation`.`semester` = 1 AND `Allocation`.`year` = 2023
WHERE `Allocation`.`parking_spot_id` IS NULL 
GROUP BY `Car_park`.`car_park_id`
HAVING COUNT(`Numbered_parking_spot`.`parking_spot_id`) > 0; -- 0 means car parks are fully allocated

-- What is the total $ amount that each staff member has paid for parking during the lifetime of this system? In the query, list
-- the staff number and the total $ amount for that staff member.

SELECT `Swipe_card`.`staff_number`, CONCAT(SUM(`Spot_reservation`.`payment_amount`), " $") as "Payment_Amount"
FROM `Swipe_card`
LEFT JOIN `Spot_reservation` ON `Swipe_card`.`swipe_card_id` = `Spot_reservation`.`swipe_card_id`
GROUP BY `Swipe_card`.`staff_number`;

-- How much revenue (payments total) has each car park brought in each year? List the car park id, year, and total $ amount
-- for that car park for that year.
SELECT `Car_park`.`car_park_id`, `Allocation`.`year`, SUM(`payment_amount`) as "Annual Revenue"
FROM `Car_park`
LEFT JOIN `Spot_reservation_parking_area` ON `Car_park`.`car_park_id`= `Spot_reservation_parking_area`.`car_park_id`
LEFT JOIN `Numbered_parking_spot` ON `Numbered_parking_spot`.`parking_area_id` = `Spot_reservation_parking_area`.`parking_area_id`
LEFT JOIN `Allocation` ON `Numbered_parking_spot`.`parking_spot_id` = `Allocation`.`parking_spot_id`
LEFT JOIN `Spot_reservation` ON `Spot_reservation`.`spot_reservation_id` = `Allocation`.`spot_reservation_id`
GROUP BY `Car_park`.`car_park_id`, `Allocation`.`year`;

-- Insert additional data into Spot_reservation table
INSERT INTO `Spot_reservation` (`spot_reservation_id`, `swipe_card_id`, `car_number_plate`, `payment_amount`, `when_created`) VALUES
(27, 4, 'JKL012', 180.00, '2023-06-27 09:00:00'),
(28, 5, 'MNO345', 190.00, '2023-06-27 09:10:00'),
(29, 6, 'PQR678', 210.00, '2022-06-27 09:20:00'),
(30, 7, 'STU901', 220.00, '2022-06-27 09:30:00'),
(31, 8, 'VWX234', 230.00, '2021-06-27 09:40:00'),
(32, 9, 'YZA567', 240.00, '2021-06-27 09:50:00');

-- Insert additional data into Allocation table
INSERT INTO `Allocation` (`parking_spot_id`, `year`, `semester`, `spot_reservation_id`) VALUES
(1, 2023, 'S1', 27),
(2, 2023, 'S2', 28),
(3, 2022, 'S1', 29),
(4, 2022, 'S2', 30),
(5, 2021, 'S1', 31),
(6, 2021, 'S2', 32);