-- 1667. Fix Names in a Table

SELECT user_id, CONCAT(UPPER(LEFT(name,1)),LOWER(RIGHT(name, LENGTH(name)-1))) AS name
FROM Users
ORDER BY user_id;

-- 1527. Patients With a Condition

SELECT patient_id, patient_name, conditions
FROM Patients
Where conditions LIKE '% DIAB1%' OR
Conditions LIKE 'DIAB1%';

-- 196. Delete Duplicate Emails

DELETE p1
FROM Person as p1
INNER JOIN Person as p2
ON p1.email = p2.email
WHERE p1.id > p2.id;

-- 176. Second Highest Salary

SELECT MAX(salary) as SecondHighestSalary
FROM Employee 
WHERE salary != (SELECT MAX(salary) FROM Employee);

-- 1484. Group Sold Products By The Date

SELECT sell_date,COUNT(DISTINCT product) as num_sold,GROUP_CONCAT(DISTINCT product ORDER BY product ASC) AS products 
FROM Activities
GROUP BY sell_date;

-- 1327. List the Products Ordered in a Period

SELECT p.product_name, SUM(unit) as unit
FROM Products as p
INNER JOIN Orders as o 
ON p.product_id = o.product_id
WHERE MONTH(order_date) = '02' and YEAR(order_Date) = '2020'
GROUP BY p.product_id
HAVING SUM(unit) >= 100;

-- 1517. Find Users With Valid E-Mails

SELECT user_id, name, mail
FROM Users
WHERE mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*\\@leetcode\\.com$';
