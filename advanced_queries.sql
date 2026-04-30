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
    COALESCE(SUM(ss.total_submissions), 0),
    COALESCE(SUM(ss.total_accepted_submissions), 0),
    COALESCE(SUM(vs.total_views), 0),
    COALESCE(SUM(vs.total_unique_views), 0)
FROM Contests c

JOIN Colleges col 
    ON c.contest_id = col.contest_id

JOIN Challenges ch 
    ON col.college_id = ch.college_id

LEFT JOIN (
    SELECT 
        challenge_id,
        SUM(total_submissions) AS total_submissions,
        SUM(total_accepted_submissions) AS total_accepted_submissions
    FROM Submission_Stats
    GROUP BY challenge_id
) ss
ON ch.challenge_id = ss.challenge_id

LEFT JOIN (
    SELECT 
        challenge_id,
        SUM(total_views) AS total_views,
        SUM(total_unique_views) AS total_unique_views
    FROM View_Stats
    GROUP BY challenge_id
) vs
ON ch.challenge_id = vs.challenge_id

GROUP BY c.contest_id, c.hacker_id, c.name

HAVING 
    COALESCE(SUM(ss.total_submissions), 0) +
    COALESCE(SUM(ss.total_accepted_submissions), 0) +
    COALESCE(SUM(vs.total_views), 0) +
    COALESCE(SUM(vs.total_unique_views), 0) > 0

ORDER BY c.contest_id;


----------------------------------------------------------------------------------------------------------------------------------------------
/*
Problem: 15 Days of Learning SQL
Concept: Subquery + Continuos logic
*/

SELECT 
    submission_date,
    (
        SELECT COUNT(DISTINCT s1.hacker_id)
        FROM Submissions s1
        WHERE s1.submission_date = s.submission_date
        AND (
            SELECT COUNT(DISTINCT s2.submission_date)
            FROM Submissions s2
            WHERE s2.hacker_id = s1.hacker_id
            AND s2.submission_date < s.submission_date
        ) = DATEDIFF(s.submission_date, '2016-03-01')
    ) AS consistent_count,
    (
        SELECT hacker_id
        FROM Submissions s3
        WHERE s3.submission_date = s.submission_date
        GROUP BY hacker_id
        ORDER BY COUNT(submission_id) DESC, hacker_id ASC
        LIMIT 1
    ) AS leader_id,
    (
        SELECT name
        FROM Hackers
        WHERE hacker_id = (
            SELECT hacker_id
            FROM Submissions s4
            WHERE s4.submission_date = s.submission_date
            GROUP BY hacker_id
            ORDER BY COUNT(submission_id) DESC, hacker_id ASC
            LIMIT 1
        )
    ) AS leader_name
FROM (SELECT DISTINCT submission_date FROM Submissions) s
ORDER BY submission_date;
        
