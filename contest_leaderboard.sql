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
