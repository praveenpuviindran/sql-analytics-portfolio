# CASE statements - allows you to add logic like if/else statements in your statements

SELECT *
FROM employee_demographics
;

SELECT first_name, last_name, age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 and 50 THEN 'Old'
    WHEN age >= 50 THEN "On Death's Door"
END AS Age_Bracket
FROM employee_demographics
;

# The Pawnee Council sent out a memo of their bonus and pay increase for end of year, and we need to follow it and 
# determine people's end of year salary or the salary going into the new year and if they got a bonus how much is it. 
-- Pay increase and bonus: 
-- <50000 = 5% raise
-- >50000 = 7% raise
-- Finance = 10% bonus

SELECT first_name, last_name, salary, dept_id,
CASE
	WHEN salary < 50000 THEN salary * 1.05
    WHEN salary > 50000 THEN salary * 1.07
	WHEN salary = 50000 THEN salary * 1
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * 0.10
END AS Bonus
FROM employee_salary
;

SELECT *
FROM parks_departments
;


