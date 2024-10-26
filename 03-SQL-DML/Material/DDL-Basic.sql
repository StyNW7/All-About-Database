-- Database

use master
DROP DATABASE SUNIBversity

CREATE DATABASE SUNIBversity

USE SUNIBversity


-- Table

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Birthdate DATE,
    GPA DECIMAL(3,2)
);


CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName NVARCHAR(50),
    Credits INT
);


CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)

);


-- INSERT


INSERT INTO Students (StudentID, Name, Birthdate, GPA) VALUES
(13, 'Johnson', '2000-05-15', NULL),
(14, 'Al', '2000-05-15', NULL),
(15, 'Ali', '2000-05-15', NULL),
(1, 'Alice Johnson', '2000-05-15', 3.75),
(2, 'Bob Smith', '1999-09-22', 3.50),
(3, 'Charlie Brown', '2001-03-30', 3.80),
(4, 'Diana Prince', '1998-12-05', 3.60),
(5, 'Ethan Hunt', '2000-07-20', 3.90),
(6, 'Fiona Apple', '1997-11-12', 3.45),
(7, 'George Lucas', '1998-01-29', 3.20),
(8, 'Hannah Baker', '2000-10-08', 3.85),
(9, 'Isaac Newton', '1999-03-14', 3.95),
(10, 'Julia Roberts', '2001-04-01', 2.80),
(11, 'Kevin Hart', '1999-12-31', 3.00),
(12, 'Lily Collins', '2000-01-15', 3.25);



INSERT INTO Courses (CourseID, CourseName, Credits) VALUES
(1, 'Database Management Systems', 3),
(2, 'Object-Oriented Programming', 4),
(3, 'Web Development', 3),
(4, 'Data Structures', 3),
(5, 'Software Engineering', 4),
(6, 'Artificial Intelligence', 4),
(7, 'Operating Systems', 3),
(8, 'Computer Networks', 3),
(9, 'Human-Computer Interaction', 2),
(10, 'Cloud Computing', 4),
(11, 'Game Development', 4),
(12, 'Cyber Security', 3);




INSERT INTO Enrollments (EnrollmentID, StudentID, CourseID, EnrollmentDate) VALUES
(1, 1, 1, '2023-01-15'),
(2, 1, 2, '2023-01-20'),
(3, 1, 3, '2023-01-25'),
(4, 2, 1, '2023-01-18'),
(5, 2, 3, '2023-01-22'),
(6, 2, 5, '2023-02-01'),
(7, 3, 2, '2023-02-10'),
(8, 3, 6, '2023-02-15'),
(9, 4, 4, '2023-01-28'),
(10, 4, 1, '2023-02-20'),
(11, 5, 5, '2023-02-15'),
(12, 5, 7, '2023-02-18'),
(13, 6, 8, '2023-03-01'),
(14, 6, 2, '2023-03-02'),
(15, 7, 9, '2023-03-05'),
(16, 8, 3, '2023-03-10'),
(17, 8, 10, '2023-03-12'),
(18, 9, 1, '2023-03-15'),
(19, 10, 4, '2023-03-20'),
(20, 10, 3, '2023-03-22');



/*SELECT DISTINCT C.CourseName
FROM Courses C
JOIN Enrollments E ON C.CourseID = E.CourseID;*/



--CREATE DATABASE DKBase

--USE DKBase

--CREATE TABLE Testing(
--	TestingName VARCHAR(255) PRIMARY KEY,
--);


--CREATE TABLE Post (
--	PostName VARCHAR(255) PRIMARY KEY,
--	TestingName VARCHAR(255)
--	FOREIGN KEY (TestingName) REFERENCES Testing(TestingName),
--);

--INSERT INTO Testing VALUES
--('DK')

--INSERT INTO Post VALUES
--('Test4', 'SNW'),
--('Test1', 'DK'),
--('Test2', 'DK'),
--('Test3', 'DK'),

--SELECT * FROM Testing
--JOIN Post ON Post.TestingName = Testing.TestingName