-- 620. Not Boring Movies

SELECT *
FROM Cinema
WHERE id % 2 = 1 and description != 'boring' 
ORDER BY rating DESC;

-- 1251. Average Selling Price

SELECT u.product_id, ROUND(SUM(units * price) / SUM(units),2) as average_price
FROM UnitsSold as u
LEFT JOIN Prices as p
ON u.product_id = p.product_id AND u.purchase_date BETWEEN p.Start_date and p.end_date
GROUP BY u.product_id;

-- 1075. Project Employees I

SELECT project_id, ROUND(AVG(experience_years),2) as average_years
FROM Project as p
LEFT JOIN Employee as e
ON p.employee_id = e.employee_id
GROUP BY project_id;

-- 1633. Percentage of Users Attended a Contest

SELECT contest_id, ROUND(100 * COUNT(DISTINCT(user_id)) / (SELECT COUNT(DISTINCT(user_id)) FROM Users),2) as percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;

-- 1211. Queries Quality and Percentage

SELECT query_name,
  ROUND(AVG(rating/position),2) as quality, 
  ROUND(100*COUNT(CASE WHEN rating < 3 THEN rating ELSE NULL END) / COUNT(*),2) as poor_query_percentage
FROM Queries
GROUP BY query_name;

-- 1193. Monthly Transactions I

SELECT DATE_FORMAT(trans_date, '%Y-%m') as month, country, 
  COUNT(trans_date) as trans_count,
  COUNT(CASE state WHEN 'approved' THEN 1 ELSE NULL END) as approved_count,
  SUM(amount) as trans_total_amount,
  SUM(CASE state WHEN 'approved' THEN amount ELSE 0 END) as approved_total_amount
FROM Transactions
GROUP BY DATE_FORMAT(trans_date, '%Y-%m'), country;

-- 1174. Immediate Food Delivery II

SELECT ROUND(AVG(immediate)*100,2) as immediate_percentage
FROM
(SELECT MIN(order_date) = MIN(customer_pref_delivery_date) as immediate
FROM Delivery
GROUP BY customer_id) as t;

-- 550. Game Play Analysis IV

SELECT IFNULL(ROUND(SUM(1/(SELECT COUNT(DISTINCT(player_id)) FROM Activity )),2),0) as fraction
FROM Activity 
WHERE (player_id, DATE_ADD(event_date, INTERVAL -1 DAY)) IN (
    SELECT player_id, MIN(event_date) 
    FROM Activity
    GROUP BY player_id);
