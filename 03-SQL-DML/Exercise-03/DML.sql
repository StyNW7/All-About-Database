USE UAS_1

-- A

SELECT FirstName, LastName, Email
FROM Customers
WHERE Email LIKE '%@yahoo.com';

-- B

SELECT FirstName
FROM Customers
WHERE CustomerID = 1 OR CustomerID = 2 OR CustomerID = 4

-- C

SELECT c.FirstName, c.LastName, SUM(o.Quantity) AS TotalQuantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;

-- D

SELECT
    OrderDate,
    SUM(TotalAmount) AS Sales,
    AVG(TotalAmount) AS Average_Sales
FROM Orders
GROUP BY OrderDate
ORDER BY OrderDate;

-- E

SELECT
    p.ProductName,
    SUM(o.Quantity) AS NUMBER_OF_SOLD
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.ProductName
HAVING SUM(o.Quantity) > 3
ORDER BY NUMBER_OF_SOLD DESC;

-- F

WITH AverageQuantity AS (
    SELECT AVG(Quantity) AS AvgQuantity
    FROM Orders
)
SELECT
    OrderID,
    CustomerID,
    ProductID,
    Quantity,
    TotalAmount
FROM Orders
WHERE Quantity > (SELECT AvgQuantity FROM AverageQuantity);

GO

SELECT 
    OrderID,
    CustomerID,
    ProductID,
    Quantity,
    TotalAmount
FROM Orders
WHERE Quantity > (
    SELECT AVG(Quantity)
    FROM Orders
);

-- G

WITH AveragePrice AS (
    SELECT AVG(Price) AS AvgPrice
    FROM Products
)
SELECT
    p.ProductName,
    p.Price
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
WHERE p.Price > (SELECT AvgPrice FROM AveragePrice)
GROUP BY p.ProductName, p.Price;

GO

SELECT
    p.ProductName,
    p.Price
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
WHERE p.Price > (
	SELECT AVG(Price)
	FROM Products
)
GROUP BY p.ProductName, p.Price;

-- H

WITH CustomerOrderCount AS (
    SELECT CustomerID, COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(OrderID) > 1
)
SELECT
    o.OrderID,
    o.ProductID,
    o.TotalAmount
FROM Orders o
JOIN CustomerOrderCount c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate BETWEEN '2023-05-10' AND '2023-05-11';

GO

SELECT
    o.OrderID,
    o.ProductID,
    o.TotalAmount
FROM Orders o
JOIN (
    SELECT CustomerID
    FROM Orders
    GROUP BY CustomerID
    HAVING COUNT(OrderID) > 1
) c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate BETWEEN '2023-05-10' AND '2023-05-11'

-- I

SELECT
    o.OrderID,
    p.ProductName,
    c.FirstName
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.FirstName LIKE '%a%'
  AND p.Price > 100
  AND p.Quantity < 20;

-- J

SELECT
    o.OrderID,
    p.ProductName,
    c.LastName
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Email LIKE '%@yahoo.com'
  AND p.ProductName IN ('Laptop', 'Tablet', 'Printer');

SELECT
    o.OrderID,
    p.ProductName,
    c.LastName
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE c.Email LIKE '%@yahoo.com'
  AND (p.ProductName = 'Laptop' OR p.ProductName = 'Tablet' OR p.ProductName = 'Printer');