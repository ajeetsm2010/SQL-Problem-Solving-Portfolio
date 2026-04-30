-- INTERMEDIATE SQL QUERIES
-- Topics: Joins, Self Joins, Logical Conditions
-- Author: Ajeet Yadav

-- SECTION 1: JOINS

-- 1. Placements: Students whose friend's salary is higher
SELECT S.NAME
FROM STUDENTS S
JOIN FRIENDS F ON S.ID = F.ID
JOIN PACKAGES P1 ON S.ID = P1.ID
JOIN PACKAGES P2 ON F.FRIEND_ID = P2.ID
WHERE P2.SALARY > P1.SALARY
ORDER BY P2.SALARY;

-- 2. Symmetric Pairs: Find all symmetric (X, Y) pairs
SELECT DISTINCT F1.X, F1.Y
FROM FUNCTIONS F1
JOIN FUNCTIONS F2
ON F1.X = F2.Y AND F1.Y = F2.X
WHERE F1.X <= F1.Y
ORDER BY F1.X;

