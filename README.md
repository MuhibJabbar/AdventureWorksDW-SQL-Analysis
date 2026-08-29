# AdventureWorksDW2022 Sales Analytics

## SQL Server | T-SQL | Data Warehouse | Business Intelligence

## 📌 Project Overview

This project is an end-to-end SQL sales analytics project built using the
Microsoft **AdventureWorksDW2022 Data Warehouse**.

The objective of the project is to transform raw transactional data into
meaningful business insights using Microsoft SQL Server and T-SQL.

The analysis focuses on four major business areas:

- Sales performance
- Customer behaviour and value
- Product performance
- Geographic and market performance

The project also demonstrates reusable SQL development through views and
stored procedures, as well as analytical techniques including CTEs,
window functions, ranking, segmentation and time-series analysis.

---

## 🎯 Business Objectives

The project was designed to answer practical business questions such as:

- How much revenue and gross profit does the business generate?
- What is the overall gross profit margin?
- How does sales performance change over time?
- Which months and years perform best?
- Who are the highest-value customers?
- How much revenue comes from repeat customers?
- Which customer segments contribute the most revenue?
- Which products generate the most revenue and profit?
- Which product categories and subcategories perform best?
- Which geographical markets generate the strongest sales?
- How concentrated is revenue among products and customers?
- How can frequently used analytical queries be converted into reusable
  reporting objects?

---

# 🛠️ Tools & Technologies

| Technology | Usage |
|---|---|
| Microsoft SQL Server | Database platform |
| SQL Server Management Studio (SSMS) | Query development and database exploration |
| T-SQL | Data analysis and reporting |
| AdventureWorksDW2022 | Data warehouse |
| Git | Version control |
| GitHub | Project documentation and portfolio hosting |
| Power BI | Planned dashboard and visualisation layer |

---

# 🗄️ Dataset

The project uses Microsoft's **AdventureWorksDW2022** sample data warehouse.

The analysis primarily focuses on Internet Sales and related dimension
tables.

### Fact Table

`dbo.FactInternetSales`

This table contains Internet sales transactions at the **order-line level**
and provides measures such as:

- Sales amount
- Product cost
- Order quantity
- Customer
- Product
- Order date
- Sales territory

### Dimension Tables

The main dimensions used include:

- `dbo.DimCustomer`
- `dbo.DimProduct`
- `dbo.DimProductSubcategory`
- `dbo.DimProductCategory`
- `dbo.DimDate`
- `dbo.DimGeography`
- `dbo.DimSalesTerritory`
- `dbo.DimPromotion`
- `dbo.DimCurrency`

---

# ⭐ Data Model

AdventureWorksDW2022 follows a dimensional data warehouse structure.

The central sales fact table is connected to descriptive dimensions,
allowing transactional measures to be analysed from multiple business
perspectives.

```text
                         DimDate
                            |
                            |
DimCustomer -------- FactInternetSales -------- DimProduct
     |                       |                       |
     |                       |                       |
DimGeography          DimSalesTerritory       DimProductSubcategory
                                                    |
                                                    |
                                             DimProductCategory
```

This structure makes it possible to analyse sales by:

- Customer
- Product
- Category
- Geography
- Territory
- Date
- Promotion

---

# 📂 Project Structure

## 01 — Database Exploration

The first stage focused on understanding the structure of the
AdventureWorksDW2022 data warehouse before performing analysis.

### Analysis performed

- Confirmed active database
- Explored database schemas
- Identified available tables
- Counted tables by schema
- Identified fact and dimension tables
- Reviewed the overall warehouse structure

### Skills demonstrated

`SELECT`, system metadata, `INFORMATION_SCHEMA`, database exploration

---

## 02 — Data Profiling

The Internet Sales fact table was profiled to understand the size,
quality and coverage of the dataset.

### Analysis performed

- Sales line count
- Unique order count
- Date range
- Total revenue
- Product cost
- Gross profit
- Units sold
- Customer count
- Products sold
- NULL checks
- Invalid value checks

### Why this matters

Data profiling helps identify quality issues and understand the dataset
before business conclusions are produced.

---

## 03 — Relationships & JOINs

Fact and dimension tables were connected to create business-friendly
analytical datasets.

### Relationships analysed

- Sales → Customer
- Sales → Product
- Product → Subcategory → Category
- Customer → Geography
- Sales → Sales Territory

### Data validation

JOIN results were validated using:

- Row-count comparisons
- Missing customer checks
- Missing product checks
- Key relationship validation

### Skills demonstrated

`INNER JOIN`, `LEFT JOIN`, multi-table JOINs, primary/foreign key
relationships and data validation

---

## 04 — Sales Performance Analysis

Sales performance was analysed from overall KPIs through detailed
time-series trends.

