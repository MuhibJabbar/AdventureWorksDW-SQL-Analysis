-- Phase 3 — Relationships & JOINs

-- Task 1 - First JOIN: Sales + Customer

Select Top 10
	   dc.FirstName,
	   dc.LastName,
	   fis.CustomerKey,
	   fis.OrderDate,
	   fis.SalesOrderNumber,
	   fis.SalesAmount
from dbo.FactInternetSales as fis
Inner Join dbo.DimCustomer as dc
	on fis.customerkey = dc.customerkey

-- Task 2 - Create a proper customer name

Select Top 10
	   CONCAT(dc.FirstName, ' ' , dc.LastName) as CustomerName,
	   fis.CustomerKey,
	   fis.OrderDate,
	   fis.SalesOrderNumber,
	   fis.SalesAmount
from dbo.FactInternetSales as fis
Inner Join dbo.DimCustomer as dc
	on fis.customerkey = dc.customerkey

Select * from dbo.DimProduct;

-- Task 3 - Sales and Prouct

Select top 10
	   dp.EnglishProductName,
	   fis.OrderDate,
	   fis.SalesOrderNumber,
	   fis.SalesAmount
from dbo.FactInternetSales as fis
inner join dbo.DimProduct as dp
	on fis.ProductKey = dp.ProductKey

-- Lets see our actual rows before joining sometimes joins miss the rows

SELECT COUNT(*) AS ActualRows
FROM dbo.FactInternetSales;

-- Task 4 - Sale + Customer + Product + product sub category + Product Category + geograpghy + territory

Select top 10
	CONCAT(dc.FirstName,' ' , dc.LastName) as CustomerName,
	dc.EmailAddress,
	dg.EnglishCountryRegionName,
	dg.City,
	dst.SalesTerritoryCountry,
	dst.SalesTerritoryGroup,
	dp.EnglishProductName,
	dps.EnglishProductSubcategoryName,
	dpc.EnglishProductCategoryName,
	fis.SalesOrderNumber,
	fis.OrderDate,
	fis.SalesAmount
from dbo.FactInternetSales as fis
inner join dbo.DimCustomer as dc
	on fis.CustomerKey = dc.CustomerKey

inner join dbo.DimProduct as dp
	on fis.ProductKey = dp.ProductKey

inner join dbo.DimProductSubcategory as dps
	on dp.ProductSubcategoryKey = dps.ProductSubcategoryKey

inner join dbo.DimProductCategory as dpc
	on dps.ProductCategoryKey = dpc.ProductCategoryKey

inner join  dbo.DimGeography as dg
	on dc.GeographyKey = dg.GeographyKey

inner join dbo.DimSalesTerritory as dst
	on dg.SalesTerritoryKey = dst.SalesTerritoryKey

-- Lets check rows after joins 

SELECT COUNT(*) AS JoinedRows
FROM dbo.FactInternetSales AS fis

INNER JOIN dbo.DimCustomer AS dc
    ON fis.CustomerKey = dc.CustomerKey

INNER JOIN dbo.DimProduct AS dp
    ON fis.ProductKey = dp.ProductKey;

-- Task 5 - Check Missing Values sales customer and products

Select 
	fis.SalesOrderNumber,
	dc.CustomerKey,
	dp.ProductKey
from dbo.FactInternetSales as fis
inner join dbo.DimProduct as dp
	on fis.ProductKey = dp.ProductKey
inner join dbo.DimCustomer as dc
	on fis.CustomerKey= dc.CustomerKey

where fis.SalesOrderNumber is null or 
	  dp.ProductKey is null or
	  dc.CustomerKey is null

-- This is called referential integrity checking
