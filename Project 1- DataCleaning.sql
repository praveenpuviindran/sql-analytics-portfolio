-- Source - https://stackoverflow.com/a/11448324
-- Posted by Habibillah, modified by community. See post 'Timeline' for change history
-- Retrieved 2026-04-24, License - CC BY-SA 3.0

SET SQL_SAFE_UPDATES = 0;

-- Data Cleaning, MySQL Project #1

# GOALS
-- 1. remove any duplicates
-- 2. standardize the data (dtypes, spelling, etc.)
-- 3. look at null/blank values
-- 4. remove any irrelevant columns

SELECT *
FROM layoffs;

# first thing we do is create a staging dataset to ensure raw dataset is not being manipulated
CREATE TABLE layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

INSERT layoffs_staging
SELECT *
FROM layoffs;
# lines 13-21 are how to create a staging dataset; CREATE TABLE just transfers column names, creates empty set
# INSERT allows for transfer of all data into the staging dataset

-- 1. remove any duplicates
# first thing you can do is create a row number column, that identifies whether there are any duplicates (if row number > 1)
SELECT *
FROM layoffs_staging;
# partition over every single column to ensure all possible columns are checked for duplicates
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;c

# create a CTE
WITH duplicate_cte AS
(
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

# inspect one set of duplicates to ensure accuracy of query
SELECT *
FROM layoffs_staging
WHERE company = 'Casper';

# delete syntax like this won't work because you can't modify the cte
DELETE
FROM duplicate_cte
WHERE row_num > 1;

# better option is taking the staging dataset, creating a staging2 dataset, filtering on row_num, and then delete by row_num > 1
# right-click layoffs_staging dataset --> copy to clipboard --> create statement
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` text,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;
# once again, the above creates an empty dataset with same columns - need to insert data into new staging2 dataset
INSERT INTO layoffs_staging2
SELECT *,
ROW_NUMBER() OVER(
	PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging;

# filter to ensure duplicates transferred correctly
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

# now we can delete duplicates
DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM layoffs_staging2;
# done step 1, can remove the row_num column at the end since no longer needed

-- 2. standardize the data
# first remove any whitespace from the company column text using the TRIM function
SELECT company, TRIM(company)
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET company = TRIM(company);

SELECT company
FROM layoffs_staging2;

SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1;
# crypto/crypto currency/cryptocurrency are all the same things - need to standardize
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';
# looks like majority is Crypto, so udpate all to be that
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1;
# everything worked - CryptoCurrency and Crypto Currency changed to Crypto

SELECT DISTINCT location
FROM layoffs_staging
ORDER BY 1;
# everything looks good for location
SELECT DISTINCT country
FROM layoffs_staging
ORDER BY 1;

SELECT DISTINCT(country)
FROM layoffs_staging2
WHERE country LIKE 'United States%';

UPDATE layoffs_staging2
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%';

SELECT DISTINCT(country)
FROM layoffs_staging2
ORDER BY 1;
# done - same process as changing the crypto errors, just a syntax replacement : below is another way to do the same thing
SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';
# won't run because we already changed the United States syntax above - but just alternate solution
# next, we need to change the date column from type TEXT to type DATETIME

SELECT `date`
FROM layoffs_staging2;
# we want to reformat it to be mm/dd/yyyy, not just as text - possibly 3 separate columns
# string to date:
SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y') # must be column you're changing, to what you want format to be: must be m not M, must be Y not y
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = NULL
WHERE `date` = 'NULL';

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_staging2;

# now date variable is in correct format, but dtype is still text note date:
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2;

-- 3. look at null/blank values
# first look at total_laid_off column

UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL; # this would usually work, but NULL is hardcoded in, not properly as NULL values

SELECT *
FROM layoffs_staging2
WHERE total_laid_off = 'NULL'
AND percentage_laid_off = 'NULL';

SELECT *
FROM layoffs_staging2
WHERE industry = 'NULL'
OR industry = '';

SELECT *
FROM layoffs_staging2
WHERE company = 'Airbnb'; # idnustry is Travel but one row is missing that - can input Travel into that to fix

SELECT t1.industry, t2.industry
FROM layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
WHERE (t1.industry = '' OR t1.industry IS NULL)
AND t2.industry IS NOT NULL; # now need to translate this to an UPDATE statement

UPDATE layoffs_staging2 AS t1
JOIN layoffs_staging2 AS t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL)
AND t2.industry IS NOT NULL; # now it updates correctly

SELECT *
FROM layoffs_staging2
WHERE total_laid_off = 'NULL'
AND percentage_laid_off = 'NULL';

DELETE
FROM layoffs_staging2
WHERE total_laid_off = 'NULL' OR total_laid_off IS NULL
AND percentage_laid_off = 'NULL' OR percentage_laid_off IS NULL;

SELECT *
FROM layoffs_staging2;

# remove row_num column
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2; # FINISHED!
-- END