### KPIs analysed

- Total revenue
- Total product cost
- Gross profit
- Gross profit margin
- Total orders
- Units sold
- Average order value

### Time analysis

- Revenue by year
- Revenue by month
- Quarterly performance
- Best-performing months
- Lowest-performing months
- Year-over-year revenue growth
- Month-over-month revenue growth
- Cumulative revenue

### Advanced SQL techniques

- CTEs
- `LAG()`
- Window functions
- Running totals
- Date functions
- `NULLIF()`
- Aggregations

### Analytical consideration

Average Order Value was calculated as:

```text
Total Revenue / Distinct Orders
```

rather than using `AVG(SalesAmount)`, because each row in
`FactInternetSales` represents an order line rather than an entire order.

---

## 05 — Customer Analysis

Customer purchasing behaviour was analysed to understand customer value,
loyalty and segmentation.

### Analysis performed

- Customer-level revenue
- Top customers by revenue
- Average revenue per customer
- Orders per customer
- One-time vs repeat customers
- Repeat customer rate
- Customer revenue ranking
- Customer value quartiles
- Revenue contribution by customer quartile
- Income-group analysis
- Occupation analysis
- Customer geography
- Customer recency

### Customer segmentation

Customers were divided into value quartiles using:

```sql
NTILE(4)
```

This provides a simple method of identifying high-value and lower-value
customer groups.

### Customer recency

Customer recency was calculated relative to the **latest transaction date
in the dataset**, rather than the current system date.

This is important because AdventureWorks is historical data.

### Skills demonstrated

`CASE`, CTEs, `RANK()`, `NTILE()`, `DATEDIFF()`, JOINs, aggregations and
window functions

---

## 06 — Product Analysis

Product performance was analysed across products, subcategories and
categories.

### Analysis performed

- Products sold
- Product-level revenue
- Top products by revenue
- Top products by units sold
- Most profitable products
- Product gross profit margins
- Category performance
- Subcategory performance
- Product ranking within categories
- Low-performing products
- Category revenue contribution
- Product revenue concentration

### Product ranking

Products were ranked within their respective categories using:

```sql
RANK() OVER (
    PARTITION BY Category
    ORDER BY Revenue DESC
)
```

This allows product performance to be compared fairly within each
business category.

### Skills demonstrated

Multi-table JOINs, CTEs, `RANK()`, `PARTITION BY`, window functions,
aggregations and percentage calculations

---

## 07 — Views & Stored Procedures

Reusable database objects were created to move the project beyond
one-off analytical queries.

### Views

Views were developed to provide reusable analytical datasets for areas
such as:

- Sales analysis
- Product performance
- Customer performance

### Stored Procedures

Parameterized stored procedures were developed for reusable reporting,
including:

- Country-based sales reporting
- Year-based sales reporting
- Date-range reporting
- Dynamic Top-N product analysis
- Dynamic Top-N customer analysis
- Optional parameters
- Input validation

### Why this matters

In a business environment, analysts should not repeatedly rebuild the
same reporting logic.

Views and stored procedures allow common analysis to be reused,
standardised and maintained more efficiently.

### Skills demonstrated

- `CREATE OR ALTER VIEW`
- Stored procedures
- Parameters
- `IF`
- `RETURN`
- Date filtering
- Aggregations
- Reusable reporting logic

---

# 📊 Key Analytical Insights

The project demonstrates several important analytical findings and
business concepts.

### 1. Revenue and profitability should be analysed together

High sales revenue does not automatically mean high profitability.

The project therefore evaluates:

- Revenue
- Product cost
- Gross profit
- Gross profit margin

This provides a more complete picture of business performance.

### 2. Customer value is not evenly distributed

Customer-level analysis and quartile segmentation demonstrate how
revenue contribution can be concentrated among higher-value customers.

This type of analysis can support:

- Customer retention strategies
- Loyalty programmes
- Targeted marketing
- Customer prioritisation

### 3. Product performance requires multiple measures

Products were evaluated using revenue, units sold, gross profit and
profit margin.

A product that generates high revenue may not necessarily have the
highest margin, while a lower-volume product may still be strategically
valuable because of profitability.

### 4. Category-level analysis provides strategic context

Individual product performance was connected to product subcategories
and categories.

This enables management to understand whether performance is driven by
individual products or broader product groups.

### 5. Repeat customers are an important business segment

Customers were separated into one-time and repeat purchasers.

This allows the business to assess customer retention and determine how
much purchasing activity comes from customers who return.

### 6. Time-series analysis reveals trends hidden by overall totals

Yearly, quarterly and monthly analysis was used alongside YoY and MoM
growth calculations.

This helps distinguish long-term growth from short-term fluctuations.

### 7. Geographic analysis can support market-level decision making

