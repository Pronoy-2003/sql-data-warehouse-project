/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/


-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
IF OBJECT_ID('gold.dim_customer', 'V') IS NOT NULL
    DROP VIEW gold.dim_customer;
GO
CREATE VIEW gold.dim_customer AS
SELECT
    ROW_NUMBER() OVER(ORDER BY CustomerID) AS CustomerKey,
    CustomerID,
    PersonID,
    StoreID,
    TerritoryID,
    CustomerTitle,
    CustomerFirstName,
    MiddleName,
    CustomerLastName,
    FullName,
    CustomerEmail,
    CustomerPhone,
    StoreName,
    AccountNumber,
    CustomerType
FROM silver.Customer;
GO

-- =============================================================================
-- Create Dimension: gold.dim_product
-- =============================================================================
IF OBJECT_ID('gold.dim_product', 'V') IS NOT NULL
    DROP VIEW gold.dim_product;
GO
CREATE VIEW gold.dim_product AS
SELECT
    ROW_NUMBER() OVER(ORDER BY ProductID) AS ProductKey,
    ProductID,
    ProductName,
    ProductNumber,
    CategoryName,
    SubcategoryName,
    Color,
    [Size],
    [Weight],
    ProductLine,
    Class,
    Style,
    DaysToManufacture,
    StandardCost,
    ListPrice,
    SellStartDate,
    SellEndDate,
    DiscontinuedDate,
    ProfitMargin,
    ProfitMarginPct,
    ProductStatus,
    PriceCategory
FROM silver.Product;
GO

-- =============================================================================
-- Create Dimension: gold.dim_employee
-- =============================================================================
IF OBJECT_ID('gold.dim_employee', 'V') IS NOT NULL
    DROP VIEW gold.dim_employee;
GO
CREATE VIEW gold.dim_employee AS
SELECT
    ROW_NUMBER() OVER(ORDER BY EmployeeID) AS EmployeeKey,
    EmployeeID,
    EmployeeFirstName,
    MiddleName,
    EmployeeLastName,
    FullName,
    JobTitle,
    DepartmentID,
    DepartmentName,
    ShiftID,
    ShiftName,
    BirthDate,
    Gender,
    MaritalStatus,
    HireDate,
    HourlyRate,
    PayFrequency,
    VacationHours,
    SickLeaveHours,
    CurrentFlag,
    Age,
    YearsExperience,
    SalaryBand,
    EmploymentStatus
FROM silver.Employee;
GO

-- =============================================================================
-- Create Dimension: gold.dim_vendor
-- =============================================================================
IF OBJECT_ID('gold.dim_vendor', 'V') IS NOT NULL
    DROP VIEW gold.dim_vendor;
GO
CREATE VIEW gold.dim_vendor AS
SELECT
    ROW_NUMBER() OVER(ORDER BY VendorID) AS VendorKey,
    VendorID,
    VendorName,
    AccountNumber,
    CreditRating,
    PreferredVendorStatus,
    ActiveFlag,
    AverageLeadTime,
    StandardPrice,
    LastReceiptCost,
    LastReceiptDate,
    MinOrderQty,
    MaxOrderQty,
    OnOrderQty,
    LeadTimeCategory,
    VendorStatus
FROM silver.Vendor;
GO

-- =============================================================================
-- Create Dimension: gold.dim_location
-- =============================================================================
IF OBJECT_ID('gold.dim_location', 'V') IS NOT NULL
    DROP VIEW gold.dim_location;
GO
CREATE VIEW gold.dim_location AS
SELECT
    ROW_NUMBER() OVER(ORDER BY AddressID) AS LocationKey,
    AddressID,
    AddressLine1,
    AddressLine2,
    City,
    StateProvince,
    CountryName,
    PostalCode,
    TerritoryID,
    FullAddress
FROM silver.[Location];
GO

-- =============================================================================
-- Create Dimension: gold.dim_sales_territory
-- =============================================================================
IF OBJECT_ID('gold.dim_sales_territory', 'V') IS NOT NULL
    DROP VIEW gold.dim_sales_territory;
GO
CREATE VIEW gold.dim_sales_territory AS
SELECT
    ROW_NUMBER() OVER(ORDER BY TerritoryID) AS TerritoryKey,
    TerritoryID,
    TerritoryName,
    CountryRegionCode,
    TerritoryGroup,
    SalesYTD,
    SalesLastYear,
    CostYTD,
    CostLastYear,
    Profit,
    GrowthRate
FROM silver.SalesTerritory;
GO

-- =============================================================================
-- Create Dimension: gold.dim_promotion
-- =============================================================================
IF OBJECT_ID('gold.dim_promotion', 'V') IS NOT NULL
    DROP VIEW gold.dim_promotion;
GO
CREATE VIEW gold.dim_promotion AS
SELECT
    ROW_NUMBER() OVER(ORDER BY SpecialOfferID) AS PromotionKey,
    SpecialOfferID,
    ProductID,
    [Description],
    DiscountPct,
    PromotionType,
    PromotionCategory,
    StartDate,
    EndDate,
    MinQty,
    MaxQty,
    PromotionStatus,
    PromotionDuration
FROM silver.Promotion;
GO

-- =============================================================================
-- Create Fact: gold.fact_sales
-- =============================================================================
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO
CREATE VIEW gold.fact_sales AS
SELECT
    -- Degenerate Dimensions
    SalesOrderID,
    SalesOrderDetailID,
    -- Dates
    OrderDate,
    DueDate,
    ShipDate,
    -- Foreign Keys
    CustomerID,
    SalesPersonID,
    TerritoryID,
    ShipMethodID,
    ProductID,
    SpecialOfferID,
    -- Measures
    OrderQty,
    UnitPrice,
    UnitPriceDiscount,
    LineTotal,
    SubTotal,
    TaxAmt,
    Freight,
    TotalDue,
    [Status],
    OnlineOrderFlag,
    GrossSales,
    DiscountAmount,
    NetSales,
    ShippingDays,
    OrderYear,
    OrderQuarter,
    OrderMonth,
    OrderWeek,
    IsLateShipment
FROM silver.Sales;
GO

-- =============================================================================
-- Create Fact: gold.fact_purchase
-- =============================================================================
IF OBJECT_ID('gold.fact_purchase', 'V') IS NOT NULL
    DROP VIEW gold.fact_purchase;
GO
CREATE VIEW gold.fact_purchase AS
SELECT
    -- Degenerate Dimension
    PurchaseOrderID,
    -- Foreign Keys
    VendorID,
    EmployeeID,
    ShipMethodID,
    ProductID,
    -- Dates
    OrderDate,
    DueDate,
    ShipDate,
    -- Measures
    OrderQty,
    UnitPrice,
    LineTotal,
    ReceivedQty,
    RejectedQty,
    StockedQty,
    SubTotal,
    TaxAmt,
    Freight,
    TotalDue,
    DeliveryDays,
    ReceivedPercentage,
    RejectedPercentage
FROM silver.Purchase;
GO

-- =============================================================================
-- Create Fact: gold.fact_inventory
-- =============================================================================
IF OBJECT_ID('gold.fact_inventory', 'V') IS NOT NULL
    DROP VIEW gold.fact_inventory;
GO
CREATE VIEW gold.fact_inventory AS
SELECT
    -- Foreign Keys
    ProductID,
    LocationID,
    -- Date
    TransactionDate,
    -- Transaction
    TransactionType,
    -- Measures
    Quantity,
    ActualCost,
    StandardCost,
    ListPrice,
    InventoryValue,
    InventoryAge,
    StockStatus
FROM silver.Inventory;
GO

