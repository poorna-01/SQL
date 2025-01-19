-- Exploratory Data Analysis        

Select * from layoffs_staging2;

Select max(total_laid_off),max(percentage_laid_off)
from layoffs_staging2;

Select * from layoffs_staging2
where percentage_laid_off = 1
order by funds_raised_millions desc;



select company, sum(total_laid_off)
from layoffs_staging2
group by 1
order by 2 desc;

Select min(`date`),max(`date`)
from layoffs_staging2;

select industry, sum(total_laid_off)
from layoffs_staging2
group by 1
order by 2 desc;

select country, sum(total_laid_off)
from layoffs_staging2
group by 1
order by 2 desc;

select year(`date`), sum(total_laid_off)
from layoffs_staging2
group by 1
order by 1 desc;

select stage, sum(total_laid_off)
from layoffs_staging2
group by 1
order by 2 desc;


select company, sum(total_laid_off)
from layoffs_staging2
group by 1
order by 2 desc;

Select substring(`date`,1,7) as month,sum(total_laid_off)
from layoffs_staging2
where substring(`date`,1,7) is not null
group by 1
order by 1 asc;

-- rolling sum

with roll_total as (
Select substring(`date`,1,7) as month,sum(total_laid_off) as total_laid_off
from layoffs_staging2
where substring(`date`,1,7) is not null
group by 1
order by 1 asc
)
Select `month`,total_laid_off, sum(total_laid_off) over (order by `month`)
from roll_total;

-- rank which year they laid off more

select company,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by 1,2
order by 3 desc;

with ranking_comp_year(company,year,total_laid_off) as (
select company,year(`date`), sum(total_laid_off)
from layoffs_staging2
group by 1,2
)
, comp_year_rank as (Select *,dense_rank() 
over (partition by year order by total_laid_off desc) as ranking
from ranking_comp_year where year is not null
)
select * from comp_year_rank
where ranking <=5 ;

Select * 
from layoffs_staging2;

