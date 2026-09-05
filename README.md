# 📊 AdventureWorks Sales Analytics

### From SQL Tables to Executive Insights | SQL Server + Power BI

An end-to-end **Data Analytics and Business Intelligence portfolio project** built using **SQL Server, T-SQL, Power Query, Power BI and DAX** on Microsoft's AdventureWorksDW2022 data warehouse.

The objective of this project was not simply to create SQL queries or dashboard visuals. It was to build a complete analytical workflow — from understanding the warehouse and validating the data grain to developing reusable SQL logic, designing a Power BI semantic model, creating DAX measures, validating calculations and communicating business insights through interactive dashboards.

---

## 🚀 Project Overview

This project analyses AdventureWorks Internet Sales across:

- Sales performance
- Revenue and profitability
- Products and product categories
- Customers and customer behaviour
- Countries and sales territories
- Monthly and yearly trends
- Month-over-Month performance
- Year-over-Year performance

The complete workflow was:

```text
AdventureWorksDW2022
        ↓
Database Exploration
        ↓
Data Profiling & Validation
        ↓
SQL Business Analysis
        ↓
Views & Stored Procedures
        ↓
Power Query Transformation
        ↓
Power BI Semantic Model
        ↓
DAX Measures
        ↓
DAX Validation
        ↓
Interactive Dashboards
        ↓
Business Insights
```

---

# 🛠️ Technology Stack

| Technology | Purpose |
|---|---|
| Microsoft SQL Server | Database platform |
| SQL Server Management Studio | SQL development and validation |
| T-SQL | Data analysis and reusable reporting logic |
| AdventureWorksDW2022 | Source data warehouse |
| Power Query | Data preparation and transformation |
| Power BI | Semantic modelling and dashboard development |
| DAX | KPI and time-intelligence calculations |
| Git | Version control |
| GitHub | Project documentation and portfolio hosting |

---

# 🎯 Business Questions

The project was designed to answer questions such as:

- How much revenue is being generated?
- How much gross profit is the business producing?
- What is the gross profit margin?
- How many orders and customers are generating that revenue?
- What is the Average Order Value?
- How does performance change month over month?
- How does revenue compare with the previous year?
- Which products generate the most revenue?
- Which product categories dominate sales?
- Which subcategories generate the most gross profit?
- Who are the highest-value customers?
- Which customer groups contribute the most revenue?
- Which countries generate the strongest sales?
- Which sales territories perform best?
- How concentrated is revenue across products and markets?

---

# 🗄️ Data Source

The project uses Microsoft's:

**AdventureWorksDW2022**

The analysis is primarily based on:

`dbo.FactInternetSales`

with supporting dimension tables including:

- `dbo.DimCustomer`
- `dbo.DimProduct`
- `dbo.DimProductSubcategory`
- `dbo.DimProductCategory`
- `dbo.DimDate`
- `dbo.DimGeography`
- `dbo.DimSalesTerritory`

---

# 🔑 Understanding the Data Grain

One of the most important analytical decisions in this project was identifying the grain of:

`FactInternetSales`

Each record represents a:

**Sales Order Line**

rather than an entire sales order.

This affects calculations such as Total Orders and Average Order Value.

For example, Total Orders must use:

```sql
COUNT(DISTINCT SalesOrderNumber)
```

rather than counting rows.

Average Order Value is therefore:

```text
Total Revenue / Distinct Sales Orders
```

and not:

```text
AVG(SalesAmount)
```

Understanding the grain before calculating KPIs prevents misleading business results.

---

# 💻 SQL Analysis

The SQL part of the project was developed as seven progressive analytical stages.

---

## 01 — Database Exploration

The first phase focused on understanding the warehouse before analysing it.

### Work completed

- Confirmed the active database
- Explored available schemas
- Identified fact tables
- Identified dimension tables
- Reviewed database metadata
- Analysed the overall warehouse structure

### Skills

`SELECT`, `INFORMATION_SCHEMA`, system metadata and database exploration

### File

[01_Database_Exploration.sql](Sql/01_Database_Exploration.sql)

---

## 02 — Data Profiling

