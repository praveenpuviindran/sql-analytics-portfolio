# LIMIT and Aliasing - limit specifies how many rows you want in your output

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1 # the comma says start at position 2 and then go 1 row after it
;

# Aliasing - a way to change the name of a column; can be used in JOINS

SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
HAVING AVG(age) > 40 # we don't want to always have to use our aggregate function in our having clause, hence we use aliases
;

SELECT gender, AVG(age) AS avg_age # AS is the key clause for creating aliases, don't need AS clause but useful for clarity
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40
;


