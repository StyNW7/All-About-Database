-- SIMPLE QUERIES

use SUNIBversity

GO

-- DISTINCT


SELECT DISTINCT C.CourseName
FROM Courses C
JOIN Enrollments E ON C.CourseID = E.CourseID;


-- WHERE


SELECT Name, GPA FROM Students
WHERE GPA > 3.0;
GO


-- MULTI TABLE JOINS

SELECT * FROM Students

-- Student that enroll a course

SELECT Name FROM Students
WHERE StudentID IN (SELECT StudentID FROM Enrollments);
GO


-- JOIN


-- INNER JOIN

-- SELECT ALL NAMES AND COURSES


SELECT Students.Name, Courses.CourseName
FROM Students
INNER JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
INNER JOIN Courses ON Enrollments.CourseID = Courses.CourseID;
GO


-- LEFT JOIN

-- SELECT IF THERE IS NAME AND COURSE IN THE TABLE ON LEFT JOIN BY ON ENROLLMENTS TABLE


SELECT Students.Name, Courses.CourseName
FROM Students
LEFT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
LEFT JOIN Courses ON Enrollments.CourseID = Courses.CourseID;


-- RIGHT JOIN

-- SELECT IF THERE IS COURSE AND NAME IN THE TABLE ON RIGHT JOIN BY ON ENROLLMENTS TABLE


SELECT Students.Name, Courses.CourseName
FROM Students
RIGHT JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
RIGHT JOIN Courses ON Enrollments.CourseID = Courses.CourseID;


-- COUNT STUDENTS IN EACH COURSE


SELECT C.CourseName, COUNT(E.StudentID) AS StudentCount
FROM Courses C
LEFT JOIN Enrollments E ON C.CourseID = E.CourseID
GROUP BY C.CourseName;



-- FULL JOIN


SELECT Students.Name, Courses.CourseName, Enrollments.EnrollmentDate

FROM Students

JOIN Enrollments ON Students.StudentID = Enrollments.StudentID
JOIN Courses ON Enrollments.CourseID = Courses.CourseID;