Before producing business insights, the Internet Sales dataset was profiled.

### Checks included

- Fact-table row count
- Unique sales orders
- Dataset date range
- Total revenue
- Product cost
- Gross profit
- Units sold
- Customer count
- Products sold
- NULL checks
- Invalid-value checks

Data profiling was used to understand both the quality and analytical coverage of the dataset.

### File

[02_Data_Profiling.sql](Sql/02_Data_Profiling.sql)

---

## 03 — Relationships & JOINs

Fact and dimension tables were connected to create business-friendly analytical datasets.

### Relationships explored

```text
FactInternetSales → DimCustomer
FactInternetSales → DimProduct
DimProduct → DimProductSubcategory
DimProductSubcategory → DimProductCategory
DimCustomer → DimGeography
FactInternetSales → DimSalesTerritory
```

### Validation included

- Row-count comparison
- Missing customer checks
- Missing product checks
- Primary/foreign-key validation
- JOIN-result validation

### SQL concepts

- `INNER JOIN`
- `LEFT JOIN`
- Multi-table JOINs
- Fact and dimension relationships

### File

[03_Relationships & JOINs.sql](Sql/03_Relationships%20%26%20JOINs.sql)

---

## 04 — Sales Performance Analysis

The sales analysis moved from overall KPIs into detailed time-series analysis.

### KPIs

- Total Revenue
- Total Product Cost
- Gross Profit
- Gross Profit Margin
- Total Orders
- Units Sold
- Average Order Value

### Time analysis

- Revenue by year
- Revenue by quarter
- Revenue by month
- Best-performing periods
- Lowest-performing periods
- Year-over-Year growth
- Month-over-Month growth
- Running/cumulative revenue

### SQL techniques

- CTEs
- `LAG()`
- Window functions
- Running totals
- Date functions
- Aggregations
- Percentage calculations
- `NULLIF()`

### File

[04_Sales_Performance_Analysis.sql](Sql/04_Sales_Performance_Analysis.sql)

---

## 05 — Customer Analysis

Customer purchasing behaviour was analysed to understand customer value and engagement.

### Analysis included

- Customer-level revenue
- Top customers by revenue
- Average revenue per customer
- Orders per customer
- One-time customers
- Repeat customers
- Repeat-customer rate
- Customer revenue ranking
- Customer-value quartiles
- Revenue contribution by quartile
- Income analysis
- Occupation analysis
- Customer geography
- Customer recency

### Customer segmentation

Customers were divided into value quartiles using:

```sql
NTILE(4)
```

Customer recency was calculated relative to the latest transaction date in the dataset rather than the current system date because AdventureWorks contains historical data.

### SQL concepts

- `CASE`
- CTEs
- `RANK()`
- `NTILE()`
- `DATEDIFF()`
- JOINs
- Aggregations
- Window functions

### File

[05_Customer_Analysis.sql](Sql/05_Customer_Analysis.sql)

---

## 06 — Product Analysis

Product performance was evaluated using multiple business measures rather than revenue alone.

### Analysis included

- Product revenue
- Units sold
- Top products
- Gross profit
- Gross profit margin
- Category performance
- Subcategory performance
- Product ranking within categories
- Low-performing products
- Category revenue contribution
- Product revenue concentration

### Example analytical technique

```sql
RANK() OVER
(
    PARTITION BY Category
    ORDER BY Revenue DESC
)
```

This allows products to be compared within their own business category.

### File

[06_Product_Analysis.sql](Sql/06_Product_Analysis.sql)

---

## 07 — Views & Stored Procedures

The project was extended beyond one-off analytical queries by developing reusable SQL objects.

### Views

Reusable analytical datasets were created for areas such as:

- Sales reporting
- Product performance
- Customer performance

### Stored procedures

Parameterized procedures were developed for:

- Country-based reporting
- Year-based reporting
- Date-range reporting
- Dynamic Top-N product analysis
- Dynamic Top-N customer analysis
- Optional parameters
- Input validation

### Skills

- `CREATE OR ALTER VIEW`
- Stored procedures
- Parameters
- `IF`
- `RETURN`
- Dynamic filtering
- Input validation
- Reusable reporting logic

