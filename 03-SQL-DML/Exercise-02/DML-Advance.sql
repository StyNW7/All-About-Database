-- T091 - Stanley Nathanael Wijaya

-- USE master

USE TheHarveISt

GO

-- Question 1 Answer (Finish)

-- I think the query case example is wrong


SELECT 
    c.CustomerID,
    c.CustomerName
FROM 
    MsCustomer c
JOIN 
    TransactionHeader th ON c.CustomerID = th.CustomerID
JOIN 
    TransactionDetail td ON th.TransactionID = td.TransactionID
GROUP BY 
    c.CustomerID, c.CustomerName

EXCEPT

SELECT 
    c.CustomerID,
    c.CustomerName
FROM 
    MsCustomer c
JOIN 
    TransactionHeader th ON c.CustomerID = th.CustomerID
JOIN 
    TransactionDetail td ON th.TransactionID = td.TransactionID
GROUP BY 
    c.CustomerID, c.CustomerName
HAVING 
    COUNT(td.Quantity) <= 2;

-- Excpet COUNT(td.Quantity) <= 2, so only SELECT COUNT(td.Quantity) > 2

-- Checking the quantity


SELECT 
    c.CustomerID,
    c.CustomerName,
	td.Quantity
FROM 
    MsCustomer c
JOIN 
    TransactionHeader th ON c.CustomerID = th.CustomerID
JOIN 
    TransactionDetail td ON th.TransactionID = td.TransactionID
ORDER BY
	c.CustomerID, c.CustomerName ASC


-- I think the query result example in this case wrong


SELECT 
    c.CustomerID,
    c.CustomerName
	--td.Quantity
FROM 
    MsCustomer c
WHERE
	c.CustomerID = 'CU002'


-- Question 2 (Finish)


SELECT 
    p.ProductID,
    p.ProductName
FROM 
    MsProduct p
WHERE
    p.ProductPrice > (SELECT AVG(p2.ProductPrice) FROM MsProduct p2);


-- Question 3 (Finish)


-- I use the format DD-Mon-YYYY so I use replace for that
-- But based on the query case example given, so I replace the '-' to ' '


SELECT 
    REPLACE (c.CustomerID, 'CU', 'Customer ') AS CustomerID,
    CONCAT('Mr. ', c.CustomerName) AS CustomerName,
    [Membership Type] = mt.MembershipTypeName,
    REPLACE(CONVERT(VARCHAR, c.CustomerDOB, 106), '-', ' ') AS DateOfBirth,
    DATEDIFF(YEAR, c.CustomerDOB, GETDATE()) AS Age
FROM 
    MsCustomer c
JOIN 
    MsMembershipType mt ON mt.MembershipTypeID = c.MembershipTypeID
WHERE 
    c.CustomerGender = 'Male'

UNION

SELECT 
    REPLACE (c.CustomerID, 'CU', 'Customer ') AS CustomerID,
    CONCAT('Mrs. ', c.CustomerName) AS CustomerName,
    [Membership Type] = mt.MembershipTypeName,
    REPLACE(CONVERT(VARCHAR, c.CustomerDOB, 106), '-', ' ') AS DateOfBirth,
    DATEDIFF(YEAR, c.CustomerDOB, GETDATE()) AS Age
FROM 
    MsCustomer c
JOIN 
    MsMembershipType mt ON mt.MembershipTypeID = c.MembershipTypeID
WHERE 
    c.CustomerGender = 'Female';


-- Question 4 (Finish)


SELECT TOP 1
    [Best Seller Product] = p.ProductName,
    [Total Product Sold] = SUM(td.Quantity)
FROM 
    TransactionDetail td
JOIN 
    TransactionHeader th ON td.TransactionID = th.TransactionID
JOIN 
    MsProduct p ON td.ProductID = p.ProductID
WHERE 
    YEAR(th.TransactionDate) = 2023
GROUP BY 
    p.ProductName
ORDER BY 
    [Total Product Sold] DESC;


