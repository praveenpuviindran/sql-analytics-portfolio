# String functions - built-in fucntions within MySQL that help build and work with strings differently

SELECT length('skyfall')
;

SELECT first_name, LENGTH(first_name)
FROM employee_demographics
ORDER BY 2 # orders by column 2 length, default is ascending order
;

SELECT UPPER('sky');
SELECT LOWER('sky');

SELECT first_name, last_name, UPPER(first_name), UPPER(last_name)
FROM employee_demographics;

SELECT TRIM('                sky            '); # removes leading and trailing whitespace
SELECT LTRIM('                sky            '); # only removes leading whitespace
SELECT RTRIM('                sky            '); # only removes trailing whitespace

# substring

SELECT first_name, LEFT(first_name, 4) # 4 specifies how many characters from the left hand side we want to select
FROM employee_demographics
;

SELECT first_name,
LEFT(first_name, 4),
RIGHT(first_name, 4)
FROM employee_demographics
;

SELECT first_name,
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name, 3, 2) # 3 is the position we want to start at, 2 is how many characters we want to go, 3rd position to the right 2 characters
FROM employee_demographics
;

SELECT first_name,
LEFT(first_name, 4),
RIGHT(first_name, 4),
SUBSTRING(first_name, 3, 2),
birth_date,
SUBSTRING(birth_date, 6, 2) AS birth_month
FROM employee_demographics
;

# REPLACE replaces specific characters with different characters
SELECT first_name, REPLACE(first_name, 'a', 'z') # specifies what you want to replace (a) with what you want to replace it with (z)
FROM employee_demographics
;

SELECT LOCATE('v', 'Praveen') # tells us character v is in position 4 of Praveen
;

SELECT first_name, LOCATE('An', first_name)
FROM employee_demographics
;

SELECT first_name, last_name,
CONCAT(first_name,' ', last_name) AS full_name
FROM employee_demographics
;



