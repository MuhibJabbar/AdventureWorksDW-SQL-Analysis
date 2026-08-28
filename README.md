# AdventureWorksDW2022 Sales Analytics

## SQL Server | T-SQL | Data Warehouse

## Project Overview

This project analyses the AdventureWorksDW2022 data warehouse using
Microsoft SQL Server and T-SQL.

The objective is to explore sales performance and generate business
insights across customers, products, time periods, and geographical
markets.

## Business Questions

The project aims to answer questions such as:

- How much revenue does the business generate?
- How has revenue changed over time?
- Who are the highest-value customers?
- Which products and categories generate the most revenue?
- What are the major sales trends?
- Which customer segments contribute the most revenue?

## Tools

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- T-SQL
- Git & GitHub

## Database

AdventureWorksDW2022

The project primarily uses the following tables:

- `dbo.FactInternetSales`
- `dbo.DimCustomer`
- `dbo.DimProduct`
- `dbo.DimProductSubcategory`
- `dbo.DimProductCategory`
- `dbo.DimDate`
- `dbo.DimPromotion`

## Project Structure

### 01 — Database Exploration

Initial exploration of the AdventureWorksDW2022 data warehouse,
including schemas, tables, and the overall warehouse structure.

### 02 — Data Profiling

Initial profiling of the Internet Sales dataset, including:

- Sales line count
- Unique order count
- Date range
- Revenue
- Product costs
- Gross profit
- Units sold
- Customer count
- Products sold
- NULL checks
- Invalid value checks

### 03 — Relationships & JOINs

- Customer JOIN
- Product JOIN
- Product → Subcategory → Category JOIN
- Customer → Geography JOIN
- Sales Territory JOIN
- Full analytical dataset
- Join row-count validation
- Missing customer/product checks

### 04 — Sales Performance Analysis

Analysed overall business performance and sales trends using T-SQL.

Key analysis includes:

- Total revenue and gross profit
- Gross profit margin
- Total orders and units sold
- Average order value
- Yearly and monthly revenue trends
- Quarterly sales performance
- Best and worst performing months
- Year-over-year (YoY) revenue growth
- Month-over-month (MoM) growth
- Cumulative revenue using running totals

**SQL techniques:** Aggregations, `GROUP BY`, date functions, CTEs, `LAG()`, window functions, `NULLIF()`, and running totals.

### 05 — Customer Analysis

Analyzed customer purchasing behavior and value using T-SQL.

Key analysis includes:

- Top customers by revenue
- Customer lifetime value
- Repeat customer rate
- Customer ranking
- Customer value segmentation
- Revenue by income group
- Revenue by occupation
- Customer geography
- Customer recency

**SQL techniques:** JOINs, CTEs, CASE, RANK(), NTILE(), DATEDIFF(), aggregation and window functions.

### 06 — Product Analysis

Analyzed product performance to identify the strongest and weakest
products, categories, and subcategories.

Key analysis includes:

- Top products by revenue
- Top products by units sold
- Most profitable products
- Product gross profit margins
- Category and subcategory performance
- Product ranking within categories
- Low-performing products
- Category revenue contribution

**SQL techniques:** Multi-table JOINs, CTEs, RANK(), PARTITION BY,
window functions and aggregations.

## SQL Skills Demonstrated

As the project progresses, it will demonstrate:

- SELECT
- WHERE
- GROUP BY
- HAVING
- CASE
- Aggregate functions
- JOINs
- Subqueries
- CTEs
- Window functions
- Date functions
- Views
- Stored procedures
- Query optimization

## Project Status

🚧 Work in Progress

Completed:

- [x] Database Exploration
- [x] Data Profiling
- [x] Relationships & JOINs
- [x] Sales Analysis
- [x] Customer Analysis
- [x] Product Analysis
- [ ] Advanced T-SQL
- [ ] Views & Stored Procedures
- [ ] Performance Optimization
- [ ] Final Business Insights
