# AdventureWorks Business Intelligence Report

## Overview

The **AdventureWorks Business Intelligence Report** is an interactive Power BI
report built on top of the SQL Server Data Warehouse developed for the
AdventureWorks2025 OLTP database.

The report provides a centralized analytical view of key business areas:

- Executive Performance
- Sales
- Customer
- Product & Inventory
- Procurement
- Human Resources

The Power BI report uses the **Gold Layer** of the data warehouse, which
contains business-ready dimension and fact views organized using a
star-schema approach.

---

## Data Source

**Source System:** AdventureWorks2025 OLTP Database

**Data Warehouse:** SQL Server Data Warehouse

**Reporting Tool:** Microsoft Power BI

**Data Model:** Star Schema

### Gold Layer Objects

#### Dimension Views

- `gold.dim_customer`
- `gold.dim_product`
- `gold.dim_employee`
- `gold.dim_vendor`
- `gold.dim_location`
- `gold.dim_sales_territory`
- `gold.dim_promotion`

#### Fact Views

- `gold.fact_sales`
- `gold.fact_purchase`
- `gold.fact_inventory`

---

# Report Structure

The Power BI report contains seven pages:

1. Home
2. Executive Dashboard
3. Sales Dashboard
4. Customer Dashboard
5. Product & Inventory Dashboard
6. Procurement Dashboard
7. HR Dashboard

---

# 1. Home

## Purpose

The Home page acts as the landing page for the report and provides
navigation to each analytical dashboard.

## Navigation

The Home page provides navigation buttons for:

- Executive Dashboard
- Sales Dashboard
- Customer Dashboard
- Product & Inventory Dashboard
- Procurement Dashboard
- HR Dashboard

The report also uses consistent navigation elements across the analytical
pages to allow users to move between business domains.

## Report Branding

The Home page includes:

- AdventureWorks branding
- Business Intelligence Report title
- SQL Server / Power BI context
- Data source information
- Navigation buttons
- Supporting database and user graphics

---

# 2. Executive Dashboard

## Purpose

The Executive Dashboard provides management with a high-level overview of
overall business performance.

## KPI Cards

The dashboard contains six primary KPIs:

- Total Sales
- Total Orders
- Total Customers
- Total Products
- Procurement Cost
- Total Employees

## Visuals

### Sales Trend

**Visual:** Line Chart

**Measure:** Total Sales

**Dimension:** Order Year

**Business Question:**

> How is sales performance changing over time?

---

### Sales by Product Category

**Visual:** Donut Chart

**Measure:** Total Sales

**Dimension:** Product Category

**Business Question:**

> Which product categories contribute most to overall sales?

---

### Sales by Territory

**Visual:** Bar Chart

**Measure:** Total Sales

**Dimension:** Territory

**Business Question:**

> Which sales territories generate the highest revenue?

---

### Procurement Cost Trend

**Visual:** Line Chart

**Measure:** Procurement Cost

**Dimension:** Date

**Business Question:**

> How is procurement spending changing over time?

---

### Employees by Department

**Visual:** Bar Chart

**Measure:** Total Employees

**Dimension:** Department

**Business Question:**

> How is the workforce distributed across departments?

## Slicers

- Order Year
- Territory
- Product Category

---

# 3. Sales Dashboard

## Purpose

The Sales Dashboard analyzes sales performance, revenue trends,
product performance, territories, customers, and sales channels.

## KPI Cards

- Total Sales
- Total Orders
- Total Units Sold
- Average Order Value

## Visuals

### Sales Trend by Month

**Visual:** Line Chart

**Measure:** Total Sales

**Dimension:** Order Month

**Business Question:**

> How does sales performance change over time?

---

### Sales by Product Category

**Visual:** Bar Chart

**Measure:** Total Sales

**Dimension:** Category Name

**Business Question:**

> Which product categories generate the most sales?

---

### Top 10 Products by Sales

**Visual:** Bar Chart

**Measure:** Total Sales

**Dimension:** Product Name

**Business Question:**

> Which products are the strongest contributors to revenue?

---

### Total Sales by Territory

**Visual:** Bar Chart

**Measure:** Total Sales

**Dimension:** Territory Name

**Business Question:**

> Which territories are performing best?

---

### Sales by Online Order Flag

**Visual:** Donut Chart

**Measure:** Total Sales

**Dimension:** Online Order Flag

**Business Question:**

> How is revenue distributed between online and non-online orders?

---

### Top 10 Customers by Sales

**Visual:** Table

**Fields:**

- Customer Name
- Total Sales

**Business Question:**

> Which customers generate the highest sales revenue?

## Slicers

- Order Year
- Territory
- Customer Type
- Product Category

---

# 4. Customer Dashboard

## Purpose

The Customer Dashboard analyzes customer composition, customer value,
territorial distribution, and purchasing behavior.

