# HAVING vs WHERE

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40 # having is built for coming after GROUP BY and being able to filter based off of aggregate functions
;

SELECT occupation, AVG(salary)
FROM employee_salary
GROUP BY occupation
;

SELECT occupation, AVG(salary)
FROM employee_salary
WHERE occupation LIKE '%manager%' # filter at the row level - WHERE clause is used more, but if filtering on aggregate columns, have to use HAVING clause
GROUP BY occupation
HAVING AVG(salary) > 75000 # filter at the aggregate function level - this only works after the GROUP BY runs
;

