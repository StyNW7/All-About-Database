CREATE DATABASE TheHarveISt
GO

USE TheHarveISt
GO

CREATE TABLE MsMembershipType(
	MembershipTypeID CHAR(5) PRIMARY KEY CHECK (MembershipTypeID LIKE 'MT[0-9][0-9][0-9]') NOT NULL,
	MembershipTypeName VARCHAR(20) NOT NULL
)

CREATE TABLE MsCustomer(
	CustomerID CHAR(5) PRIMARY KEY CHECK (CustomerID LIKE 'CU[0-9][0-9][0-9]') NOT NULL,
	CustomerName VARCHAR(100) NOT NULL,
	CustomerDOB DATE NOT NULL,
	CustomerGender VARCHAR(10) NOT NULL,
	MembershipTypeID CHAR(5) FOREIGN KEY (MembershipTypeID) REFERENCES MsMembershipType (MembershipTypeID)
) 

CREATE TABLE MsStore(
	StoreID CHAR(5) PRIMARY KEY CHECK (StoreID LIKE 'SO[0-9][0-9][0-9]') NOT NULL,
	StoreAddress VARCHAR(100) NOT NULL,
	CityName VARCHAR(50) NOT NULL
)

CREATE TABLE MsStaff(
	StaffID CHAR(5) PRIMARY KEY CHECK (StaffID LIKE 'ST[0-9][0-9][0-9]') NOT NULL,
	StaffName VARCHAR(50) NOT NULL,
	StaffGender VARCHAR(10) NOT NULL,
	StaffDOB DATE NOT NULL,
	StaffAddress VARCHAR(100) NOT NULL,
	StaffSalary INT NOT NULL,
	StoreID CHAR(5) FOREIGN KEY (StoreID) REFERENCES MsStore (StoreID)
)

CREATE TABLE MsProduct(
	ProductID CHAR(5) PRIMARY KEY CHECK (ProductID LIKE 'PR[0-9][0-9][0-9]') NOT NULL,
	ProductName VARCHAR(100) NOT NULL,
	ProductType VARCHAR(50) NOT NULL,
	ProductPrice INT NOT NULL
)

CREATE TABLE TransactionHeader(
	TransactionID CHAR(5) PRIMARY KEY CHECK (TransactionID LIKE 'TR[0-9][0-9][0-9]') NOT NULL,
	CustomerID CHAR(5) FOREIGN KEY (CustomerID) REFERENCES MsCustomer (CustomerID),
	StaffID CHAR(5) FOREIGN KEY (StaffID) REFERENCES MsStaff (StaffID),
	StoreID CHAR(5) FOREIGN KEY (StoreID) REFERENCES MsStore (StoreID),
	TransactionDate DATE NOT NULL,
)

CREATE TABLE TransactionDetail(
	TransactionID CHAR(5) FOREIGN KEY REFERENCES TransactionHeader(TransactionID) ON UPDATE CASCADE ON DELETE CASCADE,
	ProductID CHAR(5),
	Quantity INT NOT NULL,
	PRIMARY KEY(TransactionID, ProductID)
)

INSERT INTO MsMembershipType VALUES
('MT001', 'Basic'),
('MT002', 'Silver'),
('MT003', 'Gold')

INSERT INTO MsCustomer VALUES
('CU001', 'John Doe', '1987-03-12', 'Male', 'MT001'),
('CU002', 'Jane Smith', '1989-06-21', 'Female', 'MT002'),
('CU003', 'Michael Johnson', '1992-11-30', 'Male', 'MT003'),
('CU004', 'Emily Davis', '1990-04-15', 'Female', 'MT001'),
('CU005', 'David Wilson', '1995-09-08', 'Male', 'MT002'),
('CU006', 'Sarah Brown', '1998-07-25', 'Female', 'MT003'),
('CU007', 'Robert Lee', '2001-02-17', 'Male', 'MT001'),
('CU008', 'Lisa Taylor', '1999-05-04', 'Female', 'MT002'),
('CU009', 'Christopher Hall', '1991-10-29', 'Male', 'MT003'),
('CU010', 'Amanda Clark', '1988-08-03', 'Female', 'MT001'),
('CU011', 'Olivia Martinez', '1993-05-18', 'Female', 'MT003'),
('CU012', 'Daniel Rodriguez', '1997-08-09', 'Male', 'MT002'),
('CU013', 'Sophia Lopez', '2000-02-24', 'Female', 'MT001'),
('CU014', 'Ethan Perez', '1994-11-03', 'Male', 'MT002'),
('CU015', 'Mia Gonzalez', '1996-06-27', 'Female', 'MT003'),
('CU016', 'Alexander Hernandez', '1998-09-14', 'Male', 'MT001'),
('CU017', 'Isabella Flores', '1999-12-22', 'Female', 'MT002'),
('CU018', 'William Ramirez', '2002-07-31', 'Male', 'MT003'),
('CU019', 'Sofia Adams', '1987-03-06', 'Female', 'MT001'),
('CU020', 'James Campbell', '1991-01-11', 'Male', 'MT002');

