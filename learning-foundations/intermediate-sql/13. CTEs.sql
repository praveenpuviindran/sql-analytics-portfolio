# Common Table Expressions (CTEs) - they allow you to define a subquery block that you can then reference within the main query

SELECT gender, AVG(salary), MAX(salary), MIN(salary), COUNT(salary)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender
;

WITH CTE_Example AS # name the CTE - you can only use the CTE immediately afer you create it
(
SELECT gender, AVG(salary) AS avg_sal, MAX(salary) AS max_sal, MIN(salary) AS min_sal, COUNT(salary) AS count_sal
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender # this builds a table within the subquery, and we can query it down below as CTE_Example
)
SELECT AVG(avg_sal) # average salary between the males and the females
FROM CTE_Example
;

SELECT AVG(avg_sal)
FROM CTE_Example # only used for queries, not being saved - which is why you can only write it immediately after creating it
; # this outputs an error since you're not creating a permanent object (like a temp table), you're creating a CTE, so it's not stored like employee_dem/sal or parks_dep

--
# you can create multiple CTEs within just one
WITH CTE_Example AS
(
SELECT employee_id, gender, birth_date
FROM employee_demographics AS dem
WHERE birth_date > '1985-01-01'
),
CTE_Example2 AS
(
SELECT employee_id, salary
FROM employee_salary
WHERE salary > 50000
)
SELECT *
FROM CTE_Example
JOIN CTE_Example2
	ON CTE_Example.employee_id = CTE_Example2.employee_id
;






