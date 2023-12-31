-- 1501. Countries You Can Safely Invest In

SELECT u.name as NAME, SUM(t.amount) AS BALANCE
FROM Users as u
LEFT JOIN Transactions AS t
ON u.account = t.account
GROUP BY u.account
HAVING BALANCE > 10000;

-- 182. Duplicate Emails

SELECT DISTINCT p1.email
FROM Person as p1
INNER JOIN Person as p2 ON p1.email = p2.email
WHERE p1.id > p2.id;
-- 1050. Actors and Directors Who Cooperated At Least Three Times

SELECT actor_id, director_id
FROM ActorDirector
GROUP BY actor_id, director_id
HAVING COUNT(*) > 2;
--  Pay attention to use of 'IF'
-- 1511. Customer Order Frequency

SELECT c.customer_id, c.name
FROM Customers as c
INNER JOIN Orders as o
ON c.customer_id = o.customer_id
INNER JOIN Product as p
ON o.product_id = p.product_id
GROUP BY c.customer_id
HAVING SUM(IF(YEAR(o.order_date) = '2020' and MONTH(o.order_date) = '06', p.price * o.quantity,0)) >= 100
    AND SUM(IF(YEAR(o.order_date) = '2020' and MONTH(o.order_date) = '07', p.price * o.quantity,0)) >= 100;
-- 1693. Daily Leads and Partners

ELECT date_id, make_name, COUNT(DISTINCT lead_id) as unique_leads,
    COUNT(DISTINCT partner_id) as unique_partners
FROM DailySales
GROUP BY date_id, make_name;

-- 1495. Friendly Movies Streamed Last Month

SELECT DISTINCT c.title
FROM Content as c
JOIN TVProgram as t
ON c.content_id = t.content_id
WHERE c.Kids_content = 'Y' AND c.content_type = 'Movies'AND MONTH(t.program_date) = 6 AND YEAR(t.program_date) = 2020;

-- 1501. Countries You Can Safely Invest In

WITH cte as (
    SELECT p.id, c.name as country
    FROM Person as p 
    INNER JOIN Country as c
    on LEFT(p.phone_number,3) = c.country_code
)
SELECT country
FROM cte
LEFT JOIN Calls
ON Calls.caller_id = cte.id or Calls.callee_id = cte.id
GROUP BY country
HAVING avg(duration) > (SELECT (AVG(duration)) FROM Calls);
