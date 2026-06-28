# Pond Table
CREATE TABLE Pond (
    pond_id INT,
    pond_loc VARCHAR(11),
    pond_size DECIMAL(8,2),
    CONSTRAINT pond_id_pk PRIMARY KEY (pond_id)
);

#Staff table
CREATE TABLE Staff (
    staff_id INT,
    staff_name VARCHAR(100),
    CONSTRAINT staff_id_pk PRIMARY KEY (staff_id)
);

CREATE TABLE Role (
    staff_role_id INT,
    role_name VARCHAR(50) CHECK (role_name IN ('Manager', 'Operator')),
    CONSTRAINT role_staff_pk PRIMARY KEY (staff_role_id)
);

# Species Table
CREATE TABLE Species (
    species_id INT,
    species_name VARCHAR(255),
    CONSTRAINT species_id_pk PRIMARY KEY (species_id)
);

# Health Status table
CREATE TABLE Health_Status (
    Health_id INT,	#batch_id is remove 
    Mortality_rates DECIMAL(5,2),
    treatment_used VARCHAR(255),
    health_condition VARCHAR(100),
    timestamp DATETIME,
    CONSTRAINT Health_id_pk PRIMARY KEY (Health_id)
);

# Batch Table
CREATE TABLE Batch (
    batch_id INT,
    pond_id INT,
    StartDate DATE,
    EndDate DATE,
    species_id INT,
    Health_id INT,
    CONSTRAINT batch_id_pk PRIMARY KEY (batch_id),
    CONSTRAINT pond_id_fk FOREIGN KEY (pond_id) REFERENCES Pond(pond_id),
    CONSTRAINT Health_id_fk FOREIGN KEY (Health_id) REFERENCES Health_Status(Health_id),
    CONSTRAINT species_id_fk FOREIGN KEY (species_id) REFERENCES Species(species_id)
);

#Staff_Role
CREATE TABLE Staff_Role (
    staff_id INT,
    staff_role_id INT,
    CONSTRAINT staff_role_pk PRIMARY KEY (staff_id, staff_role_id),
    CONSTRAINT fk_sr_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    CONSTRAINT fk_sr_role FOREIGN KEY (staff_role_id) REFERENCES Role(staff_role_id)
);

# Pond Condition Table
CREATE TABLE Pond_Condition (
    condition_id INT,
    pond_id INT,
    CONSTRAINT condition_id_pk PRIMARY KEY (condition_id),
    CONSTRAINT Pond_Condition_pond_fk FOREIGN KEY (pond_id) REFERENCES Pond(pond_id)
);

# Current Status Table
CREATE TABLE Current_Status (
    status_id INT,
    condition_id INT,
    status_type VARCHAR(10),
    CONSTRAINT status_id_pk PRIMARY KEY (status_id),
    CONSTRAINT condition_id_fk FOREIGN KEY (condition_id) REFERENCES Pond_Condition(condition_id)
);

# Water Quality Table
CREATE TABLE Water_Quality (
    waterQuality_id INT,
    batch_id INT,
    temperature DECIMAL(4,2), #correction (3,2) to (4,2)
    pH DECIMAL(3,1),
    dissolved_oxygen_lvl DECIMAL(5,2),
    CONSTRAINT waterQuality_id_pk PRIMARY KEY (waterQuality_id),
    CONSTRAINT batch_id_fk FOREIGN KEY (batch_id) REFERENCES Batch(batch_id)
);

#Staff_Phone
CREATE TABLE Staff_Phone (
    phone_id INT,
    staff_id INT,
    ph_num VARCHAR(15),
    CONSTRAINT staff_phone_pk PRIMARY KEY (phone_id),
    CONSTRAINT fk_staff_phone_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

#Equipment
CREATE TABLE Equipment (
    eq_id INT,
    eq_name VARCHAR(100),
    eq_type VARCHAR(50),
    CONSTRAINT equipment_pk PRIMARY KEY (eq_id)
);

#Activity_Type
CREATE TABLE Activity_Type (
    actType_id INT,
    act_name VARCHAR(50),
    unit_actUsed VARCHAR(10),
    CONSTRAINT activity_type_pk PRIMARY KEY (actType_id)
);

#Daily_Activity_Management(DAM) table
CREATE TABLE Daily_Activity_Management (
    act_id INT,
    batch_id INT,
    staff_id INT,
    actType_id INT,
    date_actUsed DATE,
    time_actUsed TIME,
    value_actUsed DECIMAL(10,2),
    cost_actUsed DECIMAL(10,2),
    CONSTRAINT DAM_pk PRIMARY KEY (act_id),
    CONSTRAINT fk_DAM_batch FOREIGN KEY (batch_id) REFERENCES Batch(batch_id),
    CONSTRAINT fk_DAM_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id),
    CONSTRAINT fk_DAM_acttype FOREIGN KEY (actType_id) REFERENCES Activity_Type(actType_id)
);

