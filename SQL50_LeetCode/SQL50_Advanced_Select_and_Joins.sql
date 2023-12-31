-- 1731. The Number of Employees Which Report to Each Employee

SELECT   e2.employee_id, e2.name, COUNT(*) as reports_count, ROUND(AVG(e1.age)) as average_age
FROM Employees as e1
INNER JOIN Employees as e2
ON e1.reports_to= e2.employee_id
GROUP BY e1.reports_to
ORDER BY e2.employee_id;

-- 1789. Primary Department for Each Employee

SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y' OR (employee_id,1) IN
  (SELECT employee_id, COUNT(department_id)
  FROM Employee
  GROUP BY employee_id);

-- 610. Triangle Judgement

SELECT *, CASE WHEN x < y + z and y < x + z and z < y + x  THEN 'Yes' ELSE 'No' END as triangle
FROM Triangle;

-- 180. Consecutive Numbers

SELECT DISTINCT l1.num as ConsecutiveNums
FROM Logs as l1
INNER JOIN Logs as l2
ON l1.num = l2.num
INNER JOIN Logs as l3
on l2.num = l3.num
WHERE l1.id +1 = l2.id and l2.id +1 = l3.id;

-- 1164. Product Price at a Given Date

WITH set_prices AS (
    SELECT p.product_id, new_price as price
    FROM Products as p
    INNER JOIN
    (SELECT product_id, MAX(change_date) as change_date
    FROM Products
    WHERE change_date <= '2019-08-16'
    GROUP BY product_id) as t
    ON p.product_id = t.product_id AND p.change_date = t.change_date
)

SELECT p.product_id, CASE WHEN s.price is NULL THEN 10 ELSE s.price END as price
FROM Products as p
LEFT JOIN set_prices as s
ON p.product_id = s.product_id
GROUP BY p.product_id;

-- ACCUMULATED ACTION !!!!
-- 1204. Last Person to Fit in the Bus

SELECT q1.person_name
FROM Queue as q1 
INNER JOIN Queue as q2 
ON q1.turn >= q2.turn
GROUP BY q1.turn
HAVING SUM(q2.weight) <= 1000
ORDER BY SUM(q2.weight) DESC
LIMIT 1;

-- 1907. Count Salary Categories

SELECT 
    'Low Salary' as category,
    SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END) AS accounts_count
FROM 
    Accounts
    
UNION
SELECT  
    'Average Salary' category,
    SUM(CASE WHEN income >= 20000 AND income <= 50000 THEN 1 ELSE 0 END) as accounts_count
FROM 
    Accounts

UNION
SELECT 
    'High Salary' category,
    SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END) as accounts_count
FROM 
    Accounts;

