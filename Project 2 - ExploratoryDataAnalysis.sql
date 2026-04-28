-- Exploratory Data Analysis, MySQL Project #2

SELECT *
FROM layoffs_staging2;

DESCRIBE layoffs_staging2;
# everything below is some more data cleaning to change dtype of total_laid_off to INT
SELECT total_laid_off
FROM layoffs_staging2
WHERE total_laid_off NOT REGEXP '^[0-9]+$'
AND total_laid_off IS NOT NULL;

SELECT funds_raised_millions
FROM layoffs_staging2
WHERE funds_raised_millions NOT REGEXP '^[0-9]+$'
AND funds_raised_millions IS NOT NULL;

SELECT percentage_laid_off
FROM layoffs_staging2
WHERE percentage_laid_off NOT REGEXP '^[0-9.]+$'
AND percentage_laid_off IS NOT NULL;

UPDATE layoffs_staging2
SET total_laid_off = NULL
WHERE total_laid_off = '';

UPDATE layoffs_staging2
SET percentage_laid_off = NULL
WHERE percentage_laid_off = '';

UPDATE layoffs_staging2
SET funds_raised_millions = NULL
WHERE funds_raised_millions = '' OR funds_raised_millions IS NULL;

ALTER TABLE layoffs_staging2
MODIFY COLUMN total_laid_off INT;

DESCRIBE layoffs_staging2;
# below is still returning NULL for MAX(percentage...), going to clean that
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT percentage_laid_off
FROM layoffs_staging2;

SELECT DISTINCT percentage_laid_off
FROM layoffs_staging2
ORDER BY percentage_laid_off;

SELECT
    COUNT(*) AS total_rows,
    COUNT(percentage_laid_off) AS non_null_values
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET percentage_laid_off = NULL
WHERE percentage_laid_off = '' OR percentage_laid_off = 'NULL';

ALTER TABLE layoffs_staging2
MODIFY COLUMN percentage_laid_off DECIMAL(5,2);
# now it's in correct format
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2; # ready for EDA

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC; # this tells you what companies completely shut down - 100% layoffs, ordered by # of employees

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2; # tells us layoffs started right around COVID (2020-03-11) to 3 years later ended (2023-03-06)

SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC; # consumer industry topped total layoffs, makes sense since COVID shut down consumer/retail industry substantially

SELECT *
FROM layoffs_staging2;

SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC; # US has most ~256,000) by nearly 7x of next country (India ~36,000)

SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC; # lets us see layoffs by year - 80k in 2020, 125k in 2023 (incomplete year), 160k in 2022, 15k in 2021

SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 1 DESC; # post-IPO companies had highest sum at 204k

SELECT *
FROM layoffs_staging2;
# now let's look at progression of layoffs, do a rolling sum from the beginning to end of the layoffs
# let's start with rolling total layoffs based off the month (day would be too much)

SELECT SUBSTRING(`date`, 6,2) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `MONTH`
; # this just shows month but doesn't give the year, so summing every month across multiple years

SELECT SUBSTRING(`date`, 1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
; # now this properly gives it from 2020-03 in month-form ascending up to 2023-03 - time to make it into a rolling sum

SELECT SUBSTRING(`date`, 1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
;

WITH Rolling_Total AS
(
SELECT SUBSTRING(`date`, 1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1,7) IS NOT NULL
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off
,SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total; # shows how 2022-2023 was a huge series of layoffs, over 130k, compared to 2021-2022 which was only around 15k

SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC; # now this looks at company based on the sum of total_laid_off

SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY company ASC; # this groups them by year

# now let's rank which years companies laid off the most employees
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC; # we'll create a CTE to rank the companies based off the year they laid off the most employees

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
)
SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
ORDER BY Ranking ASC; # now we want to partition it based off years and rank it by how many they laid off by

WITH Company_Year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS 
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL # now we can filter it to be top 5 companies by year, filter on Ranking - big thing is we created a CTE within another CTE
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <= 5; # this lets us just see the top 5 ranked companies by # laid off, ordered by year
-- END