#Equipment_Usage(eq_usage) table
CREATE TABLE Equipment_Usage (
    eqUsage_id INT,
    eq_id INT,
    act_id INT,
    eqUsed_timeStart TIME,
    eqUsed_timeEnd TIME,
    CONSTRAINT eq_usage_pk PRIMARY KEY (eqUsage_id),
    CONSTRAINT fk_eq_usage_eq FOREIGN KEY (eq_id) REFERENCES Equipment(eq_id),
    CONSTRAINT fk_eq_usage_dam FOREIGN KEY (act_id) REFERENCES Daily_Activity_Management(act_id)
);

#Feeding_Management(FM) table
CREATE TABLE Feeding_Management (
    feed_id INT,
    pond_id INT NOT NULL,
    staff_id INT NOT NULL,
    date_feed DATE,
    time_feed TIME,
    quantity_food DECIMAL(10,2),
    cost_food DECIMAL(10,2),
    CONSTRAINT feeding_management_pk PRIMARY KEY (feed_id),
    CONSTRAINT fk_FM_pond FOREIGN KEY (pond_id) REFERENCES Pond(pond_id),
    CONSTRAINT fk_FM_staff FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

#Batch_Feeding(BF) table
CREATE TABLE Batch_Feeding (
    feed_id INT,
    batch_id INT,
    CONSTRAINT batch_feeding_pk PRIMARY KEY (feed_id, batch_id),
    CONSTRAINT fk_BF_feed FOREIGN KEY (feed_id) REFERENCES Feeding_Management(feed_id),
    CONSTRAINT fk_BF_batch FOREIGN KEY (batch_id) REFERENCES Batch(batch_id)
);

#Customer table
CREATE TABLE CUSTOMER (
    Customer_id INT PRIMARY KEY,
    Customer_name VARCHAR(100) NOT NULL,
    Customer_address VARCHAR(255),
    Customer_contact VARCHAR(15)
);

#SALES_TRANSACTION table
CREATE TABLE SALES_TRANSACTION (
    Sales_id INT PRIMARY KEY,
    Customer_id INT,
    Staff_id INT,
    Sales_quantity DECIMAL(10,2),
    Price DECIMAL(10,2),
    Transaction_date DATE,
    Payment_record VARCHAR(50),
    -- FOREIGN KEYS
    CONSTRAINT fk_sales_customer FOREIGN KEY (Customer_id) REFERENCES CUSTOMER(Customer_id),
    CONSTRAINT fk_sales_staff FOREIGN KEY (Staff_id) REFERENCES STAFF(Staff_id)
);

#Supplier table
CREATE TABLE Supplier (
    supplier_id INT,
    company_name VARCHAR(50),
    company_person VARCHAR(50),
    company_phone VARCHAR(15),
    company_email VARCHAR(50),
    address VARCHAR(100),
    payment_terms VARCHAR(30),
    CONSTRAINT supplier_id_pk PRIMARY KEY (supplier_id)
);

#Category table
CREATE TABLE Category (
    category_id INT,
    category_name VARCHAR(30),
    CONSTRAINT category_id_pk PRIMARY KEY (category_id)
);

#Inventory_Item table
CREATE TABLE Inventory_Item (
    item_id INT,
    item_name VARCHAR(50),
    quantity_in_stock INT,
    unit VARCHAR(10),
    price DECIMAL(8,2),
    expiry_date DATE,
    location VARCHAR(50),
    supplier_id INT,
    category_id INT,
    CONSTRAINT item_id_pk PRIMARY KEY (item_id),
    CONSTRAINT item_supplier_fk FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id),
    CONSTRAINT item_category_fk FOREIGN KEY (category_id) REFERENCES Category(category_id)
);

