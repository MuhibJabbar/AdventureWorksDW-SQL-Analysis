-- AdventureWorks Sales Analysis

-- Phase 2 — Data Profiling & Understanding

-- Task 1 — Identify our core tables

--| Table                   | Purpose                   |
--| ----------------------- | ------------------------- |
--| `FactInternetSales`     | Online sales transactions |
--| `FactResellerSales`     | Sales through resellers   |
--| `DimCustomer`           | Customer details          |
--| `DimProduct`            | Product details           |
--| `DimProductSubcategory` | Product subcategories     |
--| `DimProductCategory`    | Product categories        |
--| `DimDate`               | Date/calendar information |
--| `DimGeography`          | City/state/country        |
--| `DimSalesTerritory`     | Sales territories         |
--| `DimPromotion`          | Promotions/discounts      |

-- Task 2 — Check how much sales data we have

Select COUNT(*) from dbo.FactInternetSales;

-- This tells you how many sales-line records exist

Select Top 10  * from dbo.FactInternetSales

-- This tells us Top 10 rows to understand the data

Select COUNT(*) , count(distinct SalesOrderNumber) from FactInternetSales

-- Task 3 - Profile the date range

-- We need to understand what period the data covers

Select min(OrderDate) as FirstOrderDate , 
max(OrderDate) as LastOrderDate 
from dbo.FactInternetSales

--Now we know how many years of business we're analysing

Select distinct YEAR(OrderDate) as SalesYear from dbo.FactInternetSales
order by SalesYear

-- Task 4 - Basic sales numbers

Select	Sum(OrderQuantity) as Total_Orders,
		Sum(TotalProductCost) as Total_Cost,
		Sum(SalesAmount) as Total_Sales,
		Sum(SalesAmount-TotalProductCost) as Gross_Profit
from FactInternetSales

-- Task 5 - Check missing data

Select 
	sum(case when CustomerKey IS Null then 1 else 0 END) as MissingCustomers,
	sum(case when ProductKey IS NULL then 1 else 0 END ) as MissingProduct,
	sum(case when OrderDateKey IS NULL then 1 else 0 END) as MissingOrderDate,
	sum(case when OrderQuantity IS NULL then 1 else 0 END) as MIssingOrderQuantity,
	sum(case when SalesAmount IS NULL then 1 else 0 END) as MissingSalesAmount,
	sum(case when CarrierTrackingNumber IS NULL then 1 else 0 END) as MissingCTN
from dbo.FactInternetSales

-- Task 6 - Look for strange values

Select * from dbo.FactInternetSales
where SalesAmount <= 0
or OrderQuantity <= 0 
or TotalProductCost <= 0

-- we are basically asking Does the data contain values that don't make business sense?
