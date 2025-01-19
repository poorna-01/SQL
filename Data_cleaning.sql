create database world_layoffs;

select * from layoffs;

create table layoffs_staging 
like layoffs;

select * from layoffs_staging;

Insert into layoffs_staging
select * from layoffs;

select * from layoffs_staging;

-- Remove Duplicates
-- Standardize data
-- null values or blank values
-- remove column unneceesary

select * , row_number() over (partition by company,industry,total_laid_off,percentage_laid_off,'date') as row_num  
from layoffs_staging;

with cte as (
select * , row_number() 
over (partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num  
from layoffs_staging
)

select * from cte where row_num > 1;


select * from layoffs_staging where company = 'Casper';

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * from layoffs_staging2;

Insert into layoffs_staging2 
select * , row_number() 
over (partition by company,location,industry,total_laid_off,percentage_laid_off,'date',stage,country,funds_raised_millions) as row_num  
from layoffs_staging;


select * from layoffs_staging2 where row_num > 1;

delete from layoffs_staging2 where row_num > 1;


select * from layoffs_staging2;


-- Standardizing Data
select * from layoffs_staging2;

Select company , trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);

select * from layoffs_staging2;

Select distinct industry 
from layoffs_staging2
order by 1;

Select * from layoffs_staging2 
where industry like 'Crypto%';

update layoffs_staging2
set industry = 'Crypto'
where industry like 'Crypto%';

Select distinct country 
from layoffs_staging2
order by 1;

Select  distinct country , trim(trailing '.' from country)
from layoffs_staging2
where country like 'United States%';

update layoffs_staging2
set country = trim(trailing '.' from country)
where country like 'United States%';

-- date (text to date format)

Select date , str_to_date(`date` , '%m/%d/%Y')
from layoffs_staging2 ;

update layoffs_staging2
set date = str_to_date(`date` , '%m/%d/%Y');

Alter table layoffs_staging2
modify column `date` DATE;

Select * from layoffs_staging2;

-- Null and Blank values

select * from layoffs_staging2;

select * from layoffs_staging2
where industry is null or industry = '';

select * from layoffs_staging2
where company = 'Airbnb' ;

update layoffs_staging2
set industry = null
where industry = '';

Select t1.industry, t2.industry from layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company and t1.location = t2.location
where t1.industry is null
and t2.industry is not null;

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company and t1.location = t2.location
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;


-- remove unwanted column and row

Select * from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;


delete from layoffs_staging2
where total_laid_off is null 
and percentage_laid_off is null;

Select * from layoffs_staging2;

Alter table layoffs_staging2
drop column row_num;



Select * from layoffs_staging2;





