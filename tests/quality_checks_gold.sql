/*
===============================================================================
Gold Layer Data Quality Tests
===============================================================================
Purpose:
    Validate the integrity, consistency, and business rules of the Gold Layer.
===============================================================================
*/

PRINT '================================================';
PRINT 'Running Gold Layer Data Quality Tests';
PRINT '================================================';

-------------------------------------------------------------------------------
-- Test 1: Duplicate Surrogate Keys in Dimension Tables
-------------------------------------------------------------------------------

-- CustomerKey should be unique
SELECT CustomerKey, COUNT(*) AS DuplicateCount
FROM gold.dim_customer
GROUP BY CustomerKey
HAVING COUNT(*) > 1;

-- ProductKey should be unique
SELECT ProductKey, COUNT(*) AS DuplicateCount
FROM gold.dim_product
GROUP BY ProductKey
HAVING COUNT(*) > 1;

-- EmployeeKey should be unique
SELECT EmployeeKey, COUNT(*) AS DuplicateCount
FROM gold.dim_employee
GROUP BY EmployeeKey
HAVING COUNT(*) > 1;

-- VendorKey should be unique
SELECT VendorKey, COUNT(*) AS DuplicateCount
FROM gold.dim_vendor
GROUP BY VendorKey
HAVING COUNT(*) > 1;

-- LocationKey should be unique
SELECT LocationKey, COUNT(*) AS DuplicateCount
FROM gold.dim_location
GROUP BY LocationKey
HAVING COUNT(*) > 1;

-- TerritoryKey should be unique
SELECT TerritoryKey, COUNT(*) AS DuplicateCount
FROM gold.dim_sales_territory
GROUP BY TerritoryKey
HAVING COUNT(*) > 1;

-- PromotionKey should be unique
SELECT PromotionKey, COUNT(*) AS DuplicateCount
FROM gold.dim_promotion
GROUP BY PromotionKey
HAVING COUNT(*) > 1;

-------------------------------------------------------------------------------
-- Test 2: Duplicate Business Keys
-------------------------------------------------------------------------------

SELECT CustomerID, COUNT(*) FROM gold.dim_customer
GROUP BY CustomerID
HAVING COUNT(*) > 1;

SELECT ProductID, COUNT(*) FROM gold.dim_product
GROUP BY ProductID
HAVING COUNT(*) > 1;

SELECT EmployeeID, COUNT(*) FROM gold.dim_employee
GROUP BY EmployeeID
HAVING COUNT(*) > 1;

SELECT VendorID, COUNT(*) FROM gold.dim_vendor
GROUP BY VendorID
HAVING COUNT(*) > 1;

SELECT AddressID, COUNT(*) FROM gold.dim_location
GROUP BY AddressID
HAVING COUNT(*) > 1;

SELECT TerritoryID, COUNT(*) FROM gold.dim_sales_territory
GROUP BY TerritoryID
HAVING COUNT(*) > 1;

SELECT SpecialOfferID, COUNT(*) FROM gold.dim_promotion
GROUP BY SpecialOfferID
HAVING COUNT(*) > 1;

-------------------------------------------------------------------------------
-- Test 3: NULL Business Keys
-------------------------------------------------------------------------------

SELECT * FROM gold.dim_customer WHERE CustomerID IS NULL;
SELECT * FROM gold.dim_product WHERE ProductID IS NULL;
SELECT * FROM gold.dim_employee WHERE EmployeeID IS NULL;
SELECT * FROM gold.dim_vendor WHERE VendorID IS NULL;
SELECT * FROM gold.dim_location WHERE AddressID IS NULL;
SELECT * FROM gold.dim_sales_territory WHERE TerritoryID IS NULL;
SELECT * FROM gold.dim_promotion WHERE SpecialOfferID IS NULL;

-------------------------------------------------------------------------------
-- Test 4: Fact to Dimension Referential Integrity
-------------------------------------------------------------------------------

-- Sales → Customer
SELECT fs.CustomerID
FROM gold.fact_sales fs
LEFT JOIN gold.dim_customer dc
    ON fs.CustomerID = dc.CustomerID
WHERE dc.CustomerID IS NULL;

-- Sales → Product
SELECT fs.ProductID
FROM gold.fact_sales fs
LEFT JOIN gold.dim_product dp
    ON fs.ProductID = dp.ProductID
WHERE dp.ProductID IS NULL;

-- Sales → Territory
SELECT fs.TerritoryID
FROM gold.fact_sales fs
LEFT JOIN gold.dim_sales_territory dt
    ON fs.TerritoryID = dt.TerritoryID
WHERE dt.TerritoryID IS NULL;