INSERT INTO MsStore VALUES
('SO001', '123 Main Street', 'New York'),
('SO002', '456 Elm Avenue', 'Los Angeles'),
('SO003', '789 Oak Boulevard', 'Chicago'),
('SO004', '101 Pine Road', 'Houston'),
('SO005', '202 Maple Lane', 'Philadelphia'),
('SO006', '303 Cedar Street', 'Phoenix'),
('SO007', '404 Walnut Drive', 'San Antonio'),
('SO008', '505 Birch Court', 'San Diego'),
('SO009', '606 Pine Street', 'Los Angeles'),
('SO010', '707 Oak Avenue', 'Chicago');

INSERT INTO MsStaff VALUES
('ST001', 'John Smith', 'Male', '1987-07-12', '123 Main Street', 50000, 'SO001'),
('ST002', 'Emily Johnson', 'Female', '1990-02-21', '456 Elm Avenue', 55000, 'SO002'),
('ST003', 'Michael Brown', 'Male', '1988-09-30', '789 Oak Boulevard', 60000, 'SO003'),
('ST004', 'Jessica Davis', 'Female', '1992-04-15', '101 Pine Road', 52000, 'SO004'),
('ST005', 'David Wilson', 'Male', '1995-11-08', '202 Maple Lane', 48000, 'SO005'),
('ST006', 'Sarah Martinez', 'Female', '1997-07-25', '303 Cedar Street', 53000, 'SO006'),
('ST007', 'Robert Lee', 'Male', '1989-11-17', '404 Walnut Drive', 61000, 'SO007'),
('ST008', 'Lisa Taylor', 'Female', '1996-06-04', '505 Birch Court', 54000, 'SO008'),
('ST009', 'Christopher Hall', 'Male', '1991-10-29', '606 Pine Street', 57000, 'SO002'),
('ST010', 'Amanda Clark', 'Female', '1985-08-03', '707 Oak Avenue', 52000, 'SO003'),
('ST011', 'Oliver Harris', 'Male', '1987-05-18', '808 Elm Boulevard', 56000, 'SO004'),
('ST012', 'Sophia Lopez', 'Female', '1998-02-24', '909 Cedar Road', 59000, 'SO005'),
('ST013', 'Ethan Perez', 'Male', '1994-11-03', '1010 Maple Drive', 51000, 'SO006'),
('ST014', 'Mia Gonzalez', 'Female', '1986-06-27', '1111 Walnut Lane', 58000, 'SO007'),
('ST015', 'Alexander Hernandez', 'Male', '1985-09-14', '1212 Birch Avenue', 55000, 'SO008');

INSERT INTO MsProduct VALUES
('PR001', 'Espresso', 'Coffee', 25000),
('PR002', 'Latte', 'Coffee', 28000),
('PR003', 'Cappuccino', 'Coffee', 30000),
('PR004', 'Mocha', 'Coffee', 32000),
('PR005', 'Black Forest Cake', 'Cake', 45000),
('PR006', 'Red Velvet Cake', 'Cake', 48000),
('PR007', 'Carrot Cake', 'Cake', 50000),
('PR009', 'Baguette', 'Bread', 30000),
('PR010', 'Sourdough Bread', 'Bread', 32000),
('PR012', 'Croissant', 'Bread', 25000)

