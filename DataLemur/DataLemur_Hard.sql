-- Active User Retention [Facebook SQL Interview Question] (Hard)

SELECT 7 as month, COUNT(DISTINCT(u1.user_id))
FROM user_actions as u1
INNER JOIN user_actions as u2
ON u1.user_id = u2.user_id
WHERE EXTRACT(YEAR FROM u1.event_date) = 2022 AND
EXTRACT(YEAR FROM u2.event_date) = 2022 AND
EXTRACT(MONTH FROM u1.event_date) = 6 AND
EXTRACT(MONTH FROM u2.event_date) = 7;

-- Y-on-Y Growth Rate [Wayfair SQL Interview Question] (Hard)

WITH cte AS (
  SELECT product_id, SUM(spend) as year_spend, EXTRACT(YEAR FROM transaction_date) as year
  FROM user_transactions 
  GROUP BY  product_id, EXTRACT(YEAR FROM transaction_date))

SELECT c1.year, c1.product_id,c1.year_spend as curr_year_spend, c2.year_spend as prev_year_spend,
ROUND((c1.year_spend - c2.year_spend)/c2.year_spend * 100,2) as yoy_rate
FROM cte as c1
LEFT JOIN cte as c2
ON c1.product_id = c2.product_id AND c1.year -1 = c2.year
ORDER BY c1.product_id, c1.year

-- Median Google Search Frequency [Google SQL Interview Question] (Hard)

WITH cte AS (
  SELECT c1.searches, SUM(c2.num_users) as acc
  FROM search_frequency as c1
  INNER JOIN search_frequency as c2
  ON c1.searches >= c2.searches
  GROUP BY c1.searches
)

SELECT ROUND(AVG(searches),1)
FROM cte
WHERE acc >= (SELECT SUM(num_users) / 2 FROM search_frequency)
AND acc <= (SELECT SUM(num_users) / 2 + 1 FROM search_frequency)

-- Advertiser Status [Facebook SQL Interview Question] (Hard)

SELECT CASE 
  WHEN a.user_id is null THEN d.user_id
  ELSE a.user_id
  END
  AS user_id
, CASE
  WHEN paid is null THEN 'CHURN'
  WHEN a.status is null THEN 'NEW'
  WHEN status = 'CHURN' THEN 'RESURRECT'
  ELSE 'EXISTING'
  END
  AS new_status
FROM advertiser as a 
FULL OUTER JOIN daily_pay as d
ON a.user_id = d.user_id
ORDER BY user_id;

-- 3-Topping Pizzas [McKinsey SQL Interview Question] (Hard) 

SELECT CONCAT(t1.topping_name,',',t2.topping_name,',', t3.topping_name) as pizza,
t1.ingredient_cost + t2.ingredient_cost + t3.ingredient_cost as total_cost 
FROM pizza_toppings as t1
CROSS JOIN pizza_toppings as t2
CROSS JOIN pizza_toppings as t3
WHERE t1.topping_name < t2.topping_name 
AND t1.topping_name < t3.topping_name
AND t2.topping_name < t3.topping_name
ORDER BY total_cost DESC, t1.topping_name, t2.topping_name, t3.topping_name;

-- Repeated Payments [Stripe SQL Interview Question] (Hard)

SELECT COUNT(*) as payment_count 
FROM transactions as t1
INNER JOIN transactions as t2
ON t1.merchant_id = t2.merchant_id AND t1.credit_card_id = t2.credit_card_id AND t1.amount = t2.amount
AND t1.transaction_timestamp > t2.transaction_timestamp
AND t2.transaction_timestamp + INTERVAL '10 minute' >= t1.transaction_timestamp;