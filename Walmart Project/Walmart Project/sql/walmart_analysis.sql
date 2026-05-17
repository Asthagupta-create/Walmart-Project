Create database walmart_sales;
Use walmart_sales;

select * from walmart_final_v3;
select count(*) from walmart_final_v3;

-- 1. KPI QUERY (TOTAL SALES)
select  round(SUM(Weekly_Sales),2) as Total_Sales
from walmart_final_v3;

-- 2. KPI QUERY (TOTAL STORES)
select COUNT(DISTINCT Store) as Total_Stores
from walmart_final_v3;

-- 3. KPI QUERY (TOTAL DEPARTMENTS)
select COUNT(DISTINCT Dept) as Total_Departments
from walmart_final_v3;

-- 4. KPI QUERY (AVERAGE WEEKLY SALES)
select ROUND(AVG(Weekly_Sales),2) as Avg_Weekly_Sales
from walmart_final_v3;

-- 5. STORE-WISE SALES ANALYSIS
select Store,ROUND(SUM(Weekly_Sales),2) as Total_Sales
from walmart_final_v3
group by Store
order by Total_Sales DESC;

-- 6. TOP 10 STORES
select Store, ROUND(SUM(Weekly_Sales),2) as Revenue
from walmart_final_v3
group by Store
order by  Revenue DESC
limit 10;

-- 7. MONTHLY SALES TREND
select YEAR(Date) as Year,monthname(Date) as Month_Name,round(sum(Weekly_Sales),2) as Monthly_Sales
from walmart_final_v3
group by Year, MONTH(Date), Month_Name
order by Year, MONTH(Date);

-- 8. YEARLY SALES ANALYSIS
select 
    YEAR(Date) as Year,
    round(sum(Weekly_Sales),2) as Yearly_Sales
from walmart_final_v3
group by Year
order by Year;

-- 9. HOLIDAY SALES ANALYSIS
select case 
        when IsHoliday = 1 then 'Holiday'
        else 'Non-Holiday'
    end as Holiday_Type,
    round(sum(Weekly_Sales),2) as Total_Sales, round(avg(Weekly_Sales),2) as Avg_Sales
from walmart_final_v3
group by Holiday_Type;

-- 10. DEPARTMENT-WISE SALES
select Dept, round(sum(Weekly_Sales),2) as Total_Sales
from walmart_final_v3
group by Dept
order by Total_Sales DESC;

-- 11. SALES BY STORE SIZE
select Store,Size,round(sum(Weekly_Sales),2) as Total_Sales
from walmart_final_v3
group by Store, Size
order by  Total_Sales DESC;

-- 12. FUEL PRICE IMPACT ON SALES
select round(Fuel_Price,2) as Fuel_Price, round(avg(Weekly_Sales),2) as Avg_Sales
from walmart_final_v3
group by Fuel_Price
order by Fuel_Price;

-- 13. CPI IMPACT ON SALES
select round(CPI,2) as CPI, round(avg(Weekly_Sales),2) AS Avg_Sales
from walmart_final_v3
group by CPI
order by CPI;

-- 14. UNEMPLOYMENT IMPACT ON SALES
select round(Unemployment,2) as Unemployment_Rate,round(AVG(Weekly_Sales),2) as Avg_Sales
from walmart_final_v3
group by Unemployment_Rate
order by Unemployment_Rate;

-- 15. MARKDOWN IMPACT ANALYSIS
select round(sum(MarkDown1 + MarkDown2 + MarkDown3 + MarkDown4 + MarkDown5),2) as Total_Markdowns,
round(sum(Weekly_Sales),2) as Total_Sales
from walmart_final_v3;

-- 16. TOP PERFORMING DEPARTMENTS
select Dept, round(avg(Weekly_Sales),2) as Avg_Sales
from walmart_final_v3
group by Dept
order by Avg_Sales DESC
limit 10;

-- 17. SALES TREND USING WINDOW FUNCTION
select Store, date, Weekly_Sales, round(AVG(Weekly_Sales) OVER(PARTITION BY Store
ORDER BY Date ROWS BETWEEN 3 PRECEDING AND CURRENT ROW),2) as Moving_Average_Sales
from walmart_final_v3;

-- 18. STORE RANKING USING WINDOW FUNCTION
select store,round(sum(Weekly_Sales),2) as Total_Sales,
rank() over(order by SUM(Weekly_Sales) DESC) as Store_Rank
from walmart_final_v3
group by Store;



