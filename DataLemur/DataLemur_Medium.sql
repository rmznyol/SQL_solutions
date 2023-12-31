-- User's Third Transaction [Uber SQL Interview Question] (Medium)
SELECT user_id, spend, transaction_date
FROM
  (SELECT *, RANK() OVER(PARTITION BY user_id ORDER BY transaction_date)
  FROM transactions) as t 
WHERE rank = 3

-- Sending vs. Opening Snaps [Snapchat SQL Interview Question] (Medium)

SELECT age_bucket,
ROUND((SUM(time_spent) FILTER (WHERE activity_type = 'send')) / SUM(time_spent) * 100.0, 2) as send_perc,
ROUND((SUM(time_spent) FILTER (WHERE activity_type = 'open')) / SUM(time_spent) * 100.0, 2) as open_perc

FROM activities as a 
INNER JOIN age_breakdown b 
ON a.user_id = b.user_id
WHERE a.activity_type != 'chat'
GROUP BY b.age_bucket;

-- Tweets' Rolling Averages [Twitter SQL Interview Question] (Medium)

SELECT t1.user_id, t1.tweet_date, ROUND(AVG(t2.tweet_count),2) as rolling_avg_3d
FROM tweets as t1
INNER JOIN tweets as t2
ON t1.user_id = t2.user_id AND
t1.tweet_date >= t2.tweet_date AND 
t2.tweet_date + INTERVAL '2 day' >= t1.tweet_date
GROUP BY t1.user_id, t1.tweet_date
ORDER BY t1.user_id, t1.tweet_date;

-- Highest-Grossing Items [Amazon SQL Interview Question] (Medium)

SELECT category, product, total_spend
FROM ( 
  SELECT category, product, SUM(spend) as total_spend, RANK() OVER(PARTITION BY category ORDER BY SUM(spend) DESC)
  FROM product_spend
  WHERE EXTRACT(YEAR FROM transaction_date) = 2022
  GROUP BY category, product
  ) as t
WHERE rank <= 2;

-- Top 5 Artists [Spotify SQL Interview Question] (Medium)

WITH CTE as (
  SELECT s.artist_id, DENSE_RANK() OVER(ORDER BY COUNT(g.song_id) DESC) as artist_rank
  FROM songs as s 
  INNER JOIN global_song_rank as g 
  ON s.song_id = g.song_id
  WHERE g.rank <= 10
  GROUP BY s.artist_id
)
SELECT artist_name, artist_rank
FROM artists as a 
INNER JOIN cte
ON a.artist_id = cte.artist_id
WHERE cte.artist_rank <= 5
ORDER BY cte.artist_rank;

-- Signup Activation Rate [TikTok SQL Interview Question] (Medium)

SELECT ROUND(COUNT(DISTINCT(e.email_id)) ::DECIMAL
/(SELECT COUNT(DISTINCT(email_id)) FROM emails),2) as confirm_rate
FROM emails as e
LEFT JOIN texts as t
ON e.email_id = t.email_id
WHERE t.signup_action = 'Confirmed';

-- Supercloud Customer [Microsoft SQL Interview Question] (Medium)

SELECT c.customer_id 
FROM customer_contracts as c
INNER JOIN products as p
ON c.product_id = p.product_id
GROUP BY c.customer_id
HAVING COUNT(DISTINCT(p.product_category)) = (
  SELECT COUNT(DISTINCT(product_category)) FROM products);

-- Odd and Even Measurements [Google SQL Interview Question] (Medium)

SELECT DATE(measurement_time) as measurement_day, 
SUM(CASE WHEN rank % 2 = 1 THEN measurement_value
ELSE 0 END) as odd_sum,
SUM(CASE WHEN rank % 2 = 0 THEN measurement_value
ELSE 0 END) as even_sum

FROM (
SELECT *, RANK() OVER(PARTITION BY DATE(measurement_time) ORDER BY measurement_time)
FROM measurements
) as t
GROUP BY DATE(measurement_time)
ORDER BY DATE(measurement_time);

-- Histogram of Users and Purchases [Walmart SQL Interview Question] (Medium)

SELECT transaction_date, user_id, COUNT(product_id) as purchase_count
FROM (
  SELECT transaction_date, user_id,product_id, 
  MAX(transaction_date) OVER(PARTITION BY user_id)
  FROM user_transactions
) as t
WHERE transaction_date = max
GROUP BY user_id, transaction_date
ORDER BY transaction_date;

-- Compressed Mode [Alibaba SQL Interview Question] (Medium)

SELECT item_count as mode 
FROM items_per_order
WHERE order_occurrences = (SELECT MAX(order_occurrences) 
FROM items_per_order)
ORDER BY item_count;

-- Card Launch Success [JPMorgan Chase SQL Interview Question] (Medium)

WITH cte as (
SELECT *, RANK() OVER(PARTITION BY card_name ORDER BY issue_year, issue_month) 
FROM monthly_cards_issued
)
SELECT card_name, issued_amount
FROM cte
WHERE rank = 1
ORDER BY issued_amount DESC;

-- International Call Percentage [Verizon SQL Interview Question] (Medium)

SELECT ROUND(COUNT(*)/
(SELECT COUNT(*) FROM phone_calls)::DECIMAL *100,1) as international_calls_pct
FROM phone_calls as c 
INNER JOIN phone_info as ic 
on c.caller_id = ic.caller_id
INNER JOIN phone_info as ir
ON c.receiver_id = ir.caller_id
WHERE ic.country_id != ir.country_id 
AND ic.caller_id != ir.caller_id;