### File

[07_Views_and_Stored_Procedures.sql](Sql/07_Views_and_Stored_Procedures.sql)

---

# 🔄 Power Query Data Preparation

After completing the SQL analysis, the data was imported into Power BI.

Power Query was used to create a reporting-friendly model.

### FactInternetSales

The fact table was reduced to relevant analytical columns covering:

- Product
- Customer
- Order Date
- Due Date
- Ship Date
- Territory
- Order Number
- Order Quantity
- Unit Price
- Discounts
- Product Cost
- Sales Amount
- Tax
- Freight

Unnecessary source columns were removed and appropriate data types were assigned.

---

## Customer Dimension

`DimCustomer` was prepared with customer demographic and behavioural attributes.

A new customer name field was created by combining:

```text
FirstName
MiddleName
LastName
```

Other fields included:

- Geography
- Birth Date
- Marital Status
- Gender
- Income
- Education
- Occupation
- Children
- Car ownership
- Home ownership
- First purchase date
- Commute distance

---

## Product Dimension

Product modelling was simplified by merging:

```text
DimProduct
      ↓
DimProductSubcategory
      ↓
DimProductCategory
```

into the reporting version of `DimProduct`.

This provided fields such as:

- Product Name
- Category
- Subcategory
- Colour
- Standard Cost
- List Price
- Size
- Product Line
- Model Name

The original Category and Subcategory Power Query tables were retained as helper queries but their report load was disabled.

---

## Geography Dimension

Geographic fields included:

- City
- State/Province
- Country
- Postal Code
- Sales Territory Key

---

## Sales Territory Dimension

Territory analysis included:

- Territory Region
- Territory Country
- Territory Group

---

## Date Dimension

The date table supports:

- Day
- Week
- Month
- Quarter
- Calendar Year
- Calendar Semester
- Fiscal Quarter
- Fiscal Year
- Fiscal Semester

The explicit date dimension is used rather than relying on Power BI's automatic date handling.

---

# ⭐ Power BI Semantic Model

The final reporting model contains six main analytical tables:

```text
DimDate
DimProduct
DimCustomer
DimGeography
DimSalesTerritory
FactInternetSales
```

The central fact table is:

`FactInternetSales`

---

## Model Structure

```text
                       DimDate
                          |
                          |
                          |
DimProduct ------ FactInternetSales ------ DimCustomer
                          |                    |
                          |                    |
                DimSalesTerritory       DimGeography
```

The model uses primarily:

**One-to-Many relationships**

with dimensions on the `1` side and transactional data on the `*` side.

Single-direction filtering is used where appropriate to maintain predictable filter behaviour.

---

# 📅 Role-Playing Date Relationships

`FactInternetSales` contains several date keys:

- OrderDateKey
- DueDateKey
- ShipDateKey

All three connect conceptually to the same `DimDate` table.

The model therefore uses:

### Active relationship

```text
DimDate[DateKey]
       ↓
FactInternetSales[OrderDateKey]
```

### Inactive relationships

```text
DimDate[DateKey]
       ↓
FactInternetSales[DueDateKey]
```

```text
DimDate[DateKey]
       ↓
FactInternetSales[ShipDateKey]
```

**Order Date** remains active because it represents the main business date for sales-performance analysis.

The inactive relationships remain available for future calculations using DAX techniques such as `USERELATIONSHIP()`.

---

# 🧮 DAX Measures

A dedicated Measures table was created to centralise business logic.

---

## Total Revenue

```DAX
Total Revenue =
SUM(
    FactInternetSales[SalesAmount]
)
```

---

## Total Cost

```DAX
Total Cost =
SUM(
    FactInternetSales[TotalProductCost]
)
```

---

## Gross Profit

```DAX
Gross Profit =
[Total Revenue] - [Total Cost]
```

---

## Gross Profit Margin %

```DAX
Gross Profit Margin % =
DIVIDE(
    [Gross Profit],
    [Total Revenue],
    0
)
```

---

## Total Orders

```DAX
Total Orders =
DISTINCTCOUNT(
    FactInternetSales[SalesOrderNumber]
)
```

