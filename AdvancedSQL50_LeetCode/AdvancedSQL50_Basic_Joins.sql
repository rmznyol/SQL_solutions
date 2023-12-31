-- 175. Combine Two Tables

SELECT Person.firstName, Person.lastName, Address.city, Address.state FROM Person
LEFT JOIN Address
ON Person.personId = Address.personID;


-- 1607. Sellers With No Sales

WITH cte as (
  SELECT *
  FROM Orders
  WHERE YEAR(sale_date) = '2020'  
)
SELECT DISTINCT(seller_name)
FROM Seller as s
LEFT JOIN cte as o
ON s.seller_id = o.seller_id
WHERE o.seller_id is NULL
ORDER BY seller_name;


-- 1407. Top Travellers

SELECT u.name, SUM(IFNULL(r.distance, 0)) AS travelled_distance 
FROM Users u
LEFT JOIN Rides r
ON u.id = r.user_id
GROUP BY u.name, u.id
ORDER BY travelled_distance DESC, u.name ASC;


-- 607. Sales Person

SELECT name from SalesPerson 
WHERE name not IN (SELECT SalesPerson.name
FROM SalesPerson
  LEFT JOIN Orders
  ON Orders.sales_id = SalesPerson.sales_id
  LEFT JOIN Company
  ON Orders.com_id = Company.com_id
WHERE Company.name = 'REd');

-- 1440. Evaluate Boolean Expression

SELECT e.left_operand, e.operator, e.right_operand,
CASE operator 
  WHEN '<' THEN IF(v1.value < v2.value, 'true', 'false')
  WHEN '>' THEN IF(v1.value > v2.value, 'true', 'false')
  WHEN '=' THEN IF(v1.value = v2.value, 'true', 'false')
END as value
FROM Expressions as e
INNER JOIN Variables as v1
ON e.left_operand = v1.name
INNER JOIN Variables as v2
ON e.right_operand = v2.name;

-- 1212. Team Scores in Football Tournament

SELECT team_id, team_name, SUM(CASE
WHEN host_goals > guest_goals AND host_team = team_id THEN 3 
WHEN host_goals < guest_goals AND guest_team = team_id THEN 3 
WHEN host_goals = guest_goals THEN 1
ELSE 0
END) as num_points
FROM Teams as t
LEFT JOIN Matches as m
ON t.team_id = m.host_team or t.team_id = m.guest_team
GROUP BY team_id, team_name
ORDER BY num_points DESC, team_id;
