-- Use Database

use ArsipBiru

-- Testing Database

SELECT * FROM MsAccount

SELECT * FROM MsBanner

SELECT * FROM MsUnit

SELECT * FROM MsArea

-- Index: Use to make the query faster


CREATE UNIQUE INDEX PrintUserAccount
ON MsAccount (AccountName)

DROP INDEX MsAccount.PrintUserAccount

SELECT * FROM MsAccount


-- View: is a virtual table based on the result-set of an SQL statement.

GO

CREATE VIEW [Unit Viewer] AS
SELECT UnitName, UnitRarity
FROM MsUnit

-- Checking

SELECT * FROM [Unit Viewer]

GO

DROP VIEW [Unit Viewer]


-- Character Function


SELECT * FROM MsAccount


-- LEN


SELECT
	[AccountName Length] = LEN(AccountName)
FROM
	MsAccount


-- UPPER


SELECT
	[AccountName Upper] = UPPER(AccountName)
FROM
	MsAccount


-- LOWER


SELECT
	[AccountName Lower] = LOWER(AccountName)
FROM
	MsAccount


-- SUBSTRING


SELECT
	[AccountName Substring] = SUBSTRING(AccountName, 1, 10)
FROM
	MsAccount


-- LEFT


SELECT
	[AccountName Left] = LEFT(AccountName, 1)
FROM
	MsAccount


-- RIGHT


SELECT
	[AccountName Right] = RIGHT(AccountName, 1)
FROM
	MsAccount


-- Character Case


SELECT * FROM MsMission

SELECT

	SUBSTRING(m.MissionName, 1, CHARINDEX(' ', m.MissionName + ' ') - 1) AS [Mission First Name],
    REVERSE(SUBSTRING(REVERSE(m.MissionName), 1, CHARINDEX(' ', REVERSE(m.MissionName) + ' ') - 1)) AS [Mission Last Name],

	[Mission Fullname] = CONCAT(SUBSTRING(m.MissionName, 1, CHARINDEX(' ', m.MissionName + ' ') - 1), ' ', 
	REVERSE(SUBSTRING(REVERSE(m.MissionName), 1, CHARINDEX(' ', REVERSE(m.MissionName) + ' ') - 1)))
FROM
	MsMission m	



-- DATE FUNCTION


SELECT GETDATE() AS CurrentDateTime;


SELECT
	BannerName,
	BannerReleaseDate AS OldDate,
	DATEADD(DAY, 5, BannerReleaseDate) AS NewDate
FROM MsBanner;



SELECT DATEDIFF(YEAR, '2024-01-01', GETDATE()) AS DaysDifference;
GO



SELECT * FROM MsBanner
WHERE MONTH(BannerReleaseDate) = 8;



-- JOIN


SELECT
    b.BannerID,
    b.BannerName,
    b.BannerUnitID,
    ab.BannerRoll
FROM
    MsBanner b
JOIN
    AccountBanners ab ON b.BannerID = ab.BannerID
GROUP BY
    b.BannerID,
    b.BannerName,
    b.BannerUnitID



SELECT
    b.BannerID,
    b.BannerName,
    b.BannerUnitID,
    SUM(ab.BannerRoll) AS TotalRolls
FROM
    MsBanner b
JOIN
    AccountBanners ab ON b.BannerID = ab.BannerID
GROUP BY
    b.BannerID,
    b.BannerName,
    b.BannerUnitID