---

## Units Sold

```DAX
Units Sold =
SUM(
    FactInternetSales[OrderQuantity]
)
```

---

## Total Customers

```DAX
Total Customers =
DISTINCTCOUNT(
    FactInternetSales[CustomerKey]
)
```

---

## Average Order Value

```DAX
AOV =
DIVIDE(
    [Total Revenue],
    [Total Orders],
    0
)
```

---

## Revenue Per Customer

```DAX
Revenue Per Customer =
DIVIDE(
    [Total Revenue],
    [Total Customers],
    0
)
```

---

# ⏱️ Time Intelligence

The semantic model also contains time-intelligence calculations.

---

## Revenue Previous Year

```DAX
Revenue Previous Year =
CALCULATE(
    [Total Revenue],
    SAMEPERIODLASTYEAR(
        DimDate[Date]
    )
)
```

---

## YoY Revenue Growth

```DAX
YoY Revenue Growth =
[Total Revenue] - [Revenue Previous Year]
```

---

## YoY Growth %

```DAX
YoY Growth % =
DIVIDE(
    [Total Revenue] - [Revenue Previous Year],
    [Revenue Previous Year]
)
```

---

## Revenue YTD

```DAX
Revenue YTD =
TOTALYTD(
    [Total Revenue],
    DimDate[Date]
)
```

---

## Revenue Previous Month

```DAX
Revenue Previous Month =
CALCULATE(
    [Total Revenue],
    DATEADD(
        DimDate[Date],
        -1,
        MONTH
    )
)
```

---

## MoM Growth %

```DAX
MoM Growth % =
DIVIDE(
    [Total Revenue] - [Revenue Previous Month],
    [Revenue Previous Month]
)
```

---

# ✅ DAX Validation

A dedicated **DAX Validation** report page was built before finalising the executive dashboards.

This page validates:

- Total Revenue
- Gross Profit
- Total Orders
- Total Customers
- Monthly Revenue
- Previous Month Revenue
- MoM Growth
- Revenue YTD
- Previous Year Revenue
- YoY Growth

This was an important part of the project because a successful visual does not automatically mean the underlying calculation is correct.

---

# 📊 Power BI Dashboard

The completed Power BI report is included in this repository.

### Power BI File

👉 **[AdventureWorks_Sales_Analytics.pbix](PowerBi/AdventureWorks_Sales_Analytics.pbix)**

The report contains four analytical pages.

---

# 1️⃣ Executive Overview

The Executive Overview was designed for management-level monitoring.

### KPI Cards

- Total Revenue
- Gross Profit
- Gross Profit Margin
- Total Orders
- Average Order Value

### Visuals

- Monthly Revenue Trend vs Previous Year
- Revenue by Product Category
- Revenue by Country

### Interactive Filters

- Year
- Product Category
- Country

---

## 2013 Executive View

The 2013 view reports approximately:

| KPI | Result |
|---|---:|
| Total Revenue | **£16.35M** |
| Gross Profit | **£6.77M** |
| Gross Profit Margin | **41.37%** |
| Total Orders | **21K+** |
| Average Order Value | **£768.08** |

2013 was used as the main portfolio reporting view because it provides a much more representative full-year analysis than the incomplete periods at the beginning and end of the historical dataset.

---

# 2️⃣ Product & Customer Analysis

This report page answers:

> **What and who is driving revenue?**

### Product analysis

- Product revenue ranking
- Top-performing products
- Gross profit by product subcategory
- Product/category performance

### Customer analysis

- Customer revenue ranking
- Revenue by occupation
- Revenue by education
- Orders by customer
- Customer Average Order Value

This page enables performance to be analysed beyond company-level totals.

---

# 3️⃣ Geography & Sales Analysis

This page answers:

> **Where is revenue being generated?**

### Analysis includes

- Revenue by Country
- Revenue by Territory Group
- Geographic monthly trends
- Country-level Revenue
- Country-level Gross Profit
- Customer Counts
- Average Order Value

### Filters

- Year
- Territory Group
- Country

The 2013 dashboard highlights the:

**United States** and **Australia**