#Purchase_Order table
CREATE TABLE Purchase_Order (
    po_id INT,
    po_date DATE,
    total_cost DECIMAL(10,2),
    status VARCHAR(20),
    payment_terms VARCHAR(30),
    supplier_id INT,
    CONSTRAINT po_id_pk PRIMARY KEY (po_id),
    CONSTRAINT po_supplier_fk FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

#PO_Detail table
CREATE TABLE PO_Detail (
    po_id INT,
    item_id INT,
    quantity_ordered INT,
    unit_cost DECIMAL(8,2),
    CONSTRAINT pod_pk PRIMARY KEY (po_id, item_id),
    CONSTRAINT pod_po_fk FOREIGN KEY (po_id) REFERENCES Purchase_Order(po_id),
    CONSTRAINT pod_item_fk FOREIGN KEY (item_id) REFERENCES Inventory_Item(item_id)
);

#Cost_Record table
CREATE TABLE Cost_Record (
    cost_id INT,
    cost_type VARCHAR(30),
    amount DECIMAL(10,2),
    record_date DATE,
    activity_type VARCHAR(30),
    po_id INT,
    batch_id INT,
    CONSTRAINT cost_id_pk PRIMARY KEY (cost_id),
    CONSTRAINT cost_po_fk FOREIGN KEY (po_id) REFERENCES Purchase_Order(po_id),
    CONSTRAINT cost_batch_fk FOREIGN KEY (batch_id) REFERENCES Batch(batch_id)
);

#---------------------------insertion---------------------------------
# Temporary disable the foreign key to insert null values, then update the rows to connect them together
SET FOREIGN_KEY_CHECKS = 0;

#INSERTION OF DATA INTO TABLES
#Species table
INSERT INTO Species (species_id, species_name) VALUES
(1, 'Atlantic Salmon'),
(2, 'Blue Nile Tilapia'),
(3, 'Channel Catfish'),
(4, 'Rainbow Trout'),
(5, 'Common Carp'),
(6, 'Yellow Perch');

#Health_Status table
INSERT INTO Health_Status (Health_id, Mortality_rates, treatment_used, health_condition, timestamp) VALUES
(1, 0.50, 'None',           'Healthy',        '2025-03-15 10:00:00'),
(2, 1.20, 'Vitamins',       'Mild Stress',    '2025-04-01 09:30:00'),
(3, 0.00, 'None',           'Excellent',      '2025-05-10 11:15:00'),
(4, 3.50, 'Antibiotics',    'Infection',      '2025-06-22 08:45:00'),
(5, 0.80, 'Probiotics',     'Good',           '2025-07-05 10:20:00'),
(6, 2.10, 'Water Treatment','Poor Quality',   '2025-08-18 12:00:00');

#Pond table
INSERT INTO Pond (pond_id, pond_loc, pond_size) VALUES
(101, 'Zone-A1', 500.00),
(102, 'Zone-A2', 750.50),
(103, 'Zone-B1', 1000.00),
(104, 'Zone-B2', 450.25),
(105, 'Zone-C1', 600.00),
(106, 'Zone-C2', 850.75);

#Staff
INSERT INTO Staff (staff_id, staff_name)
VALUES
(101, 'Ahmad Zaki'),
(102, 'Siti Aminah'),
(103, 'Tan Hock Bee'),
(104, 'V. Rajesh'),
(105, 'Nurul Izzah'),
(106, 'Chong Wei'),
(107, 'Saraswathy Devi'),
(108, 'Mohd Ridzuan');

#Role
INSERT INTO Role (staff_role_id, role_name)
VALUES
(1, 'Manager'),
(2, 'Operator');

#Staff_Phone
INSERT INTO Staff_Phone (phone_id, staff_id, ph_num)
VALUES
(1, 101, '012-3456789'),
(2, 102, '013-9876543'),
(3, 103, '014-1112223'),
(4, 104, '016-4445556'),
(5, 105, '017-7778889');

#Staff_Role
INSERT INTO Staff_Role (staff_id, staff_role_id)
VALUES
(101, 1),
(102, 2),
(103, 2),
(104, 2), 
(105, 1), 
(106, 2), 
(107, 2), 
(108, 2); 

#Batch table
INSERT INTO Batch (batch_id, pond_id, StartDate, EndDate, species_id, Health_id) VALUES
(1, 101, '2025-03-24', '2025-08-20',    1, NULL),
(2, 102, '2025-04-01', NULL,            2, NULL),
(3, 101, '2025-05-16', '2025-09-30',    6, NULL),
(4, 103, '2025-06-14', NULL,            4, NULL),
(5, 106, '2025-10-31', '2025-12-15',    3, NULL),
(6, 105, '2025-11-27', '2025-12-7',     5, NULL);

#Update the health_id into Batch table
UPDATE Batch SET Health_id = 1 WHERE batch_id = 1;
UPDATE Batch SET Health_id = 2 WHERE batch_id = 2;
UPDATE Batch SET Health_id = 3 WHERE batch_id = 3;
UPDATE Batch SET Health_id = 4 WHERE batch_id = 4;
UPDATE Batch SET Health_id = 5 WHERE batch_id = 5;
UPDATE Batch SET Health_id = 6 WHERE batch_id = 6;

#Pond Condition table
INSERT INTO Pond_condition(condition_id, pond_id) VALUES
(1, 102),
(2, 106),
(3, 104),
(4, 101),
(5, 105),
(6, 103);

#Current Status table
INSERT INTO current_status (status_id, condition_id, status_type) VALUES
(1, 1, 'Active'),
(2, 2, 'Cleaned'),
(3, 3, 'Emptied'),
(4, 4, 'Active'),
(5, 5, 'Refilled'),
(6, 6, 'Reassigned');

#Water Quality table
INSERT INTO water_quality (waterQuality_id, batch_id, temperature, pH, dissolved_oxygen_lvl) VALUES
(1, 1, 25.0, 5.2, 6.80),
(2, 2, 26.5, 7.5, 7.10),
(3, 3, 24.0, 6.9, 6.50),
(4, 4, 27.0, 4.8, 5.90),
(5, 5, 25.5, 7.1, 7.40),
(6, 6, 26.0, 7.9, 6.20);

#Equipment
INSERT INTO Equipment (eq_id, eq_name, eq_type)
VALUES
(1, 'Water Pump', 'Mechanical'),
(2, 'Oxygen Aerator', 'Electrical'),
(3, 'Automatic Feeder', 'Electrical'),
(4, 'PH Meter', 'Digital'),
(5, 'Harvesting Net', 'Manual'),
(6, 'Water Heater', 'Electrical'),
(7, 'Backup Generator', 'Mechanical'),
(8, 'LED Pond Light', 'Electrical');

#Activity_Type
INSERT INTO Activity_Type (actType_id, act_name, unit_actUsed)
VALUES
(1, 'Feeding', 'kg'),
(2, 'Water Change', 'Liters'),
(3, 'Cleaning', 'Hours'),
(4, 'Health Check', 'Units'),
(5, 'Harvesting', 'kg'),
(6, 'Chemical Treatment', 'ml'),
(7, 'Pond Maintenance', 'Hours');

#Daily_Activity_Management table
INSERT INTO Daily_Activity_Management (act_id, batch_id, staff_id, actType_id, date_actUsed, time_actUsed, value_actUsed, cost_actUsed)
VALUES
(501, 1, 101, 1, '2025-06-01', '08:00:00', 5.50, 25.00),
(502, 2, 102, 2, '2025-06-01', '09:30:00', 100.00, 15.00),
(503, 1, 103, 3, '2025-06-02', '10:15:00', 2.00, 0.00), 
(504, 2, 104, 1, '2025-06-02', '16:45:00', 6.20, 30.00),
(505, 1, 105, 2, '2025-06-03', '07:00:00', 150.00, 20.00),
(506, 2, 106, 3, '2025-06-03', '11:00:00', 3.50, 0.00);

#Equipment_Usage
INSERT INTO Equipment_Usage (eqUsage_id, eq_id, act_id, eqUsed_timeStart, eqUsed_timeEnd)
VALUES
(1, 1, 501, '08:00:00', '08:45:00'),
(2, 2, 502, '09:30:00', '11:00:00'),
(3, 3, 503, '10:15:00', '10:45:00'),
(4, 4, 504, '16:45:00', '17:00:00'),
(5, 5, 505, '07:00:00', '08:30:00'),
(6, 6, 506, '11:00:00', '12:00:00'),
(7, 1, 501, '08:00:00', '08:45:00'),
(8, 1, 501, '08:00:00', '08:45:00');

#Feeding_Management
INSERT INTO Feeding_Management (feed_id, pond_id, staff_id, date_feed, time_feed, quantity_food, cost_food)
VALUES
(1, 101, 101, '2024-05-01', '07:30:00', 10.50, 45.00),
(2, 102, 102, '2024-05-01', '08:00:00', 12.00, 52.00),
(3, 103, 103, '2024-05-01', '07:45:00', 8.50, 38.00),
(4, 101, 104, '2024-05-02', '17:30:00', 11.00, 48.00),
(5, 102, 105, '2024-05-02', '18:00:00', 13.50, 60.00),
(6, 103, 106, '2024-05-02', '17:45:00', 9.00, 40.00),
(7, 101, 107, '2024-05-03', '07:30:00', 10.00, 44.00),
(8, 102, 108, '2024-05-03', '08:00:00', 12.50, 55.00);

#Batch_Feeding table
INSERT INTO Batch_Feeding (feed_id, batch_id)
VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6);

