-- =====================================================
-- Language Center Data Analysis Project
-- Author: Abdelrahman Adel
-- Database: SQL Server
-- =====================================================

USE DZ_Analysis;
GO

-- =====================================================
-- SECTION 1: Basic Queries
-- =====================================================s

-- 1. Total Number of Students
SELECT
    COUNT(*) AS Total_Students
FROM students;

----------------------------------------------------------

-- 2. Number of Students by Period
SELECT
    Period,
    COUNT(*) AS Total_Students
FROM students
GROUP BY Period;

----------------------------------------------------------

-- 3. Number of Students by Level
SELECT
    Level,
    COUNT(*) AS Total_Students
FROM students
GROUP BY Level
ORDER BY Total_Students DESC;

----------------------------------------------------------

-- 4. Number of Students by Marketing Channel
SELECT
    Marketing_Channel,
    COUNT(*) AS Total_Students
FROM students
GROUP BY Marketing_Channel
ORDER BY Total_Students DESC;

----------------------------------------------------------

-- 5. Number of Students by Time Slot
SELECT
    Time_Slot,
    COUNT(*) AS Total_Students
FROM students
GROUP BY Time_Slot
ORDER BY Total_Students DESC;

----------------------------------------------------------

-- 6. Student Status Distribution
SELECT
    Status,
    COUNT(*) AS Total_Students
FROM students
GROUP BY Status
ORDER BY Total_Students DESC;

----------------------------------------------------------

-- =====================================================
-- SECTION 2: Filtering Queries
-- =====================================================

-- 7. Post-Implementation Students
SELECT
    Student_ID,
    Level,
    Marketing_Channel
FROM students
WHERE Period = 'Post-Implementation';

----------------------------------------------------------

-- 8. Students with High Feedback
SELECT
    Student_ID,
    Feedback_Score
FROM students
WHERE Feedback_Score >= 4;

----------------------------------------------------------

-- 9. Students with High Attendance
SELECT
    Student_ID,
    Attendance_Rate
FROM students
WHERE Attendance_Rate >= 0.80;

----------------------------------------------------------

-- 10. Students in Level A1
SELECT
    Student_ID,
    Level
FROM students
WHERE Level = 'A1';

----------------------------------------------------------

-- =====================================================
-- SECTION 3: Aggregate Functions
-- =====================================================

-- 11. Average Feedback by Period
SELECT
    Period,
    AVG(Feedback_Score) AS Avg_Feedback
FROM students
GROUP BY Period;

----------------------------------------------------------

-- 12. Average Attendance by Level
SELECT
    Level,
    AVG(Attendance_Rate) AS Avg_Attendance
FROM students
GROUP BY Level;

----------------------------------------------------------

-- 13. Average Attendance by Time Slot
SELECT
    Time_Slot,
    AVG(Attendance_Rate) AS Avg_Attendance
FROM students
GROUP BY Time_Slot
ORDER BY Avg_Attendance DESC;

----------------------------------------------------------

-- =====================================================
-- SECTION 4: HAVING Clause
-- =====================================================

-- 14. Levels with More Than 50 Students
SELECT
    Level,
    COUNT(*) AS Total_Students
FROM students
GROUP BY Level
HAVING COUNT(*) > 50;

----------------------------------------------------------

-- 15. Marketing Channels with More Than 100 Students
SELECT
    Marketing_Channel,
    COUNT(*) AS Total_Students
FROM students
GROUP BY Marketing_Channel
HAVING COUNT(*) > 100;

----------------------------------------------------------

-- =====================================================
-- SECTION 5: CASE Statement
-- =====================================================

-- 16. Attendance Classification
SELECT
    Student_ID,
    Attendance_Rate,

    CASE
        WHEN Attendance_Rate >= 0.80 THEN 'Excellent'
        WHEN Attendance_Rate >= 0.60 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS Attendance_Status

FROM students;

----------------------------------------------------------

-- =====================================================
-- SECTION 6: Ranking & Window Function
-- =====================================================

-- 17. Top 10 Highest Attendance
SELECT TOP (10)
    Student_ID,
    Attendance_Rate
FROM students
ORDER BY Attendance_Rate DESC;

----------------------------------------------------------

-- 18. Lowest 10 Feedback Scores
SELECT TOP (10)
    Student_ID,
    Feedback_Score
FROM students
ORDER BY Feedback_Score ASC;

----------------------------------------------------------

-- 19. Attendance Ranking
SELECT
    Student_ID,
    Attendance_Rate,
    RANK() OVER
    (
        ORDER BY Attendance_Rate DESC
    ) AS Attendance_Rank
FROM students;

----------------------------------------------------------

-- =====================================================
-- SECTION 7: Subquery
-- =====================================================

-- 20. Students with Maximum Feedback Score
SELECT
    Student_ID,
    Level,
    Feedback_Score
FROM students
WHERE Feedback_Score =
(
    SELECT MAX(Feedback_Score)
    FROM students
);

----------------------------------------------------------

-- =====================================================
-- SECTION 8: Monthly Performance Analysis
-- =====================================================

-- 21. Total Leads
SELECT
    SUM(Leads) AS Total_Leads
FROM monthly_performance;

----------------------------------------------------------

-- 22. Total Registrations
SELECT
    SUM(Registrations) AS Total_Registrations
FROM monthly_performance;

----------------------------------------------------------

-- 23. Monthly Conversion Rate
SELECT
    Month,
    Year,
    Leads,
    Registrations,

    CAST(
        (Registrations * 100.0) / Leads
        AS DECIMAL(5,2)
    ) AS Conversion_Rate

FROM monthly_performance
ORDER BY Year, Month;

----------------------------------------------------------

-- 24. Best Performing Month
SELECT TOP (1)
    Month,
    Year,
    Leads,
    Registrations
FROM monthly_performance
ORDER BY Registrations DESC;

----------------------------------------------------------

-- 25. Average Monthly Leads
SELECT
    AVG(Leads) AS Average_Leads
FROM monthly_performance;

----------------------------------------------------------

-- 26. Average Monthly Registrations
SELECT
    AVG(Registrations) AS Average_Registrations
FROM monthly_performance;

----------------------------------------------------------

-- ===================== END OF PROJECT =====================