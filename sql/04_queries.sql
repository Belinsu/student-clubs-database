-- Student Clubs & Organizations Database Management System
-- MIS 236 Database Systems, Bogazici University (Spring 2025)

-- Ten reporting queries.

-- Query 1: Events organized by cultural ("Kültürel") organizations.
SELECT E.Title
FROM EVENT E
JOIN ORGANIZATION O ON E.OrgID = O.OrgID
WHERE O.Type = 'Kültürel';

-- Query 2: Companies that took part in events attended by at least one
-- Computer Engineering student.
SELECT DISTINCT C.Name
FROM COMPANY C
JOIN COMPANY_EVENT CE ON C.CompanyID = CE.CompanyID
JOIN EVENT E ON CE.EventID = E.EventID
WHERE E.EventID IN (
    SELECT P.EventID
    FROM PARTICIPATION P
    JOIN STUDENT S ON P.StudentID = S.StudentID
    WHERE S.Department = 'Bilgisayar Mühendisliği'
);

-- Query 3: Events with both student participation and company participation.
SELECT E.Title
FROM EVENT E
WHERE EXISTS (
    SELECT 1 FROM PARTICIPATION P WHERE P.EventID = E.EventID
)
AND EXISTS (
    SELECT 1 FROM COMPANY_EVENT CE WHERE CE.EventID = E.EventID
);

-- Query 4: Organizations that have an advisor and at least one student member.
SELECT DISTINCT O.Name
FROM ORGANIZATION O
WHERE EXISTS (SELECT 1 FROM ADVISOR A WHERE A.OrgID = O.OrgID)
AND EXISTS (SELECT 1 FROM MEMBERSHIP M WHERE M.OrgID = O.OrgID);

-- Query 5: Faculty members advising organizations whose events had company
-- participation.
SELECT DISTINCT F.Name
FROM FACULTY_STAFF F
JOIN ADVISOR A ON F.StaffID = A.StaffID
JOIN ORGANIZATION O ON A.OrgID = O.OrgID
JOIN EVENT E ON O.OrgID = E.OrgID
JOIN COMPANY_EVENT CE ON E.EventID = CE.EventID;

-- Query 6: Companies that participated in every event hosted by a given
-- organization (here: IEEE).
SELECT DISTINCT C.Name
FROM COMPANY C
WHERE NOT EXISTS (
    SELECT 1 FROM EVENT E
    JOIN ORGANIZATION O ON E.OrgID = O.OrgID
    WHERE O.Name = 'IEEE'
    AND E.EventID NOT IN (
        SELECT CE.EventID FROM COMPANY_EVENT CE WHERE CE.CompanyID = C.CompanyID
    )
);

-- Query 7: Per-student summary: department, events attended, organizations
-- joined and working groups joined.
SELECT S.Name, S.Department,
    COUNT(DISTINCT P.EventID) AS EventCount,
    COUNT(DISTINCT M.OrgID) AS OrgCount,
    COUNT(DISTINCT WGM.GroupID) AS WorkingGroupCount
FROM STUDENT S
LEFT JOIN PARTICIPATION P ON S.StudentID = P.StudentID
LEFT JOIN MEMBERSHIP M ON S.StudentID = M.StudentID
LEFT JOIN WORKING_GROUP_MEMBERSHIP WGM ON S.StudentID = WGM.StudentID
GROUP BY S.StudentID, S.Name, S.Department
ORDER BY EventCount DESC;

-- Query 8: Per-organization overview: type, member count, events hosted and
-- advisor (if any).
SELECT O.Name AS Organization, O.Type,
    COUNT(DISTINCT M.StudentID) AS MemberCount,
    COUNT(DISTINCT E.EventID) AS EventCount,
    F.Name AS Advisor
FROM ORGANIZATION O
LEFT JOIN MEMBERSHIP M ON O.OrgID = M.OrgID
LEFT JOIN EVENT E ON O.OrgID = E.OrgID
LEFT JOIN ADVISOR A ON O.OrgID = A.OrgID
LEFT JOIN FACULTY_STAFF F ON A.StaffID = F.StaffID
GROUP BY O.OrgID, O.Name, O.Type, F.Name;

-- Query 9: Per-company analytics: sector, events attended and distinct venues.
SELECT C.Name AS Company, C.Sector,
    COUNT(DISTINCT CE.EventID) AS EventCount,
    COUNT(DISTINCT V.VenueID) AS VenueCount
FROM COMPANY C
JOIN COMPANY_EVENT CE ON C.CompanyID = CE.CompanyID
JOIN EVENT E ON CE.EventID = E.EventID
JOIN VENUE V ON E.VenueID = V.VenueID
GROUP BY C.CompanyID, C.Name, C.Sector
ORDER BY EventCount DESC;

-- Query 10: Working groups with their student members and departments.
SELECT WG.Name AS WorkingGroup, S.Name AS Student, S.Department
FROM WORKING_GROUP WG
JOIN WORKING_GROUP_MEMBERSHIP WGM ON WG.GroupID = WGM.GroupID
JOIN STUDENT S ON WGM.StudentID = S.StudentID
ORDER BY WG.Name, S.Name;
