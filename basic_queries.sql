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

-- ===============================
-- WEATHER OBSERVATION STATION 2
-- ===============================
-- Problem: Sum of LAT_N and LONG_W rounded to 2 decimal places

SELECT 
    ROUND(SUM(LAT_N), 2) AS total_lat,
    ROUND(SUM(LONG_W), 2) AS total_long
FROM STATION;



-- ===============================
-- WEATHER OBSERVATION STATION 13
-- ===============================
-- Problem: Sum of LAT_N between given range, truncated to 4 decimal places

SELECT 
    TRUNCATE(SUM(LAT_N), 4) AS total_lat
FROM STATION
WHERE LAT_N > 38.7880 
  AND LAT_N < 137.2345;

-- Weather Observation Station 14
-- Find max LAT_N < 137.2345 (truncate to 4 decimals)

SELECT TRUNCATE(MAX(LAT_N), 4)
FROM STATION
WHERE LAT_N < 137.2345;


-- Weather Observation Station 15
-- Get LONG_W for largest LAT_N < 137.2345

SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (
    SELECT MAX(LAT_N)
    FROM STATION
    WHERE LAT_N < 137.2345
);


-- Weather Observation Station 16
-- Find smallest LAT_N greater than 38.7780 (rounded to 4 decimal places)

SELECT ROUND(MIN(LAT_N), 4)
FROM STATION
WHERE LAT_N > 38.7780;


-- Weather Observation Station 17
-- Query the Western Longitude (LONG_W) for the largest Northern Latitude (LAT_N)
-- in STATION that is greater than 38.7780. Round your answer to 4 decimal places.

SELECT ROUND(LONG_W, 4)
FROM STATION
WHERE LAT_N = (
    SELECT MIN(LAT_N)
    FROM STATION
    WHERE LAT_N > 38.7780
);


-- Weather Station 18
SELECT 
ROUND(
    ABS(MIN(LAT_N) - MAX(LAT_N)) + 
    ABS(MIN(LONG_W) - MAX(LONG_W))
, 4)
FROM STATION;


-- Weather Observation Station 19
SELECT 
ROUND(
    SQRT(
        POWER(MAX(LAT_N) - MIN(LAT_N), 2) +
        POWER(MAX(LONG_W) - MIN(LONG_W), 2)
    ), 
4)
FROM STATION;


-- Weather Observation Station 20 (Median)
SELECT ROUND(LAT_N, 4)
FROM (
    SELECT LAT_N,
           ROW_NUMBER() OVER (ORDER BY LAT_N) AS rn,
           COUNT(*) OVER () AS total
    FROM STATION
) AS t
WHERE rn = CEIL(total / 2);



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




