-- Problem: The PADS (HackerRank)
-- Topic: SQL - Advanced Select

-- 1. Names with first letter of occupation
SELECT CONCAT(Name, '(', LEFT(Occupation, 1), ')')
FROM OCCUPATIONS
ORDER BY Name;

-- 2. Count of each occupation
SELECT CONCAT(
    'There are a total of ',
    COUNT(*),
    ' ',
    LOWER(Occupation),
    's.'
)
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(*), LOWER(Occupation);

------------------------------------------------------------------------------------------------------------------------------------------------
-- 2: Occupations (Pivot)

 
     
SELECT
    MAX(CASE WHEN Occupation = 'Doctor' THEN Name END) AS Doctor,
    MAX(CASE WHEN Occupation = 'Professor' THEN Name END) AS Professor,
    MAX(CASE WHEN Occupation = 'Singer' THEN Name END) AS Singer,
    MAX(CASE WHEN Occupation = 'Actor' THEN Name END) AS Actor
FROM
(
    SELECT Name, Occupation,
           ROW_NUMBER() OVER (PARTITION BY Occupation ORDER BY Name) AS rn
    FROM OCCUPATIONS
) t
GROUP BY rn;


----------------------------------------------------------------------------------------------------------------------------------------------
-- ============================================
-- Problem: Contest Leaderboard
-- Platform: HackerRank
-- Difficulty: Advanced
-- ============================================

/*
Problem Summary:
- Find total score of each hacker.
- Total score = sum of MAX score in each challenge.
- Only include hackers with total score > 0.
- Sort:
    1. Total score DESC
    2. hacker_id ASC
*/

SELECT 
    h.hacker_id,
    h.name,
    SUM(max_score) AS total_score
FROM Hackers h
JOIN (
    SELECT 
        hacker_id,
        challenge_id,
        MAX(score) AS max_score
    FROM Submissions
    GROUP BY hacker_id, challenge_id
) s
ON h.hacker_id = s.hacker_id
GROUP BY h.hacker_id, h.name
HAVING SUM(max_score) > 0
ORDER BY total_score DESC, h.hacker_id ASC;


----------------------------------------------------------------------------------------------------------------------------------------------
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


-- ============================================-------------------------------------------------------------------------------------------
-- Problem: Interviews
-- Platform: HackerRank
-- Difficulty: Advanced
-- ============================================

/*
Goal:
For each contest, print:
- contest_id
- hacker_id
- name
- sum of:
    total_submissions
    total_accepted_submissions
    total_views
    total_unique_views

Condition:
- Exclude contests where all 4 sums = 0
- Order by contest_id
*/

SELECT 
    c.contest_id,
    c.hacker_id,
    c.name,
    SUM(s.total_submissions) AS total_submissions,
    SUM(s.total_accepted_submissions) AS total_accepted_submissions,
    SUM(v.total_views) AS total_views,
    SUM(v.total_unique_views) AS total_unique_views
FROM Contests c
JOIN Colleges col 
    ON c.contest_id = col.contest_id
JOIN Challenges ch 
    ON col.college_id = ch.college_id
LEFT JOIN Submission_Stats s 
    ON ch.challenge_id = s.challenge_id
LEFT JOIN View_Stats v 
    ON ch.challenge_id = v.challenge_id
GROUP BY c.contest_id, c.hacker_id, c.name
HAVING 
    SUM(s.total_submissions) > 0 OR
    SUM(s.total_accepted_submissions) > 0 OR
    SUM(v.total_views) > 0 OR
    SUM(v.total_unique_views) > 0
ORDER BY c.contest_id;