among the largest revenue markets.

---

# 4️⃣ DAX Validation

The final report also retains the technical DAX validation page.

This demonstrates that business KPIs and time-intelligence calculations were validated before they were presented through management dashboards.

---

# 📈 Key Analytical Insights

## 1. Bikes dominate product revenue

The Bikes category generates the largest share of product-category revenue.

This demonstrates significant revenue concentration within the core bicycle product range.

---

## 2. Revenue is geographically concentrated

The geographic dashboard demonstrates that revenue contribution varies significantly across markets.

The United States and Australia are among the strongest markets in the 2013 reporting view.

---

## 3. Revenue alone does not measure product success

Product performance was evaluated using:

- Revenue
- Product Cost
- Gross Profit
- Gross Profit Margin
- Units Sold

A high-revenue product may not necessarily provide the strongest profitability.

---

## 4. Customer contribution varies substantially

Customer-level analysis shows that customers differ significantly in:

- Revenue contribution
- Order frequency
- Average Order Value
- Demographic characteristics

This type of analysis can support customer segmentation and retention strategies.

---

## 5. Time trends provide context behind headline KPIs

Overall sales totals can hide important movements.

The project therefore includes:

- Monthly trends
- Previous-month comparisons
- MoM Growth
- Previous-year comparisons
- YoY Growth
- YTD Revenue

---

## 6. Correct calculations still require correct interpretation

A technically correct YoY formula can produce misleading business conclusions when one comparison period contains incomplete data.

This project therefore separates:

**Calculation correctness**

from:

**Business interpretation**

and uses the more representative 2013 period for the primary executive dashboard.

---

# 💡 Potential Business Applications

The completed analytical solution could support:

- Executive sales monitoring
- Product portfolio analysis
- Customer targeting
- Customer retention planning
- Geographic market evaluation
- Regional sales planning
- Profitability analysis
- Trend monitoring
- Monthly management reporting
- Product prioritisation
- Market expansion analysis

---

# 🔍 Data Quality & Validation Practices

The project includes analytical controls such as:

- NULL-value checks
- Invalid-value checks
- Missing-key checks
- Fact-table grain validation
- JOIN row-count validation
- Primary/foreign-key checks
- Distinct-order counting
- Division-by-zero protection
- Historical-date-aware customer recency
- Relationship validation
- Dedicated DAX validation
- Partial-period awareness

These checks were included to reduce the risk of producing visually attractive but analytically incorrect dashboards.

---

# 🧠 SQL Skills Demonstrated

## Core SQL

```text
SELECT
WHERE
ORDER BY
GROUP BY
HAVING
CASE
DISTINCT
Aggregate Functions
```

## Data Integration

```text
INNER JOIN
LEFT JOIN
Multi-table JOINs
Primary / Foreign Keys
Fact / Dimension Relationships
```

## Analytical SQL

```text
CTEs
Subqueries
LAG()
RANK()
NTILE()
PARTITION BY
Window Functions
Running Totals
Percentage Calculations
```

## Date Analysis

```text
YEAR()
MONTH()
DATEDIFF()
Date Range Filtering
MoM Analysis
YoY Analysis
```

## SQL Development

```text
Views
Stored Procedures
Parameters
Conditional Logic
Input Validation
Reusable Reporting Logic
```

---

# 📊 Power BI Skills Demonstrated

The Power BI portion demonstrates practical use of:

- Power Query
- Data profiling
- Data transformation
- Data types
- Query merging
- Semantic modelling
- Star-schema principles
- One-to-many relationships
- Active relationships
- Inactive relationships
- Date modelling
- Measures
- Measure branching
- Filter context
- `CALCULATE`
- `DIVIDE`
- `SAMEPERIODLASTYEAR`
- `DATEADD`
- `TOTALYTD`
- Interactive slicers
- KPI cards
- Line charts
- Bar charts
- Tables
- Time-intelligence analysis
- Dashboard validation
- Executive dashboard design

---

# 📁 Repository Structure

