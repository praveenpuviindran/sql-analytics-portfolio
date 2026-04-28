# UNIONS - allows you to combine rows together - combines the rows of data from separate/same tables

SELECT first_name, last_name
FROM employee_demographics
UNION DISTINCT # only takes unique values with DISTINCT - removes all duplicates
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name
FROM employee_demographics
UNION ALL # keeps duplicates and shows all results from both tables
SELECT first_name, last_name
FROM employee_salary
;

SELECT first_name, last_name, 'Old Man' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Male'
UNION
SELECT first_name, last_name, 'Old Lady' AS Label
FROM employee_demographics
WHERE age > 40 AND gender = 'Female'
UNION
SELECT first_name, last_name, 'Highly Paid Employee' AS Label
FROM employee_salary
WHERE salary > 70000
ORDER BY first_name, last_name
;


