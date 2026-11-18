-- Student Clubs & Organizations Database Management System
-- MIS 236 Database Systems, Bogazici University (Spring 2025)
-- Target DBMS: Microsoft SQL Server (the statements below are standard SQL)

-- Table definitions, in dependency order.

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(100),
    StartYear INT,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20)
);

CREATE TABLE Faculty_Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(100),
    Title VARCHAR(100)
);

CREATE TABLE Organization (
    OrgID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Type VARCHAR(100),
    ContactInfo VARCHAR(150)
);

CREATE TABLE Membership (
    StudentID INT,
    OrgID INT,
    Position VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    PRIMARY KEY (StudentID, OrgID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (OrgID) REFERENCES Organization(OrgID)
);

CREATE TABLE Advisor (
    StaffID INT,
    OrgID INT,
    PRIMARY KEY (StaffID, OrgID),
    FOREIGN KEY (StaffID) REFERENCES Faculty_Staff(StaffID),
    FOREIGN KEY (OrgID) REFERENCES Organization(OrgID)
);

CREATE TABLE Venue (
    VenueID INT PRIMARY KEY,
    Name VARCHAR(100),
    Capacity INT,
    Location VARCHAR(100),
    Type VARCHAR(50)
);

CREATE TABLE Event (
    EventID INT PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    EventDate DATE,
    EventTime TIME,
    Description VARCHAR(150),
    VenueID INT,
    OrgID INT,
    FOREIGN KEY (VenueID) REFERENCES Venue(VenueID),
    FOREIGN KEY (OrgID) REFERENCES Organization(OrgID)
);

CREATE TABLE Participation (
    StudentID INT,
    EventID INT,
    PRIMARY KEY (StudentID, EventID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

CREATE TABLE Company (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Sector VARCHAR(100),
    ContactInfo VARCHAR(100),
    ParticipationType VARCHAR(100)
);

CREATE TABLE Company_Event (
    CompanyID INT,
    EventID INT,
    PRIMARY KEY (CompanyID, EventID),
    FOREIGN KEY (CompanyID) REFERENCES Company(CompanyID),
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

CREATE TABLE Working_Group (
    GroupID INT PRIMARY KEY,
    Name VARCHAR(100),
    Description VARCHAR(150),
    EventID INT,
    FOREIGN KEY (EventID) REFERENCES Event(EventID)
);

CREATE TABLE Working_Group_Membership (
    GroupID INT,
    StudentID INT,
    PRIMARY KEY (GroupID, StudentID),
    FOREIGN KEY (GroupID) REFERENCES Working_Group(GroupID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID)
);
