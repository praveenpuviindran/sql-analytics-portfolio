# WHERE CLAUSE LESSON - used to help filter records/rows of data - only return rows that fulfill. a specific condition

SELECT * # used to select actual columns
FROM Parks_and_Recreation.employee_salary
WHERE first_name = "Leslie" # = is called a comparison operator
;

SELECT *
FROM employee_salary
WHERE salary <= 50000
;

SELECT *
FROM employee_demographics
WHERE gender != "Female"
;

# note for self: operators are same as python (<, >, =, !=)

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;
# Logical operators - and or not
SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
AND gender = 'Male'
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR gender = 'Male'
;

SELECT *
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'Male'
;

SELECT *
FROM employee_demographics
WHERE (first_name = 'Leslie' AND age = 44) OR age > 55
;

# LIKE statement - can look for patterns, not necessarily exact matches: % = anything, _ = specific value
SELECT *
FROM employee_demographics
WHERE first_name LIKE 'a___%'
;

SELECT *
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;