```text
AdventureWorksDW-SQL-Analysis/
│
├── README.md
├── LICENSE
│
├── Sql/
│   ├── 01_Database_Exploration.sql
│   ├── 02_Data_Profiling.sql
│   ├── 03_Relationships & JOINs.sql
│   ├── 04_Sales_Performance_Analysis.sql
│   ├── 05_Customer_Analysis.sql
│   ├── 06_Product_Analysis.sql
│   └── 07_Views_and_Stored_Procedures.sql
│
└── PowerBi/
    └── AdventureWorks_Sales_Analytics.pbix
```

---

# 🔄 Complete Project Workflow

```text
                    AdventureWorksDW2022
                             │
                             ▼
                  Database Exploration
                             │
                             ▼
                      Data Profiling
                             │
                             ▼
               Relationship / JOIN Validation
                             │
                             ▼
             Sales • Customer • Product Analysis
                             │
                             ▼
                 Views & Stored Procedures
                             │
                             ▼
                   Power Query Preparation
                             │
                             ▼
                 Power BI Semantic Model
                             │
                             ▼
                     DAX Measures
                             │
                             ▼
                    DAX Validation
                             │
                             ▼
      ┌──────────────────────┼─────────────────────┐
      ▼                      ▼                     ▼
 Executive Overview   Product & Customer   Geography & Sales
      │                      │                     │
      └──────────────────────┼─────────────────────┘
                             ▼
                     Business Insights
```

---

# 🎓 Key Learning Outcomes

Through this project I strengthened my ability to:

- Work with a dimensional data warehouse
- Understand fact and dimension tables
- Determine the correct analytical grain
- Translate business requirements into SQL
- Validate data before analysis
- Develop reusable analytical SQL
- Create views and stored procedures
- Prepare data using Power Query
- Flatten unnecessary snowflake structures for reporting
- Design Power BI relationships
- Work with role-playing date dimensions
- Understand active and inactive relationships
- Build reusable DAX measures
- Understand filter context
- Implement time-intelligence calculations
- Validate DAX independently
- Design executive dashboards
- Analyse products, customers and geographic markets
- Convert technical analysis into business insights

---

# 🏁 Project Status

## ✅ COMPLETED

| Phase | Status |
|---|---|
| Database Exploration | ✅ Completed |
| Data Profiling | ✅ Completed |
| Relationship Validation | ✅ Completed |
| Sales Performance Analysis | ✅ Completed |
| Customer Analysis | ✅ Completed |
| Product Analysis | ✅ Completed |
| Views & Stored Procedures | ✅ Completed |
| Power Query Transformation | ✅ Completed |
| Power BI Semantic Model | ✅ Completed |
| DAX Measures | ✅ Completed |
| DAX Validation | ✅ Completed |
| Executive Overview | ✅ Completed |
| Product & Customer Analysis | ✅ Completed |
| Geography & Sales Analysis | ✅ Completed |
| Business Insights | ✅ Completed |
| GitHub Documentation | ✅ Completed |

---

# 👤 Author

## Muhib Jabbar

**MSc Big Data Technologies**

Data Analytics | SQL Server | Power BI | DAX | Business Intelligence

LinkedIn:  
[linkedin.com/in/muhibjabbar](https://www.linkedin.com/in/muhibjabbar/)

---

# ⭐ Project Purpose

This project was developed as part of my Data Analytics portfolio to demonstrate the ability to work across the complete analytics lifecycle.

The focus was not simply:

> **Can I write SQL?**

or:

> **Can I create a Power BI dashboard?**

The goal was to demonstrate the complete analytical process:

```text
Understand the Business
        ↓
Understand the Data
        ↓
Validate the Data
        ↓
Analyse Performance
        ↓
Build Reusable Logic
        ↓
Design the Semantic Model
        ↓
Create Business Measures
        ↓
Validate the Measures
        ↓
Visualise the Results
        ↓
Communicate Business Insights
```

---

## 📌 Final Result

A complete:

**SQL Server → T-SQL → Power Query → Power BI → DAX → Business Intelligence**

Portfolio project demonstrating both the technical and analytical skills required for a **Data Analyst / BI Analyst** role.

---

### ⭐ If you found this project useful, feel free to explore the SQL scripts and Power BI report.
