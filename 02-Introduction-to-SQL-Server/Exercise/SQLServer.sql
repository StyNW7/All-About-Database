-- T091 - Stanley Nathanael Wijaya

-- Use Database after importing the .bak file

USE MaxHealth


/* Question 1 */


SELECT 
    EmployeeName, 
    EmployeeSalary, 
    YEAR(EmployeeDOB) AS BirthYear
FROM 
    MsEmployee
WHERE 
    EmployeeGender LIKE 'Male';


/* Question 2 */


UPDATE MsProtein
SET ProteinBrand = CONCAT(ProteinBrand, ' Brand')
WHERE ProteinBrand LIKE '% %';

/* For Checking */ 

SELECT ProteinID, ProteinBrand FROM MsProtein
WHERE ProteinBrand LIKE '% %';

/* Question 3 */


SELECT 
    UPPER(MsProteinType.ProteinTypeName) AS ProteinTypeName,
    MsProtein.ProteinRating,
    MsProtein.ProteinManufactureDate
FROM 
    MsProtein
JOIN 
    MsProteinType ON MsProtein.ProteinTypeID = MsProteinType.ProteinTypeID
WHERE 
    MsProtein.ProteinRating BETWEEN 4.4 AND 4.6;


/* Question 4 */


SELECT 
    CONCAT('Mr/Mrs. ', CustomerName) AS CustomerSalutation,
    CustomerGender,
    EmployeeID,
    TransactionDate
FROM 
    MsCustomer
JOIN 
    TransactionHeader ON MsCustomer.CustomerID = MsCustomer.CustomerID
WHERE 
    MONTH(TransactionDate) = 1
    AND LEN(CustomerName) >= 12;


/* Question 5 */


UPDATE MsEmployee
SET EmployeeAddress = '123 New Street'
WHERE 
    RIGHT(EmployeeName, 3) = 'son'
    AND EmployeeAddress LIKE '1%'
    AND LEN(EmployeePhone) > 10;

/* For Checking */

SELECT EmployeeID, EmployeeName, EmployeeAddress, EmployeePhone FROM MsEmployee
WHERE 
    RIGHT(EmployeeName, 3) = 'son'
    AND EmployeeAddress LIKE '1%'
    AND LEN(EmployeePhone) > 10;


/* Question 6 */


UPDATE TransactionHeader
SET TransactionDate = DATEADD(day, 7, TransactionDate)
FROM TransactionHeader
JOIN MsCustomer ON TransactionHeader.CustomerID = MsCustomer.CustomerID
WHERE 
    (DATENAME(QUARTER, TransactionDate) = '1' OR DATENAME(QUARTER, TransactionDate) = '2')
    AND MsCustomer.CustomerGender = 'Female';


-- For checking

SELECT TransactionID, TransactionDate
FROM TransactionHeader
JOIN MsCustomer ON TransactionHeader.CustomerID = MsCustomer.CustomerID
WHERE 
    (DATEPART(QUARTER, TransactionDate) = 1 OR DATEPART(QUARTER, TransactionDate) = 2)
    AND MsCustomer.CustomerGender = 'Female';


-- Best Case for Question 6 using transaction


BEGIN TRAN

UPDATE TransactionHeader
SET TransactionDate = DATEADD(day, 7, TransactionDate)
FROM TransactionHeader
JOIN MsCustomer ON TransactionHeader.CustomerID = MsCustomer.CustomerID
WHERE 
    (DATENAME(QUARTER, TransactionDate) = '1' OR DATENAME(QUARTER, TransactionDate) = '2')
    AND MsCustomer.CustomerGender = 'Female';

-- For checking

SELECT TransactionID, TransactionDate
FROM TransactionHeader
JOIN MsCustomer ON TransactionHeader.CustomerID = MsCustomer.CustomerID
WHERE 
    (DATEPART(QUARTER, TransactionDate) = 1 OR DATEPART(QUARTER, TransactionDate) = 2)
    AND MsCustomer.CustomerGender = 'Female';

-- Rollback --> Undo
ROLLBACK

-- Commit --> Final
COMMIT


/* Question 7 */

-- Using Transaction