## KPI Cards

- Total Customers
- Average Revenue per Customer
- Average Order Value
- Store Customers

## Visuals

### Customers by Type

**Visual:** Donut Chart

**Measure:** Total Customers

**Dimension:** Customer Type

**Business Question:**

> What is the composition of the customer base?

---

### Customers by Territory

**Visual:** Bar Chart

**Measure:** Total Customers

**Dimension:** Territory Name

**Business Question:**

> Which territories have the largest customer base?

---

### Top 10 Customers by Sales

**Visual:** Bar Chart

**Measure:** Total Sales

**Dimension:** Customer Name

**Business Question:**

> Which customers generate the highest revenue?

---

### Revenue by Territory

**Visual:** Bar Chart

**Measure:** Total Sales

**Dimension:** Territory Name

**Business Question:**

> Which territories generate the highest customer revenue?

---

### Revenue by Online Order Flag

**Visual:** Donut Chart

**Measure:** Total Sales

**Dimension:** Online Order Flag

**Business Question:**

> How does customer revenue differ between online and non-online orders?

---

### Top 10 Customers by Sales & Orders

**Visual:** Table

**Fields:**

- Customer Name
- Total Sales
- Total Orders

**Business Question:**

> Which customers combine high revenue with frequent purchasing?

## Slicers

- Territory
- Customer Type
- Order Year

---

# 5. Product & Inventory Dashboard

## Purpose

The Product & Inventory Dashboard monitors product assortment,
inventory value, inventory quantity, stock status, and inventory aging.

## KPI Cards

- Total Products
- Inventory Value
- Inventory Quantity
- Average Inventory Age

## Visuals

### Products by Category

**Visual:** Donut Chart

**Measure:** Total Products

**Dimension:** Category Name

**Business Question:**

> How is the product portfolio distributed across categories?

---

### Inventory Value by Category

**Visual:** Bar Chart

**Measure:** Inventory Value

**Dimension:** Category Name

**Business Question:**

> Which product categories hold the highest inventory value?

---

### Stock Status

**Visual:** Donut Chart

**Measure:** Product Count

**Dimension:** Stock Status

**Business Question:**

> What is the current distribution of inventory stock status?

---

### Top 10 Products by Inventory Value

**Visual:** Bar Chart

**Measure:** Inventory Value

**Dimension:** Product Name

**Business Question:**

> Which products represent the largest inventory investment?

---

### Inventory Movement by Transaction Type

**Visual:** Column Chart

**Measure:** Inventory Quantity

**Dimension:** Transaction Type

**Business Question:**

> What types of inventory transactions contribute to inventory movement?

---

### Top 10 Oldest Inventory

**Visual:** Table

**Fields:**

- Product Name
- Inventory Age

**Business Question:**

> Which products have the oldest inventory?

## Slicers

- Product Category
- Stock Status

---

# 6. Procurement Dashboard

## Purpose

The Procurement Dashboard evaluates purchasing costs, purchasing volume,
vendor performance, supplier quality, and supplier classification.

## KPI Cards

- Procurement Cost
- Purchase Orders
- Purchased Quantity
- Average Delivery Days

## Visuals

### Procurement Cost Trend

**Visual:** Line Chart

**Measure:** Procurement Cost

**Dimension:** Order Year

**Business Question:**

> How has procurement spending changed over time?

---

### Procurement Cost by Category

**Visual:** Column Chart

**Measure:** Procurement Cost

**Dimension:** Category Name

**Business Question:**

> Which product categories require the greatest procurement investment?

---

### Top 10 Vendors by Procurement Cost

**Visual:** Bar Chart

**Measure:** Procurement Cost

**Dimension:** Vendor Name

**Business Question:**

> Which suppliers receive the highest procurement spending?

---

### Vendors by Credit Rating

**Visual:** Column Chart

**Measure:** Vendor Count

**Dimension:** Credit Rating

**Business Question:**

> What is the distribution of supplier credit ratings?

---

### Preferred Vendor Status

**Visual:** Donut Chart

**Measure:** Vendor Count

**Dimension:** Preferred Vendor Status

**Business Question:**

> How dependent is procurement on preferred suppliers?

---

### Top 10 Vendors by Average Rejected %

**Visual:** Bar Chart

**Measure:** Average Rejected %

**Dimension:** Vendor Name

**Business Question:**

> Which suppliers have the highest product rejection rates?

## Slicers

- Vendor
- Product Category
- Order Year

---

# 7. HR Dashboard

## Purpose

The HR Dashboard provides an overview of workforce composition,
employee demographics, salary bands, hiring patterns, shifts, and age
distribution.

## KPI Cards

- Total Employees
- Average Age
- Average Experience
- Average Hourly Rate

## Visuals

### Employees by Department

