-- ============================================
-- BASIC SQL QUERIES (FOUNDATION)
-- ============================================

-- ============================================
-- Section 1: Practice data retrieval and filtering
-- ============================================

-- 1. Retrieve all records from CITY table
SELECT *
FROM CITY;


-- 2. Filter cities with population greater than 100,000
-- Use case: Identify high population cities
SELECT *
FROM CITY
WHERE POPULATION > 100000;


-- 3. Retrieve all cities from USA
-- Use case: Country-specific filtering
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'USA';


-- 4. Retrieve cities from USA with population > 100,000
-- Use case: Target major urban markets
SELECT *
FROM CITY
WHERE COUNTRYCODE = 'USA'
AND POPULATION > 100000;


-- 5. Select specific columns (Name & Population)
-- Use case: Focused data extraction
SELECT NAME, POPULATION
FROM CITY;


-- 6. Sort cities by population (highest first)
-- Use case: Identify top populated cities
SELECT NAME, POPULATION
FROM CITY
ORDER BY POPULATION DESC;


-- 7. Retrieve all cities from Japan
-- Use case: Country-specific data extraction (Japan market analysis)

SELECT *
FROM CITY
WHERE COUNTRYCODE = 'JPN';


-- 8. Find cities in Japan with high population (> 200,000)
-- Use case: Identify major urban areas in Japan

SELECT NAME, POPULATION
FROM CITY
WHERE COUNTRYCODE = 'JPN'
AND POPULATION > 200000;



-- ============================================
-- Section 2: WEATHER OBSERVATION STATION QUERIES
-- ============================================

-- 9. Retrieve CITY and STATE from STATION table
-- Objective: Basic column selection

SELECT CITY, STATE
FROM STATION;


-- 10: Get CITY names with even ID numbers (no duplicates)
-- Concept: DISTINCT + MOD function (filtering even numbers)

SELECT DISTINCT CITY
FROM STATION
WHERE MOD(ID, 2) = 0;


-- ============================================
-- Section 3: AGGREGATION QUERIES
-- ============================================

-- 11: Find difference between total CITY entries and distinct CITY entries
-- Concept: COUNT vs COUNT(DISTINCT)
-- Use case: Identifying duplicate records in dataset

SELECT COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION;
-- Explanation:
-- COUNT(CITY) counts all rows
-- COUNT(DISTINCT CITY) removes duplicates
-- Difference gives number of duplicate entries


-- ============================================
-- Section 4: STRING & SORTING QUERIES
-- ============================================

-- 12: Find city with shortest and longest name
-- Concept: LENGTH + ORDER BY + tie-breaking (alphabetical)

-- Shortest city name
SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY), CITY
FETCH FIRST 1 ROW ONLY;

-- Longest city name
SELECT CITY, LENGTH(CITY)
FROM STATION
ORDER BY LENGTH(CITY) DESC, CITY
FETCH FIRST 1 ROW ONLY;

-- Explanation:
-- LENGTH(CITY) calculates string size
-- ORDER BY handles sorting
-- CITY ensures alphabetical tie-breaking

-- ============================================
-- Section 5: STRING FILTERING (VOWELS)
-- ============================================

-- 13: Get cities starting with vowels
-- Concept: LIKE / SUBSTR + DISTINCT

SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(CITY) LIKE 'A%'
   OR UPPER(CITY) LIKE 'E%'
   OR UPPER(CITY) LIKE 'I%'
   OR UPPER(CITY) LIKE 'O%'
   OR UPPER(CITY) LIKE 'U%';

-- Alternative (better approach)
SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(SUBSTR(CITY,1,1)) IN ('A','E','I','O','U');

-- Explanation:
-- LIKE 'A%' checks starting character
-- SUBSTR extracts first letter
-- DISTINCT removes duplicates

-- 14: Get cities ending with vowels
-- Concept: LIKE '%A' OR SUBSTR for last character

SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(CITY) LIKE '%A'
   OR UPPER(CITY) LIKE '%E'
   OR UPPER(CITY) LIKE '%I'
   OR UPPER(CITY) LIKE '%O'
   OR UPPER(CITY) LIKE '%U';

-- Alternative (better)
SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(SUBSTR(CITY, -1)) IN ('A','E','I','O','U');

-- Explanation:
-- %A checks ending character
-- SUBSTR(CITY, -1) extracts last letter

-- 15: Cities starting AND ending with vowels

SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(SUBSTR(CITY, 1, 1)) IN ('A','E','I','O','U')
AND UPPER(SUBSTR(CITY, -1)) IN ('A','E','I','O','U');

-- Explanation:
-- First condition → starts with vowel
-- Second condition → ends with vowel

-- Problem4: Cities that do NOT start with vowels

SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(SUBSTR(CITY, 1, 1)) NOT IN ('A','E','I','O','U');

-- Explanation:
-- Extract first letter and exclude vowels using NOT IN

-- 16. Cities that do NOT start OR do NOT end with vowels
SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(SUBSTR(CITY,1,1)) NOT IN ('A','E','I','O','U')
OR UPPER(SUBSTR(CITY,-1)) NOT IN ('A','E','I','O','U');

-- 17. Cities that do NOT start AND do NOT end with vowels
SELECT DISTINCT CITY
FROM STATION
WHERE UPPER(SUBSTR(CITY,1,1)) NOT IN ('A','E','I','O','U')
AND UPPER(SUBSTR(CITY,-1)) NOT IN ('A','E','I','O','U');


-- ============================================
-- SECTION 6: Sorting & Logic-based Queries
-- ============================================

-- 18. Students scoring above 75 (Sorting by last 3 characters + ID)
SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME,3), ID;

-- 19. Employee names in alphabetical order
SELECT NAME
FROM EMPLOYEE
ORDER BY NAME;

-- 20. Employees with salary > 2000 and experience < 10 months
SELECT NAME
FROM EMPLOYEE
WHERE SALARY > 2000
AND MONTHS < 10
ORDER BY EMPLOYEE_ID;




