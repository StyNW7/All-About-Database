-- Use Database

USE JnZ_Express


-- Question 1 (Finish)

SELECT 
    sender.CustomerName AS SenderName,
    receiver.CustomerName AS ReceiverName,
    t.TransactionDate
FROM 
    TransactionHeader t
JOIN 
    MsCustomer sender ON t.SenderID = sender.CustomerID
JOIN 
    MsCustomer receiver ON t.ReceiverID = receiver.CustomerID
WHERE 
    MONTH(t.TransactionDate) = 2
	AND RIGHT(t.transactionID, 3) % 4 = 0

-- For checking with the transactionID

SELECT 
    sender.CustomerName AS SenderName,
    receiver.CustomerName AS ReceiverName,
	t.transactionID,
    t.TransactionDate
FROM 
    TransactionHeader t
JOIN 
    MsCustomer sender ON t.SenderID = sender.CustomerID
JOIN 
    MsCustomer receiver ON t.ReceiverID = receiver.CustomerID


-- Question 2 (Finish)


SELECT 
    UPPER(s.staffName) AS StaffName,
    s.staffAddress AS StaffAddress,
    c.cityName AS StaffCity
FROM 
    MsStaff s
JOIN 
    MsCity c ON s.cityID = c.cityID
WHERE 
    s.staffAddress LIKE '[0-9]0 %';


-- There should be a space after 0 digit, so that the address is only 2 digit number


-- Question 3 (Finish)


SELECT 
    t.transactionID AS TransactionID,
    MONTH(t.transactionDate) AS TransactionMonth,
    ds.deliveryServiceName AS DeliveryServiceName,
    (ds.deliveryServicePrice * t.weight) AS TotalRevenuePerTransaction
FROM 
    TransactionHeader t
JOIN 
    MsDeliveryService ds ON t.deliveryServiceID = ds.deliveryServiceID
WHERE 
    ds.deliveryServiceName LIKE '% % %';


--  Question 4 (Finish)


-- With using transaction


BEGIN TRAN

UPDATE ds
SET ds.deliveryServicePrice = ds.deliveryServicePrice + 5000
FROM 
    MsDeliveryService ds
JOIN 
    TransactionHeader th ON ds.deliveryServiceID = th.deliveryServiceID
JOIN 
    MsProductType pt ON pt.productTypeID = th.productTypeID
WHERE 
    CAST(RIGHT(th.transactionID, 3) AS INT) % 2 = 0
    AND LEN(pt.description) > 20
    AND MONTH(th.transactionDate) = 4
    AND ds.deliveryServiceName LIKE '% % %';

-- Rollback / undo
ROLLBACK

-- Commit / final
COMMIT


-- See the update query


SELECT
	ds.deliveryServiceName,
	ds.deliveryServicePrice
FROM 
    MsDeliveryService ds
JOIN 
    TransactionHeader th ON ds.deliveryServiceID = th.deliveryServiceID
JOIN 
    MsProductType pt ON pt.productTypeID = th.productTypeID
WHERE 
    CAST(RIGHT(th.transactionID, 3) AS INT) % 2 = 0
    AND LEN(pt.description) > 20
    AND MONTH(th.transactionDate) = 4
    AND ds.deliveryServiceName LIKE '% % %';


-- For Checking the question
-- I think there is no exactly 3 characters but 3 words


SELECT
	ds.deliveryServicePrice,
	th.transactionID,
	th.transactionDate,
	pt.description,
	ds.deliveryServiceName
FROM 
    MsDeliveryService ds
JOIN 
    TransactionHeader th ON ds.deliveryServiceID = th.deliveryServiceID
JOIN 
    MsProductType pt ON pt.productTypeID = th.productTypeID
WHERE 
    CAST(RIGHT(th.transactionID, 3) AS INT) % 2 = 0
    AND LEN(pt.description) > 20
    AND MONTH(th.transactionDate) = 4
    AND ds.deliveryServiceName LIKE '% % %';


-- Question 5 (Finish)


/* Actually there is no detail explanation about Total Transaction
So, I assume Total Transaction = t.weight * ds.deliveryServicePrice
*/


SELECT 
    c.customerName AS CustomerName,
    REVERSE(t.transactionID) AS CouponCode,
    FORMAT(t.transactionDate, 'dd-MM-yyyy') AS CouponStartDate,
    FORMAT(DATEADD(month, 3, t.transactionDate), 'dd-MM-yyyy') AS CouponExpiryDate,
    FORMAT(10000, 'C', 'id-ID') AS CouponPrice
