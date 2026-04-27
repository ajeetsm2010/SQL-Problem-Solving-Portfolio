-- ============================================
-- BASIC SQL QUERIES (FOUNDATION)
-- Objective: Practice data retrieval and filtering
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
