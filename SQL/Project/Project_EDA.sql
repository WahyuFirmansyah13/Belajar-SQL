--  Data Cleaning



SELECT *
FROM layoffs;

-- MEMBUAT TABEL BERNAMA LAYOFFS_STAGING DENGAN COLOM DARI TABEL LAYOFFS
CREATE TABLE layoffs_staging
LIKE layoffs;


SELECT *
FROM layoffs_staging;

-- INI UNTUK ISINYA
INSERT layoffs_staging
SELECT *
FROM layoffs;


#1. REMOVE DUPLICATE

-- MELIHAT DATA YANG DUPLIKATE 
SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, total_laid_off,`date`, percentage_laid_off, industry, `source`, stage, funds_raised, country, date_added) AS row_num
	FROM 
		layoffs_staging;
        
        
WITH duplicate_cte AS
(
SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, total_laid_off,`date`, percentage_laid_off, industry, `source`, stage, funds_raised, country, date_added) AS row_num
	FROM 
		layoffs_staging
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;



CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `total_laid_off` text,
  `date` text,
  `percentage_laid_off` text,
  `industry` text,
  `source` text,
  `stage` text,
  `funds_raised` text,
  `country` text,
  `date_added` text,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT *,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, total_laid_off,`date`, percentage_laid_off, industry, `source`, stage, funds_raised, country, date_added) AS row_num
	FROM 
		layoffs_staging;
        
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- Data Ini tidak ada yang duplicate


#2. STANDAR DIZING DATA


SELECT company, TRIM(company)
FROM layoffs_staging2;

-- Mengubah isi company dengan TRIM COMPANY(SPASI YANG BERLEBIH)
UPDATE layoffs_staging2
SET company = TRIM(company);


-- DATA INI SUDAH BERSIH KECUALI YANG BLANK
SELECT DISTINCT industry
FROM layoffs_staging2
 ORDER BY 1;

-- Sepertinya Bersih,kecuali blank
SELECT DISTINCT location
FROM layoffs_staging2
order by 1;

-- Bersih ,kecuali blank
SELECT DISTINCT country
FROM layoffs_staging2
order by 1;


SELECT `date`,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
 SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
 
 SELECT date_added,
STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date_added` = STR_TO_DATE(`date_added`, '%m/%d/%Y');

 

 
 
 ALTER TABLE layoffs_staging2
 MODIFY COLUMN `date` DATE;
 
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL OR total_laid_off='';

SELECT *
FROM layoffs_staging2
WHERE total_laid_off ='' AND percentage_laid_off ='';


SELECT *
FROM layoffs_staging2
WHERE industry IS NULL;

UPDATE layoffs_staging2
SET funds_raised = NULL
WHERE funds_raised='';


SELECT *
FROM layoffs_staging2
WHERE location='';

UPDATE layoffs_staging2
SET location= NULL
WHERE location='';

DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN row_num;

SELECT *
FROM layoffs_staging2;


SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoffs_staging2;

SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = '98%'
ORDER BY total_laid_off DESC;

SELECT company,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

SELECT industry,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

SELECT country,SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

SELECT YEAR(`date`),SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 2 DESC;

SELECT MIN(`date`),MAX(`date`)
FROM layoffs_staging2;

SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off) 
FROM layoffs_staging2
GROUP BY `MONTH`
ORDER BY 1 ASC;

WITH Rolling_total AS 
(
SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off) AS total_off
FROM layoffs_staging2
GROUP BY `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`,total_off
,SUM(total_off) OVER (ORDER BY `MONTH`) AS ROLLING_TOTAL
FROM Rolling_total;


WITH Company_Year (Company,Years,Total_laid_off) AS
(
	SELECT company, YEAR(`date`), SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
),Company_years_ranking AS
(
SELECT *, DENSE_RANK() OVER (PARTITION BY Years ORDER BY Total_laid_off DESC) AS `RANK`
FROM Company_Year
)
SELECT *
FROM Company_years_ranking
WHERE `RANK` <5;