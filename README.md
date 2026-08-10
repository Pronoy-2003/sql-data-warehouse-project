# AdventureWorks SQL Data Warehouse & Business Intelligence Project

Welcome to the **AdventureWorks SQL Data Warehouse & Business Intelligence Project** repository! 🚀

This project demonstrates a complete end-to-end data warehousing and
business intelligence solution, starting from the AdventureWorks2025
operational database and progressing through data engineering, data
transformation, analytical modeling, exploratory data analysis, and
interactive Power BI dashboards.

The project follows industry-oriented practices for building a SQL Server
Data Warehouse using **Bronze, Silver, and Gold layers**, followed by
business analysis and reporting.

---

## 🏗️ Data Architecture

The data architecture for this project follows Medallion Architecture
**Bronze**, **Silver**, and **Gold** layers:
![Data Architecture](docs/data_warehouse_architecture.png)

1. **Bronze Layer**: Stores raw data as-it-is from the source systems. Data is ingested from AdventureWorks2025 Database into SQL Server Database.
2. **Silver Layer**: This layer includes data cleansing, standardization, and normalization processes to prepare data for analysis.
3. **Gold Layer**: Houses business-ready data modeled into a star schema required for reporting and analytics.


---

## 📖 Project Overview

This project involves:

1. **Data Architecture**: Designing a modern SQL Server Data Warehouse using
   Bronze, Silver, and Gold layers.

2. **Data Engineering**: Loading and transforming data from the
   AdventureWorks2025 OLTP database.

3. **ETL / ELT Pipelines**: Extracting, loading, cleaning, integrating, and
   transforming data across the warehouse layers.

4. **Data Modeling**: Designing business-oriented entities and a Gold-layer
   star schema consisting of dimension and fact views.

5. **Data Quality & Testing**: Performing data validation and testing across
   the Silver and Gold layers.

6. **Exploratory Data Analysis**: Using SQL to analyze Sales, Customer,
   Product & Inventory, Procurement, and HR business domains.

7. **Business Intelligence**: Developing an interactive Power BI report with
   multiple analytical dashboards.

8. **Business Insights**: Translating analytical findings into actionable
   business recommendations.

🎯 This repository demonstrates practical skills in:

- SQL Development
- SQL Server
- Data Warehousing
- Data Engineering
- ETL / ELT
- Medallion Architecture
- Data Cleaning
- Data Transformation
- Data Integration
- Data Modeling
- Dimensional Modeling
- Star Schema
- Data Quality Testing
- Exploratory Data Analysis
- DAX
- Power BI
- Business Intelligence
- Data Visualization
- Business Analysis
- Git & GitHub

---

## 🎯 Business Problem

The AdventureWorks2025 OLTP database contains operational data distributed
across multiple normalized tables.

Although the OLTP database is suitable for transactional operations, it is
not optimized for analytical reporting and business decision-making.

The objective of this project is to build a centralized analytical data
warehouse that allows business stakeholders to analyze:

### Sales

- Sales performance over time
- Revenue by product and category
- Revenue by sales territory
- Top-performing customers
- Online versus non-online sales

### Customer

- Customer base and segmentation
- Customer distribution by territory
- Customer revenue contribution
- High-value customers
- Customer purchasing behavior

### Product & Inventory

- Product performance
- Product category performance
- Inventory value
- Stock status
- Inventory movement
- Aging inventory

### Procurement

- Procurement spending
- Procurement trends
- Vendor performance
- Supplier delivery efficiency
- Supplier rejection rates
- Preferred vendor usage

### Human Resources

- Workforce distribution
- Department composition
- Employee demographics
- Salary bands
- Hiring trends
- Shift distribution

---

## 📊 Project Scope

The project uses data from the **AdventureWorks2025 OLTP database** and
covers five major business domains:

- Sales
- Customer
- Product & Inventory
- Procurement
- Human Resources

The source database contains data from the following major areas:

### Sales

- Sales Orders
- Customers
- Sales Territories
- Promotions
- Stores

### Person

- Persons
- Addresses
- State/Province
- Countries
- Email Addresses
- Phone Numbers

### Production

- Products
- Product Categories
- Product Subcategories
- Product Inventory
- Locations
- Transaction History
- Product Cost History
- Product List Price History

### Purchasing

- Purchase Orders
- Vendors
- Product Vendors
- Ship Methods

### Human Resources

- Employees
- Departments
- Employee Department History
- Employee Pay History
- Shifts

---

# 🥉 Bronze Layer

The Bronze Layer is the raw data layer of the warehouse.

Data from the AdventureWorks2025 OLTP database is loaded into Bronze tables
with minimal transformation.

### Main Objectives

- Load source data into the warehouse
- Preserve source information
- Maintain source-level structure where appropriate
- Provide a reliable raw layer for downstream processing

The Bronze layer acts as the foundation for the Silver layer.

---

# 🥈 Silver Layer

The Silver Layer is responsible for cleaning, standardizing, integrating,
and transforming the Bronze data.

Related source tables are combined into business-oriented entities to make
the data easier to use for downstream analytics.

### Main Objectives

- Data cleansing
- Data standardization
- Data integration
- Data transformation
- Business entity creation
- Derived business attributes
- Preparation for analytical modeling

## Silver Business Entities

The project creates the following major Silver entities:

| Silver Table | Business Purpose |
|---|---|
| `silver.Customer` | Customer information and customer attributes |
| `silver.Product` | Product, category, and product attributes |
| `silver.Employee` | Employee, department, shift, and HR information |
| `silver.Vendor` | Vendor and supplier information |
| `silver.Location` | Address and geographic information |
| `silver.SalesTerritory` | Sales territory information |
| `silver.Promotion` | Promotion and discount information |
| `silver.Sales` | Integrated sales transactions |
| `silver.Purchase` | Integrated purchasing transactions |
| `silver.Inventory` | Inventory and inventory transaction information |

---

# 🥇 Gold Layer

The Gold Layer contains business-ready analytical views designed for
reporting and business intelligence.

The Gold layer follows a **Star Schema** approach consisting of dimension
and fact views.

## Gold Dimension Views

```text
gold.dim_customer
gold.dim_product
gold.dim_employee
gold.dim_vendor
gold.dim_location
gold.dim_sales_territory
gold.dim_promotion

## Gold Fact Views

```text
gold.fact_sales
gold.fact_purchase
gold.fact_inventory