-- Supplier
INSERT INTO Supplier VALUES (1,'Aqua Supply','Ali','0123456789','aqua@gmail.com','KL','30 days');
INSERT INTO Supplier VALUES (2,'Fish Feed Pro','John','0134567890','feed@gmail.com','Selangor','15 days');
INSERT INTO Supplier VALUES (3,'Ocean Fresh','David','0145678901','ocean@gmail.com','Penang','30 days');
INSERT INTO Supplier VALUES (4,'Blue Ocean','Sara','0156789012','blue@gmail.com','Johor','45 days');
INSERT INTO Supplier VALUES (5,'Aqua Tech','Mike','0167890123','tech@gmail.com','Perak','30 days');

-- Category
INSERT INTO Category VALUES (1,'Feed');
INSERT INTO Category VALUES (2,'Equipment');
INSERT INTO Category VALUES (3,'Medicine');
INSERT INTO Category VALUES (4,'Tools');
INSERT INTO Category VALUES (5,'Chemicals');

-- Inventory Item
INSERT INTO Inventory_Item VALUES (1,'Fish Feed',100,'kg',120.00,'2026-12-01','Store A',2,1);
INSERT INTO Inventory_Item VALUES (2,'Water Pump',10,'pcs',350.00,NULL,'Store B',1,2);
INSERT INTO Inventory_Item VALUES (3,'Fish Medicine',50,'bottle',80.00,'2027-01-01','Store C',3,3);
INSERT INTO Inventory_Item VALUES (4,'Net',20,'pcs',60.00,NULL,'Store D',1,2);
INSERT INTO Inventory_Item VALUES (5,'Water Filter',15,'pcs',200.00,NULL,'Store E',4,2);

