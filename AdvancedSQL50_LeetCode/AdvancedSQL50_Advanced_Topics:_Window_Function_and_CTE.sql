-- 1077. Project Employees III

SELECT project_id, employee_id
FROM (
    SELECT p.project_id, e.employee_id,
    RANK() OVER(PARTITION BY p.project_id ORDER BY e.experience_years DESC) as rnk
    FROM Project as p
    INNER JOIN Employee as e 
    ON e.employee_id = p.employee_id
) as t
WHERE rnk = 1

-- 1285. Find the Start and End Number of Continuous Ranges

 WITH cte as (
  SELECT *, ROW_NUMBER() OVER( ORDER BY log_id) as rnk
  FROM logs
 )
 SELECT MIN(log_id) as start_id, MAX(log_id) as end_id
 FROM cte
 GROUP BY log_id - rnk


-- 1596. The Most Frequently Ordered Products for Each Customer

WITH cte1 as (
  SELECT o.customer_id, o.product_id, p.product_name,
  COUNT(*) OVER(PARTITION BY o.customer_id, product_id) as cnt
  FROM Orders as o
  INNER JOIN Products as p
  ON o.product_id = p.product_id
),
cte2 as (
  SELECT customer_id, product_id, product_name, cnt,
  MAX(cnt) OVER(PARTITION BY customer_id) as mx
  FROM cte1
)
SELECT customer_id, product_id, product_name
FROM cte2
WHERE cnt = mx
GROUP BY customer_id, product_id, product_name

-- 1709. Biggest Window Between Visits

WITH cte AS (
  SELECT v1.user_id, v1.visit_date as initial,
      DATEDIFF(MIN(IFNULL(v2.visit_date,'2021-1-1')), v1.visit_date) as diff
  FROM UserVisits as v1
  LEFT JOIN UserVisits as v2
  ON v1.user_id = v2.user_id and v2.visit_date > v1.visit_date
  GROUP BY user_id, initial 
)
SELECT user_id, MAX(diff) as biggest_window
FROM cte
GROUP BY user_id

-- 1270. All People Report to the Given Manager

WITH cte as (
  SELECT * 
  FROM Employees
  WHERE manager_id != employee_id
)
SELECT e1.employee_id
FROM cte as e1
LEFT JOIN cte as e2
ON e1.manager_id = e2.employee_id
LEFT JOIN cte as e3
ON e2.manager_id = e3.employee_id
WHERE (e1.manager_id = 1) or (e2.manager_id = 1) or (e3.manager_id = 1) 

-- 1412. Find the Quiet Students in All Exams

WITH cte AS(
    SELECT student_id,
    CASE WHEN score = MIN(score) OVER (PARTITION BY exam_id) THEN 1
    WHEN score = MAX(score) OVER (PARTITION BY exam_id) THEN 1
    ELSE 0 
    END as flag
    FROM Exam
)
SELECT student_id, student_name
FROM Student
WHERE student_id IN (SELECT student_id FROM cte WHERE flag = 0) 
AND student_id NOT IN (SELECT student_id FROM cte WHERE flag = 1)

-- RECURSION !!!
-- 1767. Find the Subtasks That Did Not Execute

WITH RECURSIVE cte as (
  SELECT task_id, subtasks_count as subtask_id
  FROM Tasks 
  UNION ALL
  SELECT task_id, subtask_id - 1
  FROM cte
  WHERE subtask_id > 1
)
SELECT *
FROM cte
WHERE (task_id, subtask_id) NOT IN (
  SELECT * FROM Executed as e WHERE e.task_id = cte.task_id)
-- val1-val2 gives errors with 0 
-- 1225. Report Contiguous Dates

WITH f as (
  SELECT *, (1 + ROW_NUMBER() OVER( ORDER BY fail_date)) as rnk
  FROM Failed
  WHERE  fail_date >= '2019-01-01' AND fail_date <= '2019-12-31'
),
s as (
  SELECT *, (1 + ROW_NUMBER() OVER( ORDER BY success_date)) as rnk
  FROM Succeeded
  WHERE  success_date >= '2019-01-01' AND success_date <= '2019-12-31'
)
SELECT 'failed' as period_state, MIN(fail_date) as start_date, MAX(fail_date) as end_date
FROM f
GROUP BY DATEDIFF(fail_date,'2018-12-30') - rnk
UNION
SELECT 'succeeded' as period_state, MIN(success_date) as start_date, MAX(success_date) as end_date
FROM s
GROUP BY DATEDIFF(success_date,'2018-12-30') - rnk
ORDER BY start_date	
