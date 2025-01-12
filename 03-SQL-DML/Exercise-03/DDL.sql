CREATE DATABASE UAS_1

USE UAS_1

Drop Table Orders

-- Membuat Tabel Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100)
);

-- Menambahkan Data ke Tabel Customers
INSERT INTO Customers (CustomerID, FirstName, LastName, Email) VALUES
(1, 'John', 'Doe', 'john.doe@gmail.com'),
(2, 'Jane', 'Smith', 'jane.smith@yahoo.com'),
(3, 'Bob', 'Johnson', 'bob.johnson@yahoo.com'),
(4, 'Alice', 'Williams', 'alice.w@outlook.com');

-- Membuat Tabel Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Quantity INT
);

-- Menambahkan Data ke Tabel Products
INSERT INTO Products (ProductID, ProductName, Price, Quantity) VALUES
(201, 'Laptop', 1200.00, 10),
(202, 'Smartphone', 500.00, 25),
(203, 'Headphones', 80.00, 50),
(204, 'Printer', 300.00, 15),
(205, 'Tablet', 350.00, 20);

-- Membuat Tabel Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    ProductID INT,
    OrderDate DATE,
    Quantity INT,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Menambahkan Data ke Tabel Orders
INSERT INTO Orders (OrderID, CustomerID, ProductID, OrderDate, Quantity, TotalAmount) VALUES
(1, 1, 201, '2023-05-10', 2, 2400.00),
(2, 2, 202, '2023-05-10', 1, 500.00),
(3, 3, 203, '2023-05-10', 5, 400.00),
(4, 1, 204, '2023-05-10', 1, 300.00),
(5, 2, 205, '2023-05-11', 3, 1050.00),
(6, 3, 201, '2023-05-11', 2, 2400.00),
(7, 1, 203, '2023-05-11', 1, 80.00),
(8, 2, 204, '2023-05-12', 2, 600.00);
