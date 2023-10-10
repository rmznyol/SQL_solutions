-- Revising Aggregations - The Count Function
SELECT COUNT(NAME)
FROM CITY
WHERE POPULATION > 100000;

-- Revising Aggregations - The Sum Function
SELECT SUM(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

-- Averages
SELECT AVG(POPULATION)
FROM CITY
WHERE DISTRICT = 'California';

-- Average Population
SELECT ROUND(AVG(POPULATION))
FROM CITY;

-- Japan Population
SELECT SUM(POPULATION)
FROM CITY
WHERE COUNTRYCODE = 'JPN';

-- Population Density Difference
SELECT MAX(POPULATION) - MIN(POPULATION)
FROM CITY;

-- The Blunder
SELECT CEIL(AVG(SALARY - CAST(REPLACE(CAST(SALARY AS CHAR(50)),'0', '') AS UNSIGNED)))
FROM EMPLOYEES;

-- Top Earners
SELECT MAX(salary*months), COUNT(*)
FROM employee
WHERE salary*months = (
SELECT MAX(salary*months)
From employee);

-- Weather Observation Station 13

SELECT ROUND(SUM(LAT_N),4)
FROM STATION
WHERE 38.7880 < LAT_N AND LAT_N < 137.2345;

-- Weather Observation Station 14
SELECT ROUND(MAX(LAT_N),4)
FROM STATION
WHERE LAT_N < 137.2345;

-- Weather Observation Station 15
SELECT ROUND(LONG_W,4)
FROM STATION
WHERE LAT_N = (SELECT MAX(LAT_N) FROM STATION WHERE LAT_N < 137.2345);

-- Weather Observation Station 16
SELECT ROUND(MIN(LAT_N),4)
FROM STATION 
WHERE LAT_N > 38.7780;