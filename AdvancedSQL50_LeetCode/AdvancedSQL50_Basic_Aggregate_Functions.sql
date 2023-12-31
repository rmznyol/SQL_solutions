-- 1890. The Latest Login in 2020

SELECT user_id, MAX(time_stamp) as last_stamp
FROM Logins WHERE YEAR(time_stamp)<2021 and YEAR(time_stamp)>2019
GROUP BY user_id


-- 511. Game Play Analysis I

SELECT player_id, MIN(event_date) as first_login FROM Activity
GROUP BY player_id;

-- 1571. Warehouse Manager

SELECT name as warehouse_name, SUM(Width*Length*Height*units) as volume
FROM Warehouse as w
LEFT JOIN products as p
ON w.product_id = p.product_id
GROUP BY name;

-- 586. Customer Placing the Largest Number of Orders

SELECT customer_number 
FROM Orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC
LIMIT 1;

-- 1741. Find Total Time Spent by Each Employee

SELECT event_day as day, emp_id, SUM(out_time - in_time ) as total_time
FROM Employees
GROUP BY event_day, emp_id;

-- 1173. Immediate Food Delivery I

SELECT ROUND(AVG(IF(order_date = customer_pref_delivery_date,1,0))*100,2) as immediate_percentage
FROM Delivery;

-- 1445. Apples & Oranges

SELECT sale_date, SUM(IF(fruit='apples',sold_num,0)-IF(fruit='oranges',sold_num,0)) as diff
FROM Sales
GROUP BY sale_date
ORDER BY sale_date;

-- VERY IMPORTANT!
-- 1699. Number of Calls Between Two Persons

SELECT LEAST(from_id,to_id) as person1,
GREATEST(from_id,to_id) as person2,
COUNT(*) as call_count,
SUM(duration) as total_duration
FROM Calls
GROUP BY person1,person2;
