-- 603. Consecutive Available Seats

SELECT c1.seat_id
FROM Cinema as c1
LEFT JOIN Cinema as c2
ON c1.seat_id + 1 = c2.seat_id
LEFT JOIN Cinema as c3
ON c1.seat_id - 1 = c3.seat_id
WHERE (c1.free = 1 and c2.free = 1)  or (c3.free = 1 and c1.free = 1)

-- 1795. Rearrange Products Table

SELECT product_id, 'store1' AS store, store1 AS price 
FROM Products 
WHERE store1 IS NOT NULL
UNION
SELECT product_id, 'store2' AS store, store2 AS price 
FROM Products 
WHERE store2 IS NOT NULL
UNION
SELECT product_id, 'store3' AS store, store3 AS price 
FROM Products 
WHERE store3 IS NOT NULL

-- 613. Shortest Distance in a Line

SELECT MIN(p1.x - p2.x) as shortest 
FROM Point as p1
INNER JOIN Point as p2
ON p1.x > p2.x

-- 1965. Employees With Missing Information

SELECT e.employee_id FROM Employees AS e
LEFT JOIN Salaries AS s ON e.employee_id = s.employee_id
Where s.employee_id IS NULL 

UNION 

SELECT s.employee_id FROM Employees AS e
RIGHT JOIN Salaries AS s ON e.employee_id = s.employee_id
WHERE e.employee_id IS NULL 

ORDER BY employee_id

--1264. Page Recommendations

WITH cte AS (SELECT GREATEST(user1_id, user2_id) as user_id
 FROM Friendship
 WHERE user1_id = 1 or user2_id = 1 
 )

SELECT DISTINCT(page_id) as recommended_page
FROM Likes as l
INNER JOIN cte
on cte.user_id = l.user_id
WHERE l.page_id NOT IN (SELECT page_id FROM Likes WHERE user_id = 1)

-- 608. Tree Node

SELECT DISTINCT(id), 
CASE 
    WHEN p_id is NULL THEN 'Root'
    WHEN parental is NULL THEN 'Leaf'
    ELSE 'Inner' 
END AS type    
FROM (SELECT t1.id as id ,t1.p_id as p_id, t2.p_id as parental FROM Tree as t1
LEFT JOIN Tree as t2 
ON t1.id = t2.p_id) AS t


-- 534. Game Play Analysis III

SELECT a1.player_id, a1.event_date, SUM(a2.games_played) as games_played_so_far
FROM Activity as a1
INNER JOIN Activity as a2
ON a1.player_id = a2.player_id and a1.event_date >= a2.event_date
GROUP BY a1.player_id, a1.event_date

-- (IMPORTANT SOLUTION)
-- 1783. Grand Slam Titles

SELECT player_id,player_name,
SUM(player_id=Wimbledon)+SUM(player_id=Fr_open)+SUM(player_id=US_open)+SUM(player_id=Au_open)
as grand_slams_count
FROM Players
JOIN Championships
ON player_id=Wimbledon or player_id=Fr_open or player_id=US_open or player_id=Au_open
GROUP BY player_id

-- 1747. Leetflex Banned Accounts

SELECT DISTINCT(l1.account_id)
FROM LogInfo as l1
INNER JOIN Loginfo as l2
ON l1.account_id = l2.account_id and l1.ip_address != l2.ip_address and l1.login <= l2.login and l1.logout >= l2.login
