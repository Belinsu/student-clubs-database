-- Student Clubs & Organizations Database Management System
-- MIS 236 Database Systems, Bogazici University (Spring 2025)

-- Three stored procedures (Microsoft SQL Server / T-SQL).

-- Procedure 1: Event titles a given company has participated in.
CREATE OR ALTER PROCEDURE GetEventsByCompany
    @company_name NVARCHAR(255)
AS
BEGIN
    SELECT E.Title
    FROM EVENT E
    JOIN COMPANY_EVENT CE ON E.EventID = CE.EventID
    JOIN COMPANY C ON CE.CompanyID = C.CompanyID
    WHERE C.Name = @company_name;
END;
GO

EXEC GetEventsByCompany @company_name = 'Arçelik A.Ş.';
GO

-- Procedure 2: Names and e-mails of students in a given department.
CREATE OR ALTER PROCEDURE GetStudentsByDepartment
    @dept_name NVARCHAR(255)
AS
BEGIN
    SELECT Name, Email
    FROM STUDENT
    WHERE Department = @dept_name;
END;
GO

EXEC GetStudentsByDepartment @dept_name = 'Bilgisayar Mühendisliği';
GO

-- Procedure 3: Events held in venues with at least a given capacity.
CREATE OR ALTER PROCEDURE GetEventsByVenueCapacity
    @min_capacity INT
AS
BEGIN
    SELECT E.Title, V.Name
    FROM EVENT E
    JOIN VENUE V ON E.VenueID = V.VenueID
    WHERE V.Capacity >= @min_capacity;
END;
GO

EXEC GetEventsByVenueCapacity @min_capacity = 100;
GO