BEGIN TRAN

DELETE td
FROM TransactionDetail td
JOIN TransactionHeader th ON td.TransactionID = th.TransactionID
WHERE 
    th.TransactionDate < DATEADD(month, -2, GETDATE())
    AND YEAR(th.TransactionDate) = 2022

-- For checking the table after query

SELECT td.TransactionID, TransactionDate, td.ProteinID, td.Quantity
FROM TransactionDetail td
JOIN TransactionHeader th ON td.TransactionID = th.TransactionID
WHERE 
    th.TransactionDate < DATEADD(month, -2, GETDATE())
    AND YEAR(th.TransactionDate) = 2022;

-- Undo
ROLLBACK

-- Final
COMMIT

/* Question 8 */


SELECT 
    LEFT(c.CustomerName, CHARINDEX(' ', c.CustomerName) - 1) AS FirstName,
    REVERSE(SUBSTRING(REVERSE(c.CustomerName), 1, CHARINDEX(' ', REVERSE(c.CustomerName)) - 1)) AS LastName,
    td.Quantity,
    p.ProteinName,
    p.ProteinPrice
FROM 
    MsCustomer c
JOIN 
    TransactionHeader th ON c.CustomerID = th.CustomerID
JOIN 
    TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN 
    MsProtein p ON td.ProteinID = p.ProteinID
WHERE 
    p.ProteinPrice IN (45, 50);


/* Question 9 */


SELECT 
    CONCAT('Mr./Mrs. ', REVERSE(SUBSTRING(REVERSE(s.EmployeeName), 0, CHARINDEX(' ', REVERSE(s.EmployeeName)) ))) AS StaffSalutation,
    FORMAT(t.TransactionDate, 'dd.MM.yyyy') AS TransactionDate,
    td.Quantity,
    pt.ProteinTypeName
FROM 
    MsEmployee s
JOIN 
    TransactionHeader t ON s.EmployeeID = t.EmployeeID
JOIN 
    TransactionDetail td ON t.TransactionID = td.TransactionID
JOIN 
    MsProtein p ON td.ProteinID = p.ProteinID
JOIN 
    MsProteinType pt ON p.ProteinTypeID = pt.ProteinTypeID
WHERE 
    pt.ProteinTypeName LIKE 'Egg Protein';

/* I think Employee Name Mr/Mrs. Moore has been deleted in the question 7 */

-- For checking employee name only

SELECT EmployeeName

FROM 
    MsEmployee s
JOIN 
    TransactionHeader t ON s.EmployeeID = t.EmployeeID
JOIN 
    TransactionDetail td ON t.TransactionID = td.TransactionID
JOIN 
    MsProtein p ON td.ProteinID = p.ProteinID
JOIN 
    MsProteinType pt ON p.ProteinTypeID = pt.ProteinTypeID
WHERE 
    pt.ProteinTypeName LIKE '%Egg Protein%';

-- There is only 4 employeeName


/* Question 10 */


SELECT 
    STUFF(CustomerEmail, CHARINDEX('@', CustomerEmail), 0, 'man') AS CustomerEmail,
    CustomerDOB,
    LOWER(p.ProteinName) AS ProteinName,
    p.ProteinPrice
FROM 
    MsCustomer c
JOIN 
    TransactionHeader th ON c.CustomerID = th.CustomerID
JOIN 
    TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN 
    MsProtein p ON td.ProteinID = p.ProteinID
WHERE 
    c.CustomerGender = 'Male'
    AND DATEDIFF(year, c.CustomerDOB, GETDATE()) > 40;

-- END


SELECT 
    CustomerEmail AS CustomerEmail,
    CustomerDOB,
    LOWER(p.ProteinName) AS ProteinName,
    p.ProteinPrice
FROM 
    MsCustomer c
JOIN 
    TransactionHeader th ON c.CustomerID = th.CustomerID
JOIN 
    TransactionDetail td ON th.TransactionID = td.TransactionID
JOIN 
    MsProtein p ON td.ProteinID = p.ProteinID
WHERE 
    c.CustomerGender = 'Male'
    AND DATEDIFF(year, c.CustomerDOB, GETDATE()) > 40;