-- Sales → Promotion
SELECT fs.SpecialOfferID
FROM gold.fact_sales fs
LEFT JOIN gold.dim_promotion prm
    ON fs.SpecialOfferID = prm.SpecialOfferID
WHERE prm.SpecialOfferID IS NULL;

-- Purchase → Vendor
SELECT fp.VendorID
FROM gold.fact_purchase fp
LEFT JOIN gold.dim_vendor dv
    ON fp.VendorID = dv.VendorID
WHERE dv.VendorID IS NULL;

-- Purchase → Employee
SELECT fp.EmployeeID
FROM gold.fact_purchase fp
LEFT JOIN gold.dim_employee de
    ON fp.EmployeeID = de.EmployeeID
WHERE de.EmployeeID IS NULL;

-- Purchase → Product
SELECT fp.ProductID
FROM gold.fact_purchase fp
LEFT JOIN gold.dim_product dp
    ON fp.ProductID = dp.ProductID
WHERE dp.ProductID IS NULL;

-- Inventory → Product
SELECT fi.ProductID
FROM gold.fact_inventory fi
LEFT JOIN gold.dim_product dp
    ON fi.ProductID = dp.ProductID
WHERE dp.ProductID IS NULL;

-------------------------------------------------------------------------------
-- Test 5: Required Fact Columns
-------------------------------------------------------------------------------

SELECT * FROM gold.fact_sales
WHERE CustomerID IS NULL
   OR ProductID IS NULL
   OR OrderDate IS NULL;

SELECT * FROM gold.fact_purchase
WHERE VendorID IS NULL
   OR ProductID IS NULL
   OR OrderDate IS NULL;

SELECT * FROM gold.fact_inventory
WHERE ProductID IS NULL
   OR TransactionDate IS NULL;

-------------------------------------------------------------------------------
-- Test 6: Business Rules
-------------------------------------------------------------------------------

-- Sales should not be negative
SELECT *
FROM gold.fact_sales
WHERE NetSales < 0;

-- Gross Sales should be greater than or equal to Net Sales
SELECT *
FROM gold.fact_sales
WHERE GrossSales < NetSales;

-- Shipping date should not be before Order date
SELECT *
FROM gold.fact_sales
WHERE ShipDate < OrderDate;

-- Due date should not be before Order date
SELECT *
FROM gold.fact_sales
WHERE DueDate < OrderDate;

-- Purchase quantity cannot be negative
SELECT *
FROM gold.fact_purchase
WHERE OrderQty < 0;

-- Received quantity cannot exceed ordered quantity
SELECT *
FROM gold.fact_purchase
WHERE ReceivedQty > OrderQty;

-- Rejected quantity cannot exceed received quantity
SELECT *
FROM gold.fact_purchase
WHERE RejectedQty > ReceivedQty;

-- Inventory quantity cannot be negative
SELECT *
FROM gold.fact_inventory
WHERE Quantity < 0;

-- Inventory value cannot be negative
SELECT *
FROM gold.fact_inventory
WHERE InventoryValue < 0;

-------------------------------------------------------------------------------
-- Test 7: Date Validation
-------------------------------------------------------------------------------

SELECT *
FROM gold.fact_sales
WHERE OrderYear <> YEAR(OrderDate);

SELECT *
FROM gold.fact_sales
WHERE OrderMonth <> MONTH(OrderDate);

SELECT *
FROM gold.fact_sales
WHERE OrderQuarter <> DATEPART(QUARTER, OrderDate);

-------------------------------------------------------------------------------
-- Test 8: Empty Tables
-------------------------------------------------------------------------------

SELECT 'dim_customer' AS TableName, COUNT(*) AS Row_Count FROM gold.dim_customer
UNION ALL
SELECT 'dim_product', COUNT(*) FROM gold.dim_product
UNION ALL
SELECT 'dim_employee', COUNT(*) FROM gold.dim_employee
UNION ALL
SELECT 'dim_vendor', COUNT(*) FROM gold.dim_vendor
UNION ALL
SELECT 'dim_location', COUNT(*) FROM gold.dim_location
UNION ALL
SELECT 'dim_sales_territory', COUNT(*) FROM gold.dim_sales_territory
UNION ALL
SELECT 'dim_promotion', COUNT(*) FROM gold.dim_promotion
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM gold.fact_sales
UNION ALL
SELECT 'fact_purchase', COUNT(*) FROM gold.fact_purchase
UNION ALL
SELECT 'fact_inventory', COUNT(*) FROM gold.fact_inventory;

PRINT '================================================';
PRINT 'Gold Layer Data Quality Tests Completed';
PRINT '================================================';
