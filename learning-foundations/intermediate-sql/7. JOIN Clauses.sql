 # JOINS # joining two or more tables together by common columns (don't need same column names, but data needs to be same
 
 SELECT *
 FROM employee_demographics
 ;
 
 SELECT *
 FROM employee_salary
 ;
 
 # INNER JOIN returns rows that are the same in both columns from both tables
 
SELECT *
FROM employee_demographics
INNER JOIN employee_salary # by default JOIN represents an inner join, but can write INNER JOIN
	ON employee_demographics.employee_id = employee_salary.employee_id # demographics table column name = salary table column name
;

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id # uses aliases for shorthand
;

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

# OUTER JOINS - LEFT OUTER and RIGHT OUTER; LEFT OUTER takes everything from the left table and only returns the matches from the right table, opposite for RIGHT OUTER
SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
LEFT OUTER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, age, occupation
FROM employee_demographics AS dem
RIGHT OUTER JOIN employee_salary AS sal # takes everything from sal, but returns null for row 2 since no dem data for ron swanson
	ON dem.employee_id = sal.employee_id
;

# SELF JOIN - a join where you tie the table to itself
SELECT 
emp1.employee_id AS emp_santa, 
emp1.first_name AS first_name_santa,
emp1.last_name AS last_name_santa,
emp2.employee_id AS emp_name, 
emp2.first_name AS first_name_emp,
emp2.last_name AS last_name_emp
FROM employee_salary AS emp1
JOIN employee_salary AS emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

# joining multiple tables together

SELECT *
FROM parks_departments # a reference table that has department names - doesn't usually change much
;

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON sal.dept_id = pd.department_id
;
