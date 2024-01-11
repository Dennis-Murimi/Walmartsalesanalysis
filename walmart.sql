select*
from [dbo].[WalmartSalesData.csv (1)]

-----FEATURE ENGINEERING
select [Time]
from [WalmartSalesData.csv (1)]

-----time of day
select
	[Time],
	(case 
		when DATEPART(hour,time)between 0 and 11 then 'Morning'
		when DATEPART(hour,time)between 12 and 16 then 'Afternoon'
		else 'Evening'
	end) as time_of_day
from [WalmartSalesData.csv (1)]

alter table [WalmartSalesData.csv (1)]
add time_of_day varchar(20)

update [WalmartSalesData.csv (1)]
set time_of_day = (
	case 
		when DATEPART(hour,time)between 0 and 11 then 'Morning'
		when DATEPART(hour,time)between 12 and 16 then 'Afternoon'
		else 'Evening'
	end)

select time_of_day
from [WalmartSalesData.csv (1)]

------Day of week
select [Date],
DATENAME(dw,date) as day_of_week
from [WalmartSalesData.csv (1)]

alter table [WalmartSalesData.csv (1)]
add day_of_week varchar(10)

update [WalmartSalesData.csv (1)]
set day_of_week = DATENAME(dw,date)

select day_of_week
from [WalmartSalesData.csv (1)]

select*
from [WalmartSalesData.csv (1)]

------month name

select [Date],
DATENAME(month,date) as month_name
from [WalmartSalesData.csv (1)]

alter table [WalmartSalesData.csv (1)]
add month_name varchar(10)

update [WalmartSalesData.csv (1)]
set month_name = DATENAME(month,date)

select*
from [WalmartSalesData.csv (1)]

-------How many unique cities does the data have--

select distinct [City]
from [WalmartSalesData.csv (1)]

----In which city is each branch
select distinct [Branch]
from [WalmartSalesData.csv (1)]

select distinct [City], [Branch]
from [WalmartSalesData.csv (1)]


------PRODUCT ANALYSIS
-------How many unique products
select distinct [Product_line]
from [WalmartSalesData.csv (1)]

------Common payment method
select [Payment],COUNT ([Payment]) as cnt
from [WalmartSalesData.csv (1)]
group by [Payment]
order by cnt desc

-------Best selling product line
select [Product_line], COUNT([Product_line]) as cnt
from [WalmartSalesData.csv (1)]
group by [Product_line]
order by cnt desc

-------Total revenue monthly
select [month_name], sum ([Total]) as Total_revenue
from [WalmartSalesData.csv (1)]
group by [month_name]
order by Total_revenue desc

-------Largest COGs by month
select [month_name], sum([cogs]) as cogs
from [WalmartSalesData.csv (1)]
group by [month_name]
order by cogs desc

-----Product line with largest revenue
select [Product_line], sum([Total]) as Total_revenue
from [WalmartSalesData.csv (1)]
group by [Product_line]
order by Total_revenue desc

------City with the greatest revenue
select [Branch],[City],sum([Total]) as Total_revenue
from [WalmartSalesData.csv (1)]
group by [Branch],[City]
order by Total_revenue desc

------Largest VAT by product line
select [Product_line], avg([Tax_5])as avg_VAT
from [WalmartSalesData.csv (1)]
group by [Product_line]
order by avg_VAT desc

-------Branch exceeding average sales
select [Branch], sum([Quantity]) as qty_sold
from [WalmartSalesData.csv (1)]
group by [Branch]
having sum([Quantity]) > (select avg([Quantity]) from [WalmartSalesData.csv (1)])

-------Most common product line by gender
select distinct [Gender], [Product_line],count([Product_line])as cnt
from [WalmartSalesData.csv (1)]
group by [Gender], [Product_line]
order by cnt desc

-------Average rating by product line
select [Product_line], ROUND(avg([Rating]),2)as avg_rating
from [WalmartSalesData.csv (1)]
group by [Product_line]
order by avg_rating desc

------SALES ANALYSIS
-------Sales made in each time of day per weekday--
select [time_of_day], count ([Invoice_ID]) as sales
from [WalmartSalesData.csv (1)]
where [day_of_week]='Monday'
group by [time_of_day]
order by sales desc

-------which of the customer type brings in more revenue---
select [Customer_type],round(sum([Total]),2 )as revenue
from [WalmartSalesData.csv (1)]
group by [Customer_type]
order by revenue desc

------which city has the largest tax percentage---
select [City], round(avg([Tax_5]),2)as tax
from [WalmartSalesData.csv (1)]
group by [City]
order by tax desc

-------which customer type pays the most in VAT
select [Customer_type], round(avg([Tax_5]),2)as tax
from [WalmartSalesData.csv (1)]
group by [Customer_type]
order by tax desc

------CUSTOMER ANALYSIS---
------How many unique customer types does the data has---
select distinct[Customer_type]
from [WalmartSalesData.csv (1)]

------Unique payment methods--
select distinct[Payment], count([Payment]) as cnt
from [WalmartSalesData.csv (1)]
group by [Payment]
order by cnt desc

-----What is the most common customer type
select distinct[Customer_type], count([Customer_type]) as cnt
from [WalmartSalesData.csv (1)]
group by [Customer_type]
order by cnt desc

-----Which customer type buys the most--
select[Customer_type], count([Customer_type]) as cnt
from [WalmartSalesData.csv (1)]
group by [Customer_type]
order by cnt desc

----What is the gender of most customers
select [Gender], count(*) as customers
from [WalmartSalesData.csv (1)]
group by [Gender]
order by customers desc

-------What is the gender distribution per branch
select [Gender], count(*) as customers
from [WalmartSalesData.csv (1)]
where [Branch]='A'
group by [Gender]
order by customers desc

------Which time of the day do most customers give in most rating----
select [time_of_day], round(avg([Rating]),2) as rate
from [WalmartSalesData.csv (1)]
group by [time_of_day]
order by rate desc

------Which time of the day do most customers give in most rating per branch...
select [time_of_day], round(avg([Rating]),2) as rate
from [WalmartSalesData.csv (1)]
where [Branch]='A'
group by [time_of_day]
order by rate desc

------Which day of the week has the best average rating---
select [day_of_week], round(avg([Rating]),2) as rate
from [WalmartSalesData.csv (1)]
group by [day_of_week]
order by rate desc

------Which day of the week has the best average rating per branch---
select [day_of_week], round(avg([Rating]),2) as rate
from [WalmartSalesData.csv (1)]
where [Branch]='B'
group by [day_of_week]
order by rate desc


