-- Problem: SQL Project Planning
-- Platform: HackerRank
-- Difficulty: Advanced

-- Approach:
-- 1. Use ROW_NUMBER() to identify sequence
-- 2. Group consecutive dates using DATE_SUB trick
-- 3. Aggregate start and end dates

SELECT 
    MIN(start_date) AS project_start,
    MAX(end_date) AS project_end
FROM (
    SELECT 
        start_date,
        end_date,
        DATE_SUB(start_date, INTERVAL ROW_NUMBER() OVER (ORDER BY start_date) DAY) AS grp
    FROM Projects
) t
GROUP BY grp
ORDER BY DATEDIFF(MAX(end_date), MIN(start_date)), MIN(start_date);