**Visual:** Bar Chart

**Measure:** Employee Count

**Dimension:** Department Name

**Business Question:**

> How is the workforce distributed across departments?

---

### Gender Distribution

**Visual:** Donut Chart

**Measure:** Employee Count

**Dimension:** Gender

**Business Question:**

> What is the gender composition of the workforce?

---

### Employees by Salary Band

**Visual:** Column Chart

**Measure:** Employee Count

**Dimension:** Salary Band

**Business Question:**

> How are employees distributed across salary bands?

---

### Hiring Trend

**Visual:** Line Chart

**Measure:** Employee Count

**Dimension:** Hire Year

**Business Question:**

> How has employee hiring changed over time?

---

### Employees by Shift

**Visual:** Donut Chart

**Measure:** Employee Count

**Dimension:** Shift Name

**Business Question:**

> How are employees distributed across shifts?

---

### Age Group Distribution

**Visual:** Column Chart

**Measure:** Employee Count

**Dimension:** Age Group

**Business Question:**

> What is the age composition of the workforce?

## Slicers

- Department
- Shift

---

# Key Business Insights

The dashboard is designed to convert the SQL EDA findings into an
interactive business intelligence solution.

The most important analytical areas identified during the EDA include
sales concentration, customer value, inventory investment, supplier
concentration, procurement efficiency, and workforce distribution.

---

## Customer Insights

### Customer Base

The analysis identified a customer base of approximately **19,820
customers**.

The majority are individual customers, while store customers represent a
smaller but higher-value customer segment.

### Customer Value

Store customers have a substantially higher average order value than
individual customers.

**Business implication:**

Store customers represent an important high-value segment.

**Recommendation:**

Develop dedicated B2B retention programs, volume-based pricing, and
relationship management strategies for high-value store customers.

---

## Regional Sales Insights

Revenue is distributed differently across sales territories, with some
territories contributing substantially more revenue than others.

**Business implication:**

The organization has significant regional differences in customer value
and sales performance.

**Recommendation:**

Management should strengthen weaker territories through targeted customer
acquisition, regional marketing, and territory-specific sales strategies.

---

## Procurement Insights

Total procurement spending is approximately **180.7 million**, across
approximately **4,012 purchase orders**.

Average delivery time is approximately **9 days**, while the average
receiving percentage is approximately **99.5%**.

### Supplier Concentration

Procurement spending is concentrated among several major suppliers.

**Business implication:**

Heavy dependence on major suppliers can create supply-chain
concentration risk.

**Recommendation:**

Identify alternative suppliers for strategically important products and
evaluate supplier diversification opportunities.

### Supplier Quality

Some suppliers have substantially higher rejection rates than the
overall procurement average.

**Business implication:**

Overall receiving performance can hide supplier-specific quality issues.

**Recommendation:**

Create supplier scorecards using:

- Procurement Cost
- Delivery Days
- Rejection Rate
- Received Percentage
- Vendor Credit Rating

This can help procurement teams identify suppliers requiring corrective
action.

---

# Recommended Business Actions

Based on the analytical areas covered by the report, management should
consider the following actions:

1. **Strengthen high-value customer relationships**

   Identify high-revenue store and individual customers and develop
   targeted retention programs.

2. **Reduce regional concentration risk**

   Investigate weaker territories and develop targeted regional sales
   strategies.

3. **Improve inventory management**

   Monitor high-value and aging inventory to reduce excess inventory
   investment.

4. **Implement supplier scorecards**

   Compare suppliers using procurement cost, delivery performance,
   rejection rate, and receiving efficiency.

5. **Reduce supplier concentration**

   Maintain alternative suppliers for strategically important products.

6. **Optimize procurement planning**

   Use historical procurement trends and product demand to improve
   purchasing and replenishment decisions.

7. **Monitor workforce allocation**

   Compare employee distribution across departments, shifts, age groups,
   and salary bands to identify workforce planning opportunities.

---

# Dashboard Design

The report follows a consistent visual design across all analytical
pages.

## Navigation

The report uses a left-side navigation structure to allow users to move
between:

- Home
- Executive Dashboard
- Sales Dashboard
- Customer Dashboard
- Product & Inventory Dashboard
- Procurement Dashboard
- HR Dashboard

## Visual Design

The report uses a consistent blue/navy business theme with:

- KPI cards
- Line charts
- Bar charts
- Column charts
- Donut charts
- Tables
- Slicers
- Navigation buttons

The design prioritizes readability and avoids excessive visuals on a
single page.

---

# Technical Implementation

The Power BI report consumes the business-ready Gold Layer rather than
directly connecting to the Bronze or Silver layers.

```text
AdventureWorks2025 OLTP
        |
        v
     Bronze
        |
        v
      Silver
        |
        v
       Gold
        |
        v
   Power BI Report