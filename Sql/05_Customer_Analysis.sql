/*

05 - CUSTOMER ANALYSIS
AdventureWorksDW2022 Sales Analytics


OBJECTIVE:
Analyze customer purchasing behavior, value and
demographic characteristics to identify high-value
customer segments and retention opportunities.

BUSINESS QUESTIONS:
1. How many customers have purchased?
2. Who are the highest-value customers?
3. What is customer lifetime value?
4. How many orders does each customer place?
5. Who are our repeat customers?
6. What percentage of customers make repeat purchases?
7. Which customers have not purchased recently?
8. Which income groups generate the most revenue?
9. Which occupations generate the most revenue?
10. How can customers be segmented by value?

*/

USE AdventureWorksDW2022;

-- Task 1 Total Customers

Select count (distinct CustomerKey) as Total_Customer from dbo.FactInternetSales;

-- Task 2 Customer Level Sales and top 10 customers by highest revenue
select * from dbo.FactInternetSales

Select Top 10
	dc.CustomerKey,
	CONCAT(dc.FirstName, ' ' , dc.LastName) as Customer_Name,
	Count(distinct SalesOrderNumber) as Total_orders,
	Sum(fis.OrderQuantity) as Unit_Purchased,
	Round(Sum(fis.SalesAmount),2) as Revenue
from dbo.FactInternetSales as fis

inner join dbo.DimCustomer as dc
on fis.CustomerKey = dc.CustomerKey

Group by dc.CustomerKey, dc.FirstName, dc.LastName
Order by Revenue desc

-- Task 3 Average revenue per customer

select
	round(sum(SalesAmount)/nullif (count (distinct CustomerKey),0),2) as AvgRevPerCus
from dbo.FactInternetSales

-- Task 4 Orders Per Customer
Select
	concat(dc.FirstName,' ' , dc.LastName) as Customer_Name,
	fis.CustomerKey,
	count(distinct SalesOrderNumber) as Total_Orders
from dbo.FactInternetSales as fis

inner join DimCustomer as dc
on fis.CustomerKey = dc.CustomerKey

group by fis.CustomerKey,dc.FirstName,dc.LastName
order by Total_Orders

-- Task 5 New vs Repeat Customer

With CustomersOrders AS (
	Select
		CustomerKey,
		count (distinct SalesOrderNumber) as Total_orders
	from dbo.FactInternetSales
	group by CustomerKey
)

Select
	case 
		when Total_orders = 1 then 'New Customer'
		else 'Repeat Customer'
	end as Customer_Type,

	Count(*) as NumofCustoemrs
from CustomersOrders

Group by 
	case 
		when Total_orders = 1 then 'New Customer'
		else 'Repeat Customer'
	end;

--Task 6 Repeat Customer Rate 

with CustomersOrders As (
	select
		CustomerKey,
		count(distinct SalesOrderNumber) as Total_Orders
	from dbo.FactInternetSales
	group by CustomerKey
)

select count(*) as TotalCustomers,
	sum (case
		when Total_Orders >1 then 1
		else 0
	end) as RepeatCustomer,
	Round(
		100 * Sum (
		case when Total_Orders > 1 then 1 
		else 0
		end
		)/NUllif(count(*),0),2
	) as RepCusPct
from CustomersOrders;

-- Task 7 Rank Customer by their spending and their revenue percentage

with CustomerSales AS (
	select
		CustomerKey,
		round (sum(SalesAmount),2) as revenue
	from dbo.FactInternetSales as fis
	group by CustomerKey
)

select
	CustomerKey,
	revenue,
	rank() over( order by revenue desc) as CustomerRank
from CustomerSales;

-- Task 7 Customer revenue Segmentation

with CustomerSales AS (
	Select
		CustomerKey,
		Round(SUM(SalesAmount),2) as Revenue
	from dbo.FactInternetSales
	Group by CustomerKey
),

CustomerSegmentation AS (
	Select
		CustomerKey,
		Revenue,
		Ntile(4) over(
		order by revenue desc
		) as ValueQuartile
	from CustomerSales
)

Select
	Case ValueQuartile
		When 1 then 'High Value'
		When 2 then 'Upper Mid Value'
		When 3 then 'Lower Mid Value'
		When 4 then 'Low Value'
	End as CustomerSegments,
	Count(*) as Customers,
	Round(Sum(Revenue),2) as Revenue,
	Round(sum(Revenue) * 100/sum(sum(Revenue)) over(),2) revcuspct
from CustomerSegmentation

Group by ValueQuartile
Order By ValueQuartile

-- Task 8 Customer Income Analysis

Select
	case 
		when dc.YearlyIncome < 40000 then 'Under 40k'
		when dc.YearlyIncome < 60000 then '40k - 60k'
		when dc.YearlyIncome < 80000 then '60k - 80k'
		when dc.YearlyIncome < 100000 then '80k - 100k'
		else '100k+'
	end AS IncomeGroup,
	Count(Distinct fis.CustomerKey) as Customers,
	Count(Distinct fis.SalesOrderNumber) as Orders,
	Round(sum(SalesAmount),2) as Revenue
from dbo.FactInternetSales as fis

inner join DimCustomer as dc
on fis.CustomerKey = dc.CustomerKey

Group by case 
		when dc.YearlyIncome < 40000 then 'Under 40k'
		when dc.YearlyIncome < 60000 then '40k - 60k'
		when dc.YearlyIncome < 80000 then '60k - 80k'
		when dc.YearlyIncome < 100000 then '80k - 100k'
		else '100k+'
	end
Order by Revenue desc;

-- Task 9 Customer Occupation Analysis by Country Region

Select 
	dg.EnglishCountryRegionName,
	dc.EnglishOccupation,
	count(distinct fis.CustomerKey) as Customers,
	count(distinct fis.SalesOrderNumber) as Orders,
	Round(Sum(SalesAmount),2) as Revenue,
	Round(Sum(fis.SalesAmount)/nullif(count(distinct fis.CustomerKey),0),2) as RevenuePerCustomer
from dbo.FactInternetSales as fis

inner join DimCustomer as dc
on fis.CustomerKey = dc.CustomerKey

INNER JOIN dbo.DimGeography AS dg
    ON dc.GeographyKey = dg.GeographyKey

Group by dc.EnglishOccupation , dg.EnglishCountryRegionName
Order by Revenue

-- Task 10 Customer Recency 

Select
	CustomerKey,
	MAX(OrderDate) LastPurchaseDate,
	DATEDIFF(
	Day,
	MAX(OrderDate),
	(Select Max(OrderDate) from dbo.factInternetSales)
	) as DaysSinceLastPurchase
from dbo.FactInternetSales as fis
group by CustomerKey
order by DaysSinceLastPurchase
