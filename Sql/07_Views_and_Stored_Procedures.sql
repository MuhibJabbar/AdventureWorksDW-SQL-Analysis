/*
07 - VIEWS & STORED PROCEDURES

OBJECTIVE:
Create reusable SQL objects for common reporting and analytical
requirements.

*/

-- Task 1 — Create a Sales Analysis View

Create or ALter View dbo.vw_InternetSalesAnalysis As

Select
	fis.SalesOrderNumber,
	fis.OrderDate,
	dc.CustomerKey,
	CONCAT(FirstName,' ', LastName) as CustomerName,
	dp.ProductKey,
	dp.EnglishProductName as ProductName,
	dps.EnglishProductSubcategoryName as SubCategory,
	dpc.EnglishProductCategoryName as Category,
	dg.City,
	dg.StateProvinceName as Stateprovince,
	dg.EnglishCountryRegionName as Country,
	dst.SalesTerritoryRegion as TerritoryRegion,
	dst.SalesTerritoryGroup as TerritoryGroup,
	
	fis.OrderQuantity,
	fis.UnitPrice,
	fis.SalesAmount,
	fis.TotalProductCost,

	fis.SalesAmount-fis.TotalProductCost as GrossProfit
from dbo.FactInternetSales as fis

Inner Join DimCustomer as dc
on fis.CustomerKey = dc.CustomerKey

Inner Join DimProduct as dp
on fis.ProductKey = dp.ProductKey

Inner Join DimProductSubcategory as dps
on dp.ProductSubcategoryKey = dps.ProductSubcategoryKey

Inner Join DimProductCategory as dpc
on dps.ProductCategoryKey = dpc.ProductCategoryKey

Inner Join DimGeography as dg
on dc.GeographyKey = dg.GeographyKey

Inner Join DimSalesTerritory as dst
on dg.SalesTerritoryKey = dst.SalesTerritoryKey

Go

Select 
	Top 100
* from dbo.vw_InternetSalesAnalysis

-- Task 2 -- Product Performance View

CREATE OR ALTER VIEW dbo.vw_ProductPerformance
AS

SELECT
    dp.ProductKey,
    dp.EnglishProductName AS ProductName,

    dps.EnglishProductSubcategoryName AS Subcategory,
    dpc.EnglishProductCategoryName AS Category,

    SUM(fis.OrderQuantity) AS UnitsSold,

    COUNT(DISTINCT fis.SalesOrderNumber) AS Orders,

    SUM(fis.SalesAmount) AS Revenue,

    SUM(fis.TotalProductCost) AS TotalCost,

    SUM(fis.SalesAmount - fis.TotalProductCost) AS GrossProfit,

    SUM(fis.SalesAmount - fis.TotalProductCost)
        * 100.0
        / NULLIF(SUM(fis.SalesAmount), 0)
        AS GrossProfitMarginPct

FROM dbo.FactInternetSales AS fis

INNER JOIN dbo.DimProduct AS dp
    ON fis.ProductKey = dp.ProductKey

LEFT JOIN dbo.DimProductSubcategory AS dps
    ON dp.ProductSubcategoryKey = dps.ProductSubcategoryKey

LEFT JOIN dbo.DimProductCategory AS dpc
    ON dps.ProductCategoryKey = dpc.ProductCategoryKey

GROUP BY
    dp.ProductKey,
    dp.EnglishProductName,
    dps.EnglishProductSubcategoryName,
    dpc.EnglishProductCategoryName;
GO



-- Task 3 - First Stored Procedure

Create or Alter Procedure dbo.usp_SalesByYear

@SalesYear INT As

Begin 

Select Year(OrderDate) as SalesYear,
Count (Distinct SalesOrderNumber) as Orders,
SUM(OrderQuantity) as UnitSold,
Round(Sum(SalesAmount),2) as Revenue,
Round(SUM(GrossProfit),2) as GrossProfit
from dbo.vw_InternetSalesAnalysis

where YEAR(OrderDate) = @SalesYear

Group By YEAR(OrderDate);
END;

Go

Exec dbo.usp_SalesByYear
	@SalesYear = 2011;

-- Task 4 - Procedure with Optional Parameter

Create or ALter Procedure dbo.usp_CountryPerformance

@Country NVARCHAR(100) = Null

AS
Begin

Select
	Country,
	COUNT(Distinct SalesOrderNumber) as Orders,
	ROUND(SUM(SalesAmount),2) as Revenue,
	ROUND(SUM(GrossProfit),2) as GrossProfit
from dbo.vw_InternetSalesAnalysis

where @Country is null
	  or @Country = Country
Group by Country
Order by Country;

END;
Go

Exec dbo.usp_CountryPerformance;


-- Task 5 - Date Range Stored Procedure

CREATE OR ALTER PROCEDURE dbo.usp_SalesByDateRange

    @StartDate DATE,
    @EndDate DATE

AS
BEGIN

    SELECT
        YEAR(OrderDate) AS SalesYear,
        MONTH(OrderDate) AS SalesMonth,

        COUNT(DISTINCT SalesOrderNumber) AS Orders,

        ROUND(SUM(SalesAmount), 2) AS Revenue,

        ROUND(SUM(GrossProfit), 2) AS GrossProfit

    FROM dbo.vw_InternetSalesAnalysis

    WHERE
        OrderDate >= @StartDate
        AND OrderDate < DATEADD(DAY, 1, @EndDate)

    GROUP BY
        YEAR(OrderDate),
        MONTH(OrderDate)

    ORDER BY
        SalesYear,
        SalesMonth;

END;
GO

EXEC dbo.usp_SalesByDateRange
    @StartDate = '2013-01-01',
    @EndDate = '2013-12-31';


-- Task 6 -- TopN Products Stored Procedure 

CREATE OR ALTER PROCEDURE dbo.usp_TopProducts

    @TopN INT = 10

AS
BEGIN

    IF @TopN <= 0
    BEGIN
        PRINT 'TopN must be greater than 0.';
        RETURN;
    END;

    SELECT TOP (@TopN)

        ProductName,

        ROUND(Revenue, 2) AS Revenue,

        ROUND(GrossProfit, 2) AS GrossProfit,

        ROUND(GrossProfitMarginPct, 2)
            AS GrossProfitMarginPct

    FROM dbo.vw_ProductPerformance

    ORDER BY Revenue DESC;

END;
GO

-- Task 7 - Inspect Views

SELECT
    TABLE_SCHEMA,
    TABLE_NAME

FROM INFORMATION_SCHEMA.VIEWS

WHERE TABLE_SCHEMA = 'dbo'

ORDER BY TABLE_NAME;


-- Task 8 -- Inpect Stored Procedures 

SELECT
    SCHEMA_NAME(schema_id) AS SchemaName,
    name AS ProcedureName,
    create_date,
    modify_date

FROM sys.procedures

WHERE SCHEMA_NAME(schema_id) = 'dbo'

ORDER BY name;