/*

06 - PRODUCT ANALYSIS
AdventureWorksDW2022 Sales Analytics


OBJECTIVE:
Analyze product, subcategory, and category performance
to identify best sellers, most profitable products,
low-performing products, and revenue concentration.

*/

USE AdventureWorksDW2022;
GO

-- Task 1 Total Product Sold 

Select
	count(distinct ProductKey) as Product_Sold
from dbo.FactInternetSales

/*
DimProduct = all products in the database
FactInternetSales = products that actually sold
*/

-- Task 2 Product Level Sales Performance

Select
	Top 10
	dp.ProductKey,
	dp.EnglishProductName,
	Sum(fis.OrderQuantity) as UnitSold,
	Round(Sum(SalesAmount),2) as Revenue,
	Round(Sum(fis.TotalProductCost),2) as Total_Cost,
	Round(Sum(fis.SalesAmount-fis.TotalProductCost),2) as Gross_Profit
from dbo.FactInternetSales as fis

inner join DimProduct as dp
on fis.ProductKey = dp.ProductKey

Group by dp.ProductKey,dp.EnglishProductName
order by Revenue desc

-- Task 3 Top 10 Most Profitable Products

Select TOP 10
	dp.EnglishProductName,
	SUM(SalesAmount) as Revenue,
	round(SUM(TotalProductCost),2) as Total_Cost,
	round(sum(fis.SalesAmount - fis.TotalProductCost),2) as gross_profit
from dbo.FactInternetSales as fis

inner join DimProduct as dp
on fis.ProductKey = dp.ProductKey

group by dp.EnglishProductName
order by gross_profit Desc

-- Task 4 Top 20 Products Profit Margin

Select TOP 20
	dp.EnglishProductName,
	SUM(SalesAmount) as Revenue,
	round(SUM(TotalProductCost),2) as Total_Cost,
	round(sum(fis.SalesAmount - fis.TotalProductCost),2) as gross_profit,
	round(Sum(fis.SalesAmount - fis.TotalProductCost)/sum(fis.SalesAmount)*100,2) as gross_profit_margin
from dbo.FactInternetSales as fis

inner join DimProduct as dp
on fis.ProductKey = dp.ProductKey

group by dp.EnglishProductName
order by gross_profit_margin Desc

-- Task 5 Category Performance and ranking

With ProductSales AS(
select
	dpc.EnglishProductCategoryName as Category_Name,
	dp.EnglishProductName as Product_Name,
	dpsc.EnglishProductSubcategoryName as Sub_Category_Name,
	Round(SUM(SalesAmount),2) as Revenue,
	Round(Sum(SalesAmount-TotalProductCost),2) as Gross_Profit,
	Round(Sum(SalesAmount-TotalProductCost)/sum(SalesAmount)*100,2) as Gross_Profit_Margin 
from dbo.FactInternetSales as fis

inner join DimProduct as dp 
on fis.ProductKey = dp.ProductKey

inner join DimProductSubcategory as dpsc
on dp.ProductSubcategoryKey = dpsc.ProductSubcategoryKey

inner join DimProductCategory as dpc
on dpsc.ProductCategoryKey = dpc.ProductCategoryKey

Group by dp.EnglishProductName , dpc.EnglishProductCategoryName , dpsc.EnglishProductSubcategoryName

)

Select Category_Name,
	   Product_Name,
	   Revenue,
	rank() over(
		partition by Category_Name
		order by Revenue desc
	)as Product_Rank
from ProductSales

order by Category_Name , Product_Rank;

-- Task 6 Revenue contibution by category

WITH CategorySales AS
( SELECT
        dpc.EnglishProductCategoryName AS Category,
        SUM(fis.SalesAmount) AS Revenue
FROM dbo.FactInternetSales AS fis

 inner JOIN dbo.DimProduct AS dp
        ON fis.ProductKey = dp.ProductKey
 inner JOIN dbo.DimProductSubcategory AS dps
        ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey
 inner JOIN dbo.DimProductCategory AS dpc
        ON dps.ProductCategoryKey = dpc.ProductCategoryKey

    GROUP BY
        dpc.EnglishProductCategoryName
)

SELECT
    Category,
    ROUND(Revenue, 2) AS Revenue,
    ROUND(
        Revenue * 100 /
        SUM(Revenue) OVER(),
        2
    ) AS RevenueContributionPct
FROM CategorySales
ORDER BY Revenue DESC;