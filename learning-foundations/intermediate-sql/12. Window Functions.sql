# Window Functions - somewhat like a group by, they allow us to look at a partition/group but they each keep their unique rows in output

SELECT gender, AVG(salary) AS avg_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
GROUP BY gender # GROUP BY rolls everything into one row
;

SELECT gender, AVG(salary) OVER() # we're looking at the average salary over (in this case) everything
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
; # output is average salary regardless of gender

SELECT dem.first_name, dem.last_name, gender, AVG(salary) OVER(PARTITION BY gender) # adding more columns doesn't affect aggregated column b/c of WINDOW function
# this won't roll everything into one row like GROUP BY but it performs the calculation based off of the different genders
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
; # output is average salary partitioned by gender

SELECT dem.first_name, dem.last_name, gender, 
SUM(salary) OVER(PARTITION BY gender) # sum obviously differs from avg, cna be used in different cases
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

# a rolling total starts at a specific value and adds on values from subsequent rows based off of your partition
SELECT dem.first_name, dem.last_name, gender, salary,
SUM(salary) OVER(PARTITION BY gender ORDER BY dem.employee_id) AS rolling_total
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

# row number
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender) # gives each row number partitioned by gender
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) # orders the row numbers, partitions by gender, and lists them by salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

# rank
SELECT dem.employee_id, dem.first_name, dem.last_name, gender, salary,
ROW_NUMBER() OVER(PARTITION BY gender ORDER BY salary DESC) AS row_num, # row_number never has duplicate rows within partition
RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rank_num, # rank can have duplicate ranks (ex. 50000 salary has two people ranked #5, row number ignores
DENSE_RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS dense_rank_num # after duplicates, it gives next number NUMERICALLY (dense rank) instead of POSITIONALLY (rank)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;



