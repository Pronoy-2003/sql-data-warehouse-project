
# Naming Conventions

This document outlines the naming conventions used for schemas, tables, views, columns, stored procedures, and SQL scripts in the SQL Data Warehouse project.

---

# General Principles

- **Naming Style:** Use **PascalCase** for Bronze and Silver database objects.
- **Gold objects:** Use `dim_` and `fact_` prefixes.
- **Language:** English only.
- **Use meaningful business names.**
- **Avoid SQL reserved words.**

---

# Table Naming Conventions

## Bronze Rules

Bronze tables store raw data from AdventureWorks2025.

**Pattern**

`<OriginalTableName>`

Examples:

- SalesOrderHeader
- SalesOrderDetail
- Customer
- Product
- Employee
- Vendor

Rules:

- Keep original table names.
- No transformations.
- No renamed columns.

---

## Silver Rules

Silver tables contain cleaned and integrated business entities.

**Pattern**

`<BusinessEntity>`

Examples:

- Sales
- Customer
- Product
- Location
- Employee
- Vendor
- Purchase
- Inventory
- Promotion
- SalesTerritory

Rules:

- Merge related source tables.
- Remove unnecessary columns.
- Add derived business columns.

---

## Gold Rules

### Dimension

Pattern: `dim_<entity>`

Examples:

- dim_customer
- dim_product
- dim_employee
- dim_vendor
- dim_location
- dim_sales_territory
- dim_promotion

### Fact

Pattern: `fact_<entity>`

Examples:

- fact_sales
- fact_purchase
- fact_inventory

| Pattern | Meaning | Example |
|---------|---------|---------|
| dim_ | Dimension table | dim_customer |
| fact_ | Fact table | fact_sales |

---

# Column Naming Conventions

## Business Keys

Keep original AdventureWorks key names.

Examples:

- SalesOrderID
- CustomerID
- ProductID
- VendorID
- EmployeeID
- TerritoryID
- SpecialOfferID

## Surrogate Keys

Pattern:

`<Entity>Key`

Examples:

- CustomerKey
- ProductKey
- EmployeeKey
- VendorKey
- LocationKey
- TerritoryKey
- PromotionKey

## Technical Columns

Pattern:

`dwh_<column_name>`

Examples:

- dwh_create_date
- dwh_load_date

---

# Stored Procedure Naming Conventions

Pattern:

`load_<layer>`

Examples:

- load_bronze
- load_silver
- load_gold

---

# SQL Script Naming Conventions

Pattern:

`dl_<layer>.sql`

Examples:

- dl_bronze.sql
- dl_silver.sql
- dl_gold.sql

---

# Summary

| Object | Convention | Example |
|--------|------------|---------|
| Bronze Table | Original Table Name | SalesOrderHeader |
| Silver Table | Business Entity | Sales |
| Gold Dimension | dim_<entity> | dim_customer |
| Gold Fact | fact_<entity> | fact_sales |
| Business Key | Original Key | SalesOrderID |
| Surrogate Key | <Entity>Key | CustomerKey |
| Technical Column | dwh_ prefix | dwh_create_date |
| Stored Procedure | load_<layer> | load_silver |
| SQL Script | dl_<layer>.sql | dl_bronze.sql |