-- Purchase Order
INSERT INTO Purchase_Order VALUES (1,'2026-04-01',350.00,'Completed','30 days',1);
INSERT INTO Purchase_Order VALUES (2,'2026-04-05',240.00,'Pending','15 days',2);
INSERT INTO Purchase_Order VALUES (3,'2026-04-10',160.00,'Completed','30 days',3);
INSERT INTO Purchase_Order VALUES (4,'2026-04-15',120.00,'Pending','15 days',1);
INSERT INTO Purchase_Order VALUES (5,'2026-04-20',200.00,'Completed','45 days',4);

-- PO Detail
INSERT INTO PO_Detail VALUES (1,2,1,350.00);
INSERT INTO PO_Detail VALUES (2,1,2,120.00);
INSERT INTO PO_Detail VALUES (3,3,2,80.00);
INSERT INTO PO_Detail VALUES (4,4,2,60.00);
INSERT INTO PO_Detail VALUES (5,5,1,200.00);

-- Cost Record
INSERT INTO Cost_Record VALUES (1,'Transport',30.00,'2026-04-01','Logistics',1,1);
INSERT INTO Cost_Record VALUES (2,'Delivery',20.00,'2026-04-05','Shipping',2,2);
INSERT INTO Cost_Record VALUES (3,'Maintenance',50.00,'2026-04-10','Repair',3,3);
INSERT INTO Cost_Record VALUES (4,'Transport',25.00,'2026-04-15','Logistics',4,1);
INSERT INTO Cost_Record VALUES (5,'Cleaning',40.00,'2026-04-20','Maintenance',5,5);

#customer
INSERT INTO CUSTOMER VALUES
(1, 'Ali Ahmad', 'Kajang, Selangor', '0123456789');
INSERT INTO CUSTOMER VALUES
(2, 'John Tan', 'Cheras, Kuala Lumpur', '0198765432');
INSERT INTO CUSTOMER VALUES
(3, 'Siti Aminah', 'Serdang, Selangor', '0172233445');
INSERT INTO CUSTOMER VALUES
(4,'Cynthia Ho','Balakong, Selangor','0164256781');
INSERT INTO CUSTOMER VALUES
(5,'Janice Cheah','Seri Kembangan, Selangor','011-32143322');

#SALES_TRANSACTION
INSERT INTO SALES_TRANSACTION VALUES
(1001, 1, 101, 50.00, 12.50, '2025-06-05', 'Paid');
INSERT INTO SALES_TRANSACTION VALUES
(1002, 2, 102, 30.00, 12.50, '2025-06-06', 'Paid');
INSERT INTO SALES_TRANSACTION VALUES
(1003, 3, 103, 40.00, 15.00, '2025-07-20', 'Pending');
INSERT INTO SALES_TRANSACTION VALUES
(1004, 4, 104, 40.00, 15.00, '2025-08-20', 'Pending');
INSERT INTO SALES_TRANSACTION VALUES
(1005, 5, 105, 50.00, 15.00, '2025-07-23', 'Paid');

# Set the foreign key back to 1
SET FOREIGN_KEY_CHECKS = 1;

