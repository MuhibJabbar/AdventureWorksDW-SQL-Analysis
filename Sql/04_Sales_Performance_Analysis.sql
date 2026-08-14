-- AdventureWorksDW2022 Sales Analytics

-- OBJECTIVE

-- Analyze overall sales performance and identify trends in revenue, gross profit, orders, units sold and growth

-- Task 1 KPI's

select * from dbo.FactInternetSales

Select distinct COUNT(SalesOrderNumber) as UnitSold,
	   ROUND(SUM(SalesAmount),2) as TotalRevenue,
	   ROUND(SUM(TotalProductCost),2) as TotalCost,
	   ROUND(Sum(SalesAmount-TotalProductCost),2) GrossProfit,
	   ROUND(SUM(OrderQuantity),2) as TotalOrders

from dbo.FactInternetSales

-- Task 2 Gross Profit Margin

Select 
	round(sum(SalesAmount),2) as Total_Revenue,

	round(sum(SalesAmount-TotalProductCost),2) as Gross_Profit,

	round(sum(SalesAmount-TotalProductCost)/nullif(sum(SalesAmount),0)*100,2) as Gross_Profit_Margin

from dbo.FactInternetSales

-- Task 3 Avg Order Value

Select round(sum(SalesAmount)/
			nullif(count(distinct SalesOrderNumber),0),2) as avg_order_value

from dbo.FactInternetSales

-- Task 4 Revenue by year 

select year(OrderDate) as SalesYear,
	ROUND(SUM(SalesAmount),2) as Revenue
from dbo.FactInternetSales
group by Year(OrderDate)
order by SalesYear

-- Task 5 Performance By Year

Select Year(OrderDate) as Sales_Year,
	   ROUND(SUM(SalesAmount),2) as Revenue,
	   ROUND(SUM(SalesAmount-TotalProductCost),2) as Gross_Profit,
	   Count(distinct SalesOrderNumber) as Orders,
	   Sum(OrderQuantity) as Unit_Sold,
	   round(sum(SalesAmount)/
			nullif(count(distinct SalesOrderNumber),0),2) as avg_order_value
from dbo.FactInternetSales
group by YEAR(OrderDate)
order by Sales_Year

-- Task 5 Monthly Sales Trend and top 10 best months

Select 
	   Top 10
	   YEAR(OrderDate) as Sales_Year,
	   MONTH(OrderDate) as Sales_Month,
	   DATENAME(MONTH, OrderDate) as Month_Name,
	   round(sum(SalesAmount),2) as Monthly_Sales
from dbo.FactInternetSales
group by YEAR(OrderDate),
		 MONTH(OrderDate),
		 DATENAME(Month,OrderDate)
order by Monthly_Sales desc

--- Task 6 Top 10 Worst Sales Months

Select 
	   Top 10
	   YEAR(OrderDate) as Sales_Year,
	   MONTH(OrderDate) as Sales_Month,
	   DATENAME(MONTH, OrderDate) as Month_Name,
	   round(sum(SalesAmount),2) as Monthly_Sales
from dbo.FactInternetSales
-- where YEAR(OrderDate) = 2012
group by YEAR(OrderDate),
		 MONTH(OrderDate),
		 DATENAME(Month,OrderDate)
order by Monthly_Sales Asc

-- Task 7 Year Over Year Growth

-- CTE 
With YearlySales as (
	Select YEAR(OrderDate) as SalesYear,
	ROUND(SUM(SalesAmount),2) as revenue
	from dbo.FactInternetSales
	group by YEAR(OrderDate)
),
YearlyComparison as(
	select SalesYear,
		   revenue,
		   LAG(revenue) over (order by SalesYear) as PreviousYearRevenue
	from YearlySales
)

Select SalesYear,
	   round(revenue,2) as revenue,
	   ROUND(PreviousYearRevenue,2) as previous_revenue,
	   ROUND(
	   (revenue-PreviousYearRevenue)
	   /nullif(PreviousYearRevenue,0)*100,2) as YOYGrowth
from YearlyComparison

-- Task 8 Running Total Revenue Month By Month 

WITH MonthlySales AS
(
    SELECT
        YEAR(OrderDate) AS SalesYear,
        MONTH(OrderDate) AS SalesMonth,
        SUM(SalesAmount) AS Revenue
    FROM dbo.FactInternetSales
    GROUP BY
        YEAR(OrderDate),
        MONTH(OrderDate)
)

SELECT
    SalesYear,
    SalesMonth,
    ROUND(Revenue, 2) AS MonthlyRevenue,

    ROUND(
        SUM(Revenue) OVER (
            ORDER BY SalesYear, SalesMonth
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS RunningRevenue

FROM MonthlySales
ORDER BY
    SalesYear,
    SalesMonth;