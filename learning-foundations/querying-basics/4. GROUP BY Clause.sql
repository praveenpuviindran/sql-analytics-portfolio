# GROUP BY

SELECT *
FROM employee_demographics
;

SELECT gender
FROM employee_demographics
GROUP BY gender
;

SELECT first_name # this won't run because the gender needs to be in the select if it's in the group by UNLESS we're performing an aggregate function (ex. , AVG())
FROM employee_demographics
GROUP BY gender
;

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

# ORDER BY
SELECT *
FROM employee_demographics
ORDER BY first_name
;

SELECT *
FROM employee_demographics
ORDER BY gender, age DESC # the order of the order by matters - age before gender would disregard gender since no unique values
;

SELECT *
FROM employee_demographics
ORDER BY 5,4 # col 5 corresponds to gender, 4 corresponds to age - can call by column number rather than column name
;



