-- 2356. Number of Unique Subjects Taught by Each Teacher
SELECT teacher_id, COUNT(DISTINCT(subject_id)) as cnt
FROM Teacher
GROUP BY teacher_id

-- User Activity for the Past 30 Days I

SELECT activity_date as day, COUNT(DISTINCT user_id) as active_users
FROM Activity
WHERE '2019-06-27' < activity_date and activity_date < '2019-07-27'
GROUP BY activity_date;

-- (ROW CONSRUCTOR AND SUBQUERY EX, ALSO SHOWS WHY NOT TO USE CORRELATED SUBQUERY)
-- 1070. Product Sales Analysis III

SELECT s.product_id, year as first_year, quantity, price
FROM Sales as s
WHERE (product_id,year) IN (SELECT product_id, MIN(year) FROM Sales GROUP BY product_id); 

-- 596. Classes More Than 5 Students
SELECT class 
FROM Courses
GROUP BY class
HAVING COUNT(student) > 4;

-- 1729. Find Followers Count

SELECT user_id, COUNT(DISTINCT follower_id) as followers_count
FROM Followers
GROUP BY user_id;

-- 619. Biggest Single Number

SELECT MAX(num) as num
FROM (SELECT *
FROM MyNumbers
GROUP BY num
HAVING COUNT(num) = 1) as t;

-- 1045. Customers Who Bought All Products

SELECT c.customer_id
FROM Customer as c
GROUP BY c.customer_id
HAVING COUNT(DISTINCT(product_key)) = (SELECT COUNT(*) FROM PRODUCT);
