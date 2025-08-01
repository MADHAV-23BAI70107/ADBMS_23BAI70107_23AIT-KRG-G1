--EXP 2 (MEDIUM)

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    ManagerID INT NULL  
);

INSERT INTO Employee (EmpID, EmpName, Department, ManagerID)
VALUES
(1, 'Alice', 'HR', NULL),        
(2, 'Bob', 'Finance', 1),
(3, 'Charlie', 'IT', 1),
(4, 'David', 'Finance', 2),
(5, 'Eve', 'IT', 3),
(6, 'Frank', 'HR', 1);

ALTER table Employee
add constraint fk_Employee foreign key (ManagerID) references Employee (EmpID);

select e1.EmpName as Employee_Name, e2.EmpName as Manager_Name, e1.Department as Employee_Dept, e2.Department as MANAGER_DEPT
from Employee e1
left outer join Employee e2
on e1.ManagerID=e2.EmpID;




--EXP 2 (HARD)


CREATE TABLE Year_tbl (
      ID INT,
      YEAR INT,
      NPV INT
  );


  CREATE TABLE Queries (
      ID INT,
      YEAR INT
  );

  INSERT INTO Year_tbl (ID, YEAR, NPV)
  VALUES
  (1, 2018, 100),
  (7, 2020, 30),
  (13, 2019, 40),
  (1, 2019, 113),
  (2, 2008, 121),
  (3, 2009, 12),
  (11, 2020, 99),
  (7, 2019, 0);


  INSERT INTO Queries (ID, YEAR)
  VALUES
  (1, 2019),
  (2, 2008),
  (3, 2009),
  (7, 2018),
  (7, 2019),
  (7, 2020),
  (13, 2019);
  
SELECT Q.ID, Q.YEAR, ISNULL(Y.NPV,0)
FROM QUERIES AS Q
LEFT OUTER JOIN
YEAR_TBL AS Y
ON
Q.ID = Y.ID
AND
Q.YEAR = Y.YEAR