Customer geography and sales territory information can be combined with
sales measures to understand how performance differs across markets.

This can support decisions involving:

- Marketing investment
- Regional targeting
- Market expansion
- Sales planning

---

# 💡 Business Recommendations

Based on the analytical framework developed in this project, a business
could use the results to:

1. Prioritise high-value and repeat customers for retention campaigns.
2. Monitor both revenue and gross profit margin when evaluating product
   performance.
3. Investigate declining periods identified through MoM and YoY analysis.
4. Focus marketing activity on customer segments with stronger revenue
   contribution.
5. Review weak products before making pricing, promotion or
   discontinuation decisions.
6. Use category and subcategory performance for broader product strategy.
7. Use reusable SQL views and stored procedures to standardise recurring
   management reporting.

---

# 🧠 SQL Skills Demonstrated

This project demonstrates practical use of:

### Core SQL

- `SELECT`
- `WHERE`
- `ORDER BY`
- `GROUP BY`
- `HAVING`
- `CASE`
- `DISTINCT`
- Aggregate functions

### Data Integration

- `INNER JOIN`
- `LEFT JOIN`
- Multi-table JOINs
- Fact and dimension relationships

### Advanced SQL

- Common Table Expressions (CTEs)
- Subqueries
- Window functions
- `LAG()`
- `RANK()`
- `NTILE()`
- `PARTITION BY`
- Running totals
- Percentage calculations

### Date Analysis

- `YEAR()`
- `MONTH()`
- `DATEDIFF()`
- Date-range filtering
- YoY analysis
- MoM analysis

### SQL Development

- Views
- Stored procedures
- Parameters
- Conditional logic
- Input validation
- Reusable reporting queries

---

# 🔍 Analytical & Data Quality Practices

The project does not focus only on writing queries.

Several analytical checks were incorporated to improve reliability,
including:

- NULL-value checks
- Invalid-value checks
- JOIN row-count validation
- Missing-key checks
- Correct aggregation grain
- Distinct order counting
- Division-by-zero protection with `NULLIF()`
- Historical-date-aware customer recency calculations

These checks help reduce the risk of producing misleading business
metrics.

---

# 📁 Repository Structure

```text
AdventureWorksDW-SQL-Analysis/
│
├── README.md
│
└── Sql/
    ├── 01_Database_Exploration.sql
    ├── 02_Data_Profiling.sql
    ├── 03_Relationships & JOINs.sql
    ├── 04_Sales_Performance_Analysis.sql
    ├── 05_Customer_Analysis.sql
    ├── 06_Product_Analysis.sql
    └── 07_Views_and_Stored_Procedures.sql
```

---

# 🚀 Project Workflow

```text
Database Exploration
        ↓
Data Profiling
        ↓
Relationship Validation
        ↓
Sales Analysis
        ↓
Customer Analysis
        ↓
Product Analysis
        ↓
Advanced SQL Development
        ↓
Business Insights
        ↓
Power BI Dashboard
```

---

# 📈 Next Step — Power BI

The next stage of this project is to connect the SQL analytical layer to
Power BI and develop an interactive executive sales dashboard.

The dashboard will focus on:

- Revenue
- Gross profit
- Gross profit margin
- Orders
- Average order value
- Sales trends
- Customer segments
- Product performance
- Category performance
- Geographic performance

The objective is to turn the SQL analysis into a complete:

**SQL Server → T-SQL Analytics → Business Insights → Power BI**

portfolio project.

---

# 🎓 Key Learning Outcomes

Through this project I strengthened my ability to:

- Work with a dimensional data warehouse
- Understand fact and dimension tables
- Translate business questions into SQL queries
- Build reusable analytical datasets
- Analyse sales trends and KPIs
- Segment and rank customers
- Evaluate product profitability
- Perform time-series analysis
- Validate analytical results
- Build reusable SQL reporting objects
- Translate technical analysis into business recommendations

---

# ✅ Project Status

### SQL Analysis: Completed

- [x] Database Exploration
- [x] Data Profiling
- [x] Relationships & JOINs
- [x] Sales Performance Analysis
- [x] Customer Analysis
- [x] Product Analysis
- [x] Views & Stored Procedures
- [x] Business Insight Development
- [ ] Power BI Dashboard

---

## 👤 Author

**Muhib Jabbar**

MSc Big Data Technologies  
Data Analytics | SQL | Power BI | Business Intelligence

---

## ⭐ About This Project

This project was developed as part of my data analytics portfolio to
demonstrate practical SQL, data warehouse and business analysis skills.

Rather than focusing only on SQL syntax, the project follows an
analytical workflow:

**Understand the data → Validate the data → Analyse performance →
Identify insights → Build reusable reporting logic → Communicate
business value.**
