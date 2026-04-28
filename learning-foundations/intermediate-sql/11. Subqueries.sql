# Subqueries - a query within another query: can be done in WHERE clause, and SELECT/FROM clauses

SELECT *
FROM employee_demographics
;

SELECT *
FROM employee_salary
;

SELECT *
FROM employee_demographics
WHERE employee_id IN 
				(SELECT employee_id
					FROM employee_salary
					WHERE dept_id = 1)
;

SELECT first_name, salary, 
					(SELECT AVG(salary)
						FROM employee_salary)
FROM employee_salary
GROUP BY first_name, salary
;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics  
GROUP BY gender
;

SELECT AVG(max_age) # backtick is used to call specific column names, but can give columns aliases for simplicity
FROM
	(SELECT gender, 
    AVG(age) AS avg_age, 
    MAX(age) AS max_age, 
    MIN(age) AS min_age, 
    COUNT(age) AS count_age
	FROM employee_demographics  
	GROUP BY gender) AS Agg_table # now can perform aggregations on this table
;



