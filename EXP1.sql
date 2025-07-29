
/*
Easy-Level Problem

Problem Title: Author-Book Relationship Using Joins and Basic SQL Operations
Procedure (Step-by-Step):
Design two tables — one for storing author details and the other for book details.

Ensure a foreign key relationship from the book to its respective author.

Insert at least three records in each table.

Perform an INNER JOIN to link each book with its author using the common author ID.

Select the book title, author name, and author’s country.

Sample Output Description:

When the join is performed, we get a list where each book title is shown along 
with its author’s name and their country.

*/

/*

	EMPID(P.K)      EMP_NAME     MANAGER_ID(F.K)
	  1            A             2
	  2            B             1


	  OUTPUT:
	  EMP_NAME     MANAGER_NAME
	     A             B
		 B             A

*/



-- min num of tables required for using foreign key is 1.
-- for joins too it is 1. but only if atleast one column should be same




/*
1. inner join(matching data from both tables)
2. left outer join (left full data + common data)
3. right outer join (right full data + common data)
4. full join (l+r+ common data)
5 self join 
6. left exclusive join
7 right exclusive join.
*/




create database ADBMS;
use ADBMS;

create table author(
	a_id int primary key,
	a_name varchar(max),
	country varchar(max)
)

create table books(
	b_id int primary key,
	b_title varchar(max),
	aid int
	foreign key (aid) references author(a_id)

)
-- to use a column name as a keyword name that are predefined so use '' single quote string for name or the square brackets
-- belo we used [] square brackets as name is a keyword already.
--SYNATX: BOOK NAME
SELECT b.b_title AS [BOOK NAME], A.a_name, A.country
FROM books AS B
INNER JOIN
author AS A
ON
B.aid = A.a_id










-----------------MEDIUM LEVEL-------------------------


/*
Problem Title: Department-Course Subquery and Access Control
Procedure (Step-by-Step):

Design normalized tables for departments and the courses they offer, maintaining a foreign key relationship.

Insert five departments and at least ten courses across those departments.

Use a subquery to count the number of courses under each department.

Filter and retrieve only those departments that offer more than two courses.

Grant SELECT-only access on the courses table to a specific user.

Sample Output Description:

The result shows the names of departments which are associated with more than two courses in the system.


*/




-- Create Department Table
CREATE TABLE Department (
    DeptID INT PRIMARY KEY,
    DeptName VARCHAR(100)
);

-- Create Course Table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    DeptID INT,
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);


-- Insert Departments
INSERT INTO Department VALUES
(1, 'Computer Science'),
(2, 'Physics'),
(3, 'Mathematics'),
(4, 'Chemistry'),
(5, 'Biology');

-- Insert Courses
INSERT INTO Course VALUES
(101, 'Data Structures', 1),
(102, 'Operating Systems', 1),
(103, 'Quantum Mechanics', 2),
(104, 'Electromagnetism', 2),
(105, 'Linear Algebra', 3),
(106, 'Calculus', 3),
(107, 'Organic Chemistry', 4),
(108, 'Physical Chemistry', 4),
(109, 'Genetics', 5),
(110, 'Molecular Biology', 5);




-- SUBQUERY TO GET DEPTID WITH COUNT
SELECT DeptID, COUNT(*) AS TOTALCOUNT
FROM Course GROUP BY DeptID


-- SUBQUERY TO HAVE DEPT ID WITH COUNT >2
select DEPTNAME FROM Department WHERE DeptID IN
(
	SELECT DEPTID FROM COURSE
	GROUP BY DeptID
	HAVING COUNT(*)>1
)




--IN ORDER TO CREATE USER
-- 1. TO CREATE THE LOGIN - ADMIN
-- 2. TO CREATE THE USER


-- 1. TO CREATE THE LOGIN - ADMIN

CREATE LOGIN TEST_LOGIN
WITH PASSWORD = 'TESTLOGIN@123';

CREATE USER TEST_USER
FOR LOGIN TEST_LOGIN


EXECUTE AS USER = 'TEST_USER'

GRANT SELECT, UPDATE ON COURSE TO TEST_USER
