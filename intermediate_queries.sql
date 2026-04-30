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

-- 3. Binary Tree Nodes

SELECT 
    N,
    CASE
        WHEN P IS NULL THEN 'Root'
        WHEN N NOT IN (SELECT P FROM BST WHERE P IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END
FROM BST
ORDER BY N;


-- =========================================
-- 4: New Companies
-- Topic: Joins + Aggregation
-- =========================================

SELECT c.company_code,
       c.founder,
       COUNT(DISTINCT lm.lead_manager_code) AS total_lead_managers,
       COUNT(DISTINCT sm.senior_manager_code) AS total_senior_managers,
       COUNT(DISTINCT m.manager_code) AS total_managers,
       COUNT(DISTINCT e.employee_code) AS total_employees
FROM Company c
LEFT JOIN Lead_Manager lm 
    ON c.company_code = lm.company_code
LEFT JOIN Senior_Manager sm 
    ON lm.lead_manager_code = sm.lead_manager_code
LEFT JOIN Manager m 
    ON sm.senior_manager_code = m.senior_manager_code
LEFT JOIN Employee e 
    ON m.manager_code = e.manager_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;



