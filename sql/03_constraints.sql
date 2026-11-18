-- Student Clubs & Organizations Database Management System
-- MIS 236 Database Systems, Bogazici University (Spring 2025)

-- CHECK constraints enforcing the business rules. Run after the sample data
-- has been loaded.

ALTER TABLE Student
    ADD CONSTRAINT chk_student_email CHECK (Email LIKE '%.edu.tr');

ALTER TABLE Venue
    ADD CONSTRAINT chk_venue_capacity CHECK (Capacity > 0);

ALTER TABLE Membership
    ADD CONSTRAINT chk_membership_dates CHECK (EndDate > StartDate);

ALTER TABLE Company
    ADD CONSTRAINT chk_company_type
    CHECK (ParticipationType IN ('Sponsor', 'Konuşmacı', 'Katılımcı', 'Destekçi'));
