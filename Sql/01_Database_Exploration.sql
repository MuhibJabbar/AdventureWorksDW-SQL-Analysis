-- AdventureWorks Sales Analysis

-- Objective

-- Analyze sales performance, customers, products, and geographical markets using AdventureWorks

-- PHASE 1 — Database Exploration

-- Task 1 — Confirm our database

USE AdventureWorksDW2022;
GO

SELECT DB_NAME() AS CurrentDatabase;

-- DB_NAME() tells us which database our query is currently running against

-- Task 2 — Find the schemas

Select Distinct Table_Schema from INFORMATION_SCHEMA.TABLES;

-- Task 3 — Find all tables

Select TABLE_SCHEMA , TABLE_NAME from INFORMATION_SCHEMA.TABLES
where TABLE_TYPE = 'Base Table'

-- Task 4 — Count the tables by schema

Select count(TABLE_SCHEMA) as Total_Tables from INFORMATION_SCHEMA.TABLES
where TABLE_TYPE = 'Base Table'
Group by TABLE_SCHEMA

-- Task 5 — Explore the Sales schema

Select TABLE_NAME from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA = 'dbo'
and TABLE_TYPE = 'Base Table'

-- IMPORTANT

-- Tables starting with Fact are FactInternatSales and Tables starting with Dim are Dimension Tables
-- So FactInternetSales tells us what happened, while DimProduct tells us what the product actually was