INSERT INTO TransactionHeader VALUES
('TR001', 'CU008', 'ST012', 'SO002', '2023-12-15'),
('TR002', 'CU018', 'ST012', 'SO002', '2024-02-20'),
('TR003', 'CU007', 'ST005', 'SO002', '2024-02-17'),
('TR004', 'CU006', 'ST008', 'SO006', '2023-09-19'),
('TR005', 'CU014', 'ST012', 'SO003', '2023-12-05'),
('TR006', 'CU019', 'ST015', 'SO005', '2024-01-21'),
('TR007', 'CU008', 'ST009', 'SO010', '2024-02-06'),
('TR008', 'CU014', 'ST010', 'SO009', '2023-11-08'),
('TR009', 'CU012', 'ST009', 'SO007', '2024-01-23'),
('TR010', 'CU007', 'ST014', 'SO009', '2023-12-07'),
('TR011', 'CU008', 'ST008', 'SO003', '2023-10-25'),
('TR012', 'CU011', 'ST012', 'SO007', '2023-10-18'),
('TR013', 'CU006', 'ST012', 'SO002', '2023-12-30'),
('TR014', 'CU012', 'ST010', 'SO005', '2023-09-20'),
('TR015', 'CU017', 'ST014', 'SO001', '2023-09-07'),
('TR016', 'CU012', 'ST006', 'SO004', '2023-02-2'),
('TR017', 'CU006', 'ST004', 'SO002', '2024-01-03'),
('TR018', 'CU017', 'ST012', 'SO006', '2024-02-19'),
('TR019', 'CU016', 'ST011', 'SO008', '2023-10-14'),
('TR020', 'CU019', 'ST001', 'SO005', '2024-01-27'),
('TR021', 'CU013', 'ST007', 'SO009', '2023-10-24'),
('TR022', 'CU014', 'ST003', 'SO003', '2023-12-15'),
('TR023', 'CU018', 'ST011', 'SO004', '2023-12-01'),
('TR024', 'CU008', 'ST015', 'SO006', '2023-12-12'),
('TR025', 'CU010', 'ST007', 'SO008', '2024-01-06'),
('TR026', 'CU018', 'ST004', 'SO001', '2023-10-19'),
('TR027', 'CU014', 'ST002', 'SO006', '2023-09-22'),
('TR028', 'CU003', 'ST008', 'SO007', '2023-12-31'),
('TR029', 'CU009', 'ST005', 'SO005', '2024-01-30'),
('TR030', 'CU010', 'ST005', 'SO009', '2023-12-22'),
('TR031', 'CU005', 'ST007', 'SO009', '2023-12-16'),
('TR032', 'CU011', 'ST003', 'SO006', '2024-02-29'),
('TR033', 'CU004', 'ST001', 'SO005', '2023-10-09'),
('TR034', 'CU008', 'ST011', 'SO006', '2023-11-11'),
('TR035', 'CU011', 'ST013', 'SO009', '2023-11-14'),
('TR036', 'CU006', 'ST011', 'SO009', '2023-11-01'),
('TR037', 'CU015', 'ST011', 'SO005', '2023-10-08'),
('TR038', 'CU007', 'ST003', 'SO010', '2024-01-19'),
('TR039', 'CU011', 'ST014', 'SO005', '2023-11-06'),
('TR040', 'CU005', 'ST013', 'SO002', '2023-10-10'),
('TR041', 'CU001', 'ST007', 'SO003', '2023-11-10'),
('TR042', 'CU019', 'ST009', 'SO008', '2023-12-11'),
('TR043', 'CU008', 'ST009', 'SO006', '2023-10-25'),
('TR044', 'CU018', 'ST009', 'SO005', '2023-09-19'),
('TR045', 'CU010', 'ST009', 'SO001', '2023-10-24'),
('TR046', 'CU014', 'ST015', 'SO005', '2023-12-14'),
('TR047', 'CU008', 'ST007', 'SO006', '2024-01-20'),
('TR048', 'CU019', 'ST010', 'SO010', '2023-12-27'),
('TR049', 'CU018', 'ST014', 'SO010', '2024-02-29'),
('TR050', 'CU001', 'ST015', 'SO004', '2024-02-16');

INSERT INTO TransactionDetail VALUES
('TR001', 'PR004', 5),
('TR002', 'PR002', 1),
('TR003', 'PR005', 1),
('TR004', 'PR004', 1),
('TR005', 'PR007', 4),
('TR006', 'PR010', 2),
('TR007', 'PR008', 5),
('TR008', 'PR007', 4),
('TR009', 'PR005', 5),
('TR010', 'PR009', 4),
('TR011', 'PR003', 1),
('TR012', 'PR010', 5),
('TR013', 'PR003', 3),
('TR014', 'PR007', 4),
('TR015', 'PR001', 5),
('TR016', 'PR001', 5),
('TR017', 'PR001', 2),
('TR018', 'PR006', 4),
('TR019', 'PR010', 1),
('TR020', 'PR009', 4),
('TR021', 'PR006', 4),
('TR022', 'PR010', 2),
('TR023', 'PR010', 4),
('TR024', 'PR009', 1),
('TR025', 'PR006', 2),
('TR026', 'PR003', 5),
('TR027', 'PR005', 1),
('TR028', 'PR004', 2),
('TR029', 'PR009', 4),
('TR030', 'PR004', 1),
('TR031', 'PR009', 2),
('TR032', 'PR007', 5),
('TR033', 'PR003', 4),
('TR034', 'PR006', 1),
('TR035', 'PR010', 5),
('TR036', 'PR001', 1),
('TR037', 'PR005', 4),
('TR038', 'PR007', 4),
('TR039', 'PR007', 1),
('TR040', 'PR008', 5),
('TR041', 'PR001', 5),
('TR042', 'PR003', 3),
('TR043', 'PR008', 2),
('TR044', 'PR001', 1),
('TR045', 'PR008', 3),
('TR046', 'PR009', 2),
('TR047', 'PR008', 4),
('TR048', 'PR008', 2),
('TR049', 'PR004', 4),
('TR050', 'PR002', 4),
('TR001', 'PR008', 4),
('TR002', 'PR009', 3),
('TR003', 'PR003', 2),
('TR004', 'PR010', 2),
('TR005', 'PR010', 3),
('TR006', 'PR009', 2),
('TR007', 'PR001', 3),
('TR008', 'PR004', 2),
('TR009', 'PR004', 2),
('TR010', 'PR010', 4),
('TR011', 'PR009', 5),
('TR012', 'PR004', 2),
('TR013', 'PR010', 2),
('TR014', 'PR004', 3),
('TR015', 'PR003', 5),
('TR016', 'PR002', 3),
('TR017', 'PR002', 2),
('TR018', 'PR009', 3),
('TR019', 'PR006', 2),
('TR020', 'PR005', 4),
('TR021', 'PR005', 3),
('TR022', 'PR006', 3),
('TR023', 'PR003', 5),
('TR024', 'PR008', 3),
('TR025', 'PR005', 4);

