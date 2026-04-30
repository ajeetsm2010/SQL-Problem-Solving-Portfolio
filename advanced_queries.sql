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