-- Question 5 (Finish)

-- First Name = LEFT (s.StaffName, CHARINDEX (' ', s.StaffName + ' ') - 1)
/*Last Name = 

REVERSE(SUBSTRING(REVERSE(s.StaffName), 1, CHARINDEX(' ', REVERSE(s.StaffName) + ' ') - 1))
REVERSE(RIGHT(s.StaffName, CHARINDEX(' ', s.StaffName + ' ') - 1)
*/

SELECT 
    LEFT(staff.staffName, CHARINDEX(' ', staff.staffName + ' ') - 1) AS FirstName,
	[Last Name] = RIGHT(staff.staffName, LEN(staff.StaffName) - (CHARINDEX(' ', staff.staffName + ' '))),
    --REVERSE(SUBSTRING(REVERSE(staff.staffName), 1, CHARINDEX(' ', REVERSE(staff.staffName) + ' ') - 1)) AS LastName,
    COUNT(th.TransactionID) AS TotalTransaction
FROM
    MsStaff staff
JOIN 
    TransactionHeader th ON staff.staffID = th.staffID
GROUP BY 
    staff.staffName;


-- Question 6 (Finish)


SELECT 
    c.CustomerName,
    [Total Coffe Purchased] = COUNT(td.TransactionID)
FROM 
    MsCustomer c
JOIN 
    TransactionHeader th ON c.CustomerID = th.CustomerID
JOIN 
    TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN
	MsProduct mp ON mp.ProductID = td.ProductID
WHERE 
    c.CustomerGender = 'Male'
    AND
	mp.ProductType = 'coffee'
GROUP BY 
    c.CustomerName;


-- Question 7 (Finish)


SELECT
	[Membership Type] = UPPER(mt.MembershipTypeName),
	[Customers] = COUNT (c.CustomerID)
FROM
	MsMembershipType mt
JOIN
	MsCustomer c ON c.MembershipTypeID = mt.MembershipTypeID
GROUP BY
	mt.MembershipTypeName


-- Question 8 (Finish)

-- No explanation what is Total Spending, so I assume it's sum of productPrice


SELECT 
    [Customer Name] = LOWER(c.CustomerName),
    [Total Spending] = CONCAT('Rp. ', SUM(p.ProductPrice), ',-')
FROM 
    MsCustomer c
JOIN 
    TransactionHeader th ON c.CustomerID = th.CustomerID
JOIN 
    TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN 
    MsProduct p ON td.ProductID = p.ProductID
GROUP BY 
    c.CustomerName
ORDER BY 
    SUM(p.ProductPrice) DESC;


-- Question 9 (Finish)


SELECT 
    [First Name] = LEFT(s.StaffName, CHARINDEX(' ', s.StaffName) - 1),
    [Last Name] = REVERSE(SUBSTRING(REVERSE(s.StaffName), 1, CHARINDEX(' ', REVERSE(s.StaffName)) - 1)),
    [Total Earning 2023] = CONCAT('Rp. ',
	SUM(CASE WHEN YEAR(th.TransactionDate) = 2023 THEN p.ProductPrice ELSE 0 END), ',-'),
    [Total Earning 2024] = CONCAT('Rp. ',
	SUM(CASE WHEN YEAR(th.TransactionDate) = 2024 THEN p.ProductPrice ELSE 0 END), ',-')
FROM 
    MsStaff s
JOIN 
    TransactionHeader th ON s.StaffID = th.StaffID
JOIN 
    TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN 
    MsProduct p ON td.ProductID = p.ProductID
GROUP BY 
    s.StaffName;


-- Question 10 (Finish)


SELECT
	[Customer Name] = c.CustomerName,
	[Total Transactions] = COUNT(th.TransactionID)
FROM
	MsCustomer c
JOIN
	TransactionHeader th ON th.CustomerID = c.CustomerID
WHERE
	c.CustomerName LIKE 'Isabella %'
GROUP BY
	c.CustomerName;