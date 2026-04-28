# Temporary Tables - can be used for storing intermediate results for complex queries and for manipulating data before inserting into a permanent table

-- old way - not used anymore for creating temp tables
CREATE TEMPORARY TABLE temp_table # if we just did CREATE TABLE it would create a permanent table under Parks_and_Recreation --> Tables
(first_name varchar(50),
last_name varchar(50),
favorite_movie varchar(100)
)
;

SELECT *
FROM temp_table
;

INSERT INTO temp_table
VALUES('Praveen', 'Puviindran', 'Cars')
;

SELECT *
FROM temp_table
;
--

-- new way for creating temp tables
SELECT *
FROM employee_salary
;

CREATE TEMPORARY TABLE salary_over_or_at_50k
SELECT *
FROM employee_salary
WHERE salary >= 50000
;

SELECT *
FROM salary_over_or_at_50k
; # in a new window, this temp table will still load, but if exiting out of MySQL and reopening, temp table will be erased