FROM 
    MsCustomer c
JOIN 
    TransactionHeader t ON c.customerID = t.receiverID
JOIN 
    MsDeliveryService ds ON ds.deliveryServiceID = t.deliveryServiceID
WHERE 
    t.weight * ds.deliveryServicePrice > 20000;


-- I think the query result in the case is different with this


-- Question 6

-- There is false explanation in the case:
-- Before: greater than 20, but the result is using less than 20

-- Using greater than 20


BEGIN TRAN

DELETE pt
FROM 
    MsProductType pt
JOIN 
    TransactionHeader th ON pt.productTypeID = th.productTypeID
WHERE 
    (DATEPART(QUARTER, th.TransactionDate) IN (1, 4))
    AND LEN(pt.description) > 20;

-- Using less than 20

BEGIN TRAN

DELETE pt
FROM 
    MsProductType pt
JOIN 
    TransactionHeader th ON pt.productTypeID = th.productTypeID
WHERE 
    (DATEPART(QUARTER, th.TransactionDate) IN (1, 4))
    AND LEN(pt.description) < 20;

-- Rollback / Undo
ROLLBACK

-- Commit / Final
COMMIT


-- For checking
-- I think the query result from the example case is wrong, because PT003 description's length is not > 20


SELECT
	pt.productTypeID,
	pt.productTypeName,
	pt.description,
	th.transactionDate
FROM
    MsProductType pt
JOIN 
    TransactionHeader th ON pt.productTypeID = th.productTypeID
WHERE 
    (DATEPART(QUARTER, th.TransactionDate) IN (1, 4))
     AND LEN(pt.description) < 20;
	--AND LEN(pt.description) > 20;


-- Question 7 (Finish)


BEGIN TRAN

UPDATE c
SET c.customerName = CONCAT('Mr./Mrs. ', c.customerName)
FROM
	MsCustomer c
JOIN
	TransactionHeader th ON th.receiverID = c.customerID
JOIN
	MsDeliveryService ds ON ds.deliveryServiceID = th.deliveryServiceID
WHERE
	MONTH (th.transactionDate) = 2
	AND ds.deliveryServiceName LIKE 'G%';

ROLLBACK

COMMIT

-- For checking the query example

-- I think the query case result is different with this

SELECT
	c.customerID,
	c.customerName,
	c.customerAddress,
	c.customerGender,
	c.cityID,
	th.transactionDate,
	ds.deliveryServiceName
FROM
	MsCustomer c
JOIN
	TransactionHeader th ON th.receiverID = c.customerID
JOIN
	MsDeliveryService ds ON ds.deliveryServiceID = th.deliveryServiceID
WHERE
	MONTH (th.transactionDate) = 2
	AND ds.deliveryServiceName LIKE 'G%';


-- Question 8 (Finish)


GO
CREATE OR ALTER VIEW Customer_Total_Transaction_More_Than_25000 AS
SELECT
    SUBSTRING(sender.customerName, 1, CHARINDEX(' ', sender.customerName + ' ') - 1) AS SenderFirstName,
    REVERSE(SUBSTRING(REVERSE(sender.customerName), 1, CHARINDEX(' ', REVERSE(sender.customerName) + ' ') - 1)) AS SenderLastName,
    pt.productTypeName AS ProductTypeName,
    pt.description AS ProductDescription,
    th.transactionDate AS TransactionDate,
    ds.deliveryServiceName AS DeliveryServiceName,
    FORMAT(th.weight * ds.deliveryServicePrice, 'C', 'id-ID') AS TotalTransaction
FROM 
    TransactionHeader th
JOIN 
    MsProductType pt ON th.productTypeID = pt.productTypeID
JOIN 
    MsCustomer sender ON th.senderID = sender.customerID
JOIN 
    MsCustomer receiver ON th.ReceiverID = receiver.CustomerID
JOIN 
    MsDeliveryService ds ON th.deliveryServiceID = ds.deliveryServiceID
WHERE 
    th.weight * ds.deliveryServicePrice > 25000;


-- View the Customer_Total_Transaction_More_Than_25000's view


GO
SELECT * FROM Customer_Total_Transaction_More_Than_25000


-- Question 9 (Finish)


GO
CREATE OR ALTER VIEW Total_Transaction_Using_Sea_Delivery_In_American_Dollar AS
SELECT 
    CONCAT('Mr./Mrs. ', REVERSE(SUBSTRING(REVERSE(staff.staffName), 1, CHARINDEX(' ', REVERSE(staff.staffName) + ' ') - 1))) AS StaffName,
    FORMAT(th.transactionDate, 'dd-MM-yyyy') AS TransactionDate,
    FORMAT((th.weight * ds.deliveryServicePrice) / 14000, 'C', 'en-US') AS TotalRevenue,
    ds.deliveryServiceName AS DeliveryServiceName
FROM 
    TransactionHeader th
JOIN 
    MsStaff staff ON th.staffID = staff.staffID
JOIN 
    MsDeliveryService ds ON th.deliveryServiceID = ds.deliveryServiceID
JOIN 
    MsDeliveryServiceType dsType ON dsType.deliveryServiceTypeID = ds.deliveryServiceTypeID
WHERE 
    dsType.deliveryServiceName = 'Sea Delivery';


-- View the Total_Transaction_Using_Sea_Delivery_In_American_Dollar's view

GO
SELECT * FROM Total_Transaction_Using_Sea_Delivery_In_American_Dollar


-- Question 10 (I modified based on the query case result example) (Finish)


GO
CREATE OR ALTER VIEW Staff_Transaction_Details AS

SELECT
	-- Make it lower + concat + take the last name
	[Staff Email] = LOWER(CONCAT(REVERSE(SUBSTRING(REVERSE(staff.staffName),1,
            CHARINDEX(' ', REVERSE(staff.staffName) + ' ') - 1
        )),
        '@gmail.com'
    )),
    [Total Revenue] = FORMAT(th.weight * ds.deliveryServicePrice, 'C', 'id-ID'),
    [Total Commision] = FORMAT((th.weight * ds.deliveryServicePrice * 0.2), 'C', 'id-ID'),
    [Transaction Date] = th.transactionDate
FROM 
    TransactionHeader th
JOIN 
    MsProductType pt ON th.productTypeID = pt.productTypeID
JOIN
    MsStaff staff ON th.staffID = staff.staffID
JOIN 
    MsDeliveryService ds ON th.deliveryServiceID = ds.deliveryServiceID
JOIN 
    MsDeliveryServiceType dsType ON dsType.deliveryServiceTypeID = ds.deliveryServiceTypeID

WHERE
    LOWER(SUBSTRING(pt.productTypeName, 1, CHARINDEX(' ', pt.productTypeName + ' ') - 1)) = 'caution'
	-- AND LOWER(dsType.deliveryServiceName) = 'Sea Delivery'
    -- AND LOWER(REVERSE(SUBSTRING(REVERSE(dsType.deliveryServiceName), 1, CHARINDEX(' ', REVERSE(dsType.deliveryServiceName) + ' ') - 1))) = 'Sea Delivery';

UNION ALL

SELECT 
    [Staff Email] = LOWER(CONCAT(REVERSE(SUBSTRING(REVERSE(staff.staffName),1,
            CHARINDEX(' ', REVERSE(staff.staffName) + ' ') - 1
        )),
        '@gmail.com'
    )),
    FORMAT(th.weight * ds.deliveryServicePrice, 'C', 'id-ID') AS TotalRevenue,
    FORMAT((th.weight * ds.deliveryServicePrice * 0.2), 'C', 'id-ID') AS TotalCommission,
    th.transactionDate AS TransactionDate
FROM 
    TransactionHeader th
JOIN 
    MsProductType pt ON th.productTypeID = pt.productTypeID
JOIN 
    MsStaff staff ON th.staffID = staff.staffID
JOIN 
    MsDeliveryService ds ON th.deliveryServiceID = ds.deliveryServiceID
JOIN 
    MsDeliveryServiceType dsType ON dsType.deliveryServiceTypeID = ds.deliveryServiceTypeID

WHERE 
    LOWER(SUBSTRING(pt.productTypeName, 1, CHARINDEX(' ', pt.productTypeName + ' ') - 1)) = 'fragile'
    -- AND LOWER(REVERSE(SUBSTRING(REVERSE(dsType.deliveryServiceName), 1, CHARINDEX(' ', REVERSE(dsType.deliveryServiceName) + ' ') - 1))) = 'air'


GO
SELECT * FROM Staff_Transaction_Details


GO
DROP VIEW Staff_Transaction_Details


-- END
