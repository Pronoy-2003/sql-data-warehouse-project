/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


-- ==================================================================== --
---- Silver.Sales Data Quality Tests ----
-- 1. SalesOrderID should not be NULL
SELECT *
FROM silver.Sales
WHERE SalesOrderID IS NULL;

-- 2. SalesOrderDetailID should not be NULL
SELECT *
FROM silver.Sales
WHERE SalesOrderDetailID IS NULL;

-- 3. Duplicate Sales Order Detail
SELECT
    SalesOrderID,
    SalesOrderDetailID,
    COUNT(*) AS DuplicateCount
FROM silver.Sales
GROUP BY
    SalesOrderID,
    SalesOrderDetailID
HAVING COUNT(*) > 1;

-- 4. CustomerID should exist
SELECT h.*
FROM silver.Sales h
LEFT JOIN silver.Customer c
ON h.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

-- 5. ProductID should exist
SELECT d.*
FROM silver.Sales d
LEFT JOIN silver.Product p
ON d.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-- 6. TerritoryID should exist
SELECT h.*
FROM silver.Sales h
LEFT JOIN silver.SalesTerritory t
ON h.TerritoryID=t.TerritoryID
WHERE h.TerritoryID IS NOT NULL
AND t.TerritoryID IS NULL;

-- 7. OrderQty should be greater than zero
SELECT *
FROM silver.Sales
WHERE OrderQty<=0;

-- 8. UnitPrice >=0
SELECT *
FROM silver.Sales
WHERE UnitPrice<0;

-- 9. Discount between 0 and 1
SELECT *
FROM silver.Sales
WHERE UnitPriceDiscount<0
OR UnitPriceDiscount>1;

-- 10. LineTotal >=0
SELECT *
FROM silver.Sales
WHERE LineTotal<0;

-- 11. TaxAmt >=0
SELECT *
FROM silver.Sales
WHERE TaxAmt<0;

-- 12. Freight >=0
SELECT *
FROM silver.Sales
WHERE Freight<0;

-- 13. TotalDue >=0
SELECT *
FROM silver.Sales
WHERE TotalDue<0;

-- 14. Status Valid (1-8)
SELECT *
FROM silver.Sales
WHERE Status NOT IN (1,2,3,4,5,6,7,8);

-- 15. OnlineOrderFlag
SELECT *
FROM silver.Sales
WHERE OnlineOrderFlag NOT IN (0,1);

-- 16. OrderDate should not be NULL
SELECT *
FROM silver.Sales
WHERE OrderDate IS NULL;

-- 17. DueDate >= OrderDate
SELECT *
FROM silver.Sales
WHERE DueDate<OrderDate;

-- 18. ShipDate >= OrderDate
SELECT *
FROM silver.Sales
WHERE ShipDate IS NOT NULL
AND ShipDate<OrderDate;

-- 19. ShipDate <= DueDate
SELECT *
FROM silver.Sales
WHERE ShipDate IS NOT NULL
AND ShipDate>DueDate;

-- 20. Gross Sales Validation
SELECT *,
(OrderQty*UnitPrice) AS ExpectedGross
FROM silver.Sales;

-- 21. Discount Validation
SELECT *,
(OrderQty*UnitPrice*UnitPriceDiscount) AS ExpectedDiscount
FROM silver.Sales;

-- 22. Net Sales Validation
SELECT *,
(OrderQty*UnitPrice)
-
(OrderQty*UnitPrice*UnitPriceDiscount)
AS ExpectedNetSales
FROM silver.Sales;

-- 23. Shipping Days
SELECT *,
DATEDIFF(DAY,OrderDate,ShipDate) AS ShippingDays
FROM silver.Sales;

-- ==================================================================== --


-- ==================================================================== --
---- Silver.Customer Data Quality Tests ----
-- 1. CustomerID Unique
SELECT CustomerID,
COUNT(*)
FROM silver.Customer
GROUP BY CustomerID
HAVING COUNT(*)>1;

-- 2. Account Number Unique
SELECT AccountNumber,
COUNT(*)
FROM silver.Customer
GROUP BY AccountNumber
HAVING COUNT(*)>1;

-- 3. First Name NULL
SELECT *
FROM silver.Customer
WHERE CustomerFirstName IS NULL;

-- 4. Last Name NULL
SELECT *
FROM silver.Customer
WHERE CustomerLastName IS NULL;

-- 5. Email Format
SELECT *
FROM silver.Customer
WHERE CustomerEmail NOT LIKE '%_@_%._%';

-- 6. Duplicate Email
SELECT CustomerEmail,
COUNT(*)
FROM silver.Customer
GROUP BY CustomerEmail
HAVING COUNT(*)>1;

-- 7. Phone NULL
SELECT *
FROM silver.Customer
WHERE CustomerPhone IS NULL;

-- 8. Territory Exists
SELECT c.*
FROM silver.Customer c
LEFT JOIN silver.SalesTerritory t
ON c.TerritoryID=t.TerritoryID
WHERE c.TerritoryID IS NOT NULL
AND t.TerritoryID IS NULL;

-- 9. Customer Type
SELECT *,
CASE
WHEN StoreID IS NULL THEN 'Individual'
ELSE 'Store'
END AS CustomerType
FROM silver.Customer;

-- 10. Duplicate Customer
SELECT CustomerID,
COUNT(*)
FROM silver.Customer
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
HAVING COUNT(*)>1;

-- 11. No unwanted space in Customer Name
-- First Name
SELECT CustomerFirstName 
FROM silver.Customer 
WHERE CustomerFirstName != TRIM(CustomerFirstName)
-- Middle Name
SELECT MiddleName 
FROM silver.Customer 
WHERE MiddleName != TRIM(MiddleName)
-- Last Name
SELECT CustomerLastName 
FROM silver.Customer 
WHERE CustomerLastName != TRIM(CustomerLastName)
-- Full Name
SELECT FullName 
FROM silver.Customer 
WHERE FullName != TRIM(FullName)

-- 12. All letters of Customer Email Should be in Lower Case
SELECT CustomerEmail 
FROM silver.Customer 
WHERE CustomerEmail != LOWER(CustomerEmail)

-- ==================================================================== --


-- ==================================================================== --
---- Silver.Location Data Quality Tests ----
-- 1. AddressID Unique
SELECT AddressID,
COUNT(*)
FROM silver.Location
GROUP BY AddressID
HAVING COUNT(*)>1;

-- 2. AddressLine1 NULL
SELECT *
FROM silver.Location
WHERE AddressLine1 IS NULL;

-- 3. City NULL
SELECT *
FROM silver.Location
WHERE City IS NULL;

-- 4. Postal Code NULL
SELECT *
FROM silver.Location
WHERE PostalCode IS NULL;

-- 5. State Exists
SELECT a.*
FROM silver.Location a
LEFT JOIN silver.Location s
ON a.StateProvince=s.StateProvince
WHERE s.StateProvince IS NULL;

-- 6. Country Exists
SELECT s.*
FROM silver.Location s
LEFT JOIN silver.Location c
ON s.CountryName=c.CountryName
WHERE c.CountryName IS NULL;

-- 7. Territory Exists
SELECT s.*
FROM silver.Location s
LEFT JOIN silver.SalesTerritory t
ON s.TerritoryID=t.TerritoryID
WHERE t.TerritoryID IS NULL;

-- 8. Duplicate Address
SELECT
AddressLine1,
City,
PostalCode,
COUNT(*)
FROM silver.Location
GROUP BY
AddressLine1,
City,
PostalCode
HAVING COUNT(*)>1;

-- 9. Empty Strings
SELECT *
FROM silver.Location
WHERE LTRIM(RTRIM(AddressLine1))=''
OR LTRIM(RTRIM(City))=''
OR LTRIM(RTRIM(PostalCode))='';

-- 10. Leading and Trailing Spaces
SELECT *
FROM silver.Location
WHERE AddressLine1<>LTRIM(RTRIM(AddressLine1))
OR City<>LTRIM(RTRIM(City))
OR PostalCode<>LTRIM(RTRIM(PostalCode));

-- ==================================================================== --



-- ==================================================================== --
---- Silver.Product Data Quality Tests ----
-- 1. ProductID should be unique
SELECT
    ProductID,
    COUNT(*) AS DuplicateCount
FROM silver.Product
GROUP BY ProductID
HAVING COUNT(*) > 1;

-- 2. ProductNumber should be unique
SELECT
    ProductNumber,
    COUNT(*) AS DuplicateCount
FROM silver.Product
GROUP BY ProductNumber
HAVING COUNT(*) > 1;

-- 3. ProductName should not be NULL
SELECT *
FROM silver.Product
WHERE ProductName IS NULL;

-- 4. StandardCost should be >= 0
SELECT *
FROM silver.Product
WHERE StandardCost < 0;

-- 5. ListPrice should be >= StandardCost
SELECT *
FROM silver.Product
WHERE ListPrice < StandardCost;

-- 6. Weight should be >= 0
SELECT *
FROM silver.Product
WHERE Weight < 0;

-- 7. DaysToManufacture should be >= 0
SELECT *
FROM silver.Product
WHERE DaysToManufacture < 0;

-- 8. SellEndDate should be after SellStartDate
SELECT *
FROM silver.Product
WHERE SellEndDate IS NOT NULL
AND SellEndDate < SellStartDate;

-- 9. DiscontinuedDate should be after SellStartDate
SELECT *
FROM silver.Product
WHERE DiscontinuedDate IS NOT NULL
AND DiscontinuedDate < SellStartDate;

-- 10. Leading and Trailing Spaces
SELECT *
FROM silver.Product
WHERE ProductName <> LTRIM(RTRIM(ProductName))
OR ProductNumber <> LTRIM(RTRIM(ProductNumber));

-- 13. Empty Product Name
SELECT *
FROM silver.Product
WHERE LTRIM(RTRIM(ProductName))='';

-- ==================================================================== --



-- ==================================================================== --
---- Silver.Inventory Data Quality Tests ----
-- 1. ProductID should exist
SELECT pi.*
FROM silver.Inventory pi
LEFT JOIN silver.Product p
ON pi.ProductID=p.ProductID
WHERE p.ProductID IS NULL;

-- 2. LocationID should exist
SELECT pi.*
FROM silver.Inventory pi
LEFT JOIN bronze.Location l
ON pi.LocationID=l.LocationID
WHERE l.LocationID IS NULL;

-- 3. Quantity should be >=0
SELECT *
FROM silver.Inventory
WHERE Quantity<0;

-- 4. Shelf should not be NULL
SELECT *
FROM silver.Inventory
WHERE Shelf IS NULL;

-- 5. Bin should be >=0
SELECT *
FROM silver.Inventory
WHERE Bin<0;

-- 6. ActualCost should be >=0
SELECT *
FROM silver.Inventory
WHERE ActualCost<0;

-- 7. StandardCost should be >=0
SELECT *
FROM silver.Inventory
WHERE StandardCost<0;

-- 8. ListPrice should be >=0
SELECT *
FROM silver.Inventory
WHERE ListPrice<0;

-- 9. TransactionDate should not be NULL
SELECT *
FROM silver.Inventory
WHERE TransactionDate IS NULL;

-- 10. TransactionType should contain valid values
SELECT DISTINCT TransactionType
FROM silver.Inventory;

-- 11. Duplicate Inventory
SELECT
ProductID,
LocationID,
Shelf,
Bin,
COUNT(*)
FROM silver.Inventory
GROUP BY
ProductID,
LocationID,
Shelf,
Bin
HAVING COUNT(*)>1;

-- ==================================================================== --



-- ==================================================================== --
---- Silver.Purchase Data Quality Tests ----
-- 1. PurchaseOrderID should not be NULL
SELECT *
FROM silver.Purchase
WHERE PurchaseOrderID IS NULL;

-- 2. PurchaseOrderID + ProductID should be unique
SELECT
PurchaseOrderID,
ProductID,
COUNT(*)
FROM silver.Purchase
GROUP BY
PurchaseOrderID,
ProductID
HAVING COUNT(*)>1;

-- 3. Vendor should exist
SELECT h.*
FROM silver.Purchase h
LEFT JOIN silver.Vendor v
ON h.VendorID=v.VendorID
WHERE v.VendorID IS NULL;

-- 4. Employee should exist
SELECT h.*
FROM silver.Purchase h
LEFT JOIN silver.Employee e
ON h.EmployeeID=e.EmployeeID
WHERE e.EmployeeID IS NULL;

-- 5. ShipMethod should exist
SELECT h.*
FROM silver.Purchase h
LEFT JOIN silver.Purchase s
ON h.ShipMethodID=s.ShipMethodID
WHERE s.ShipMethodID IS NULL;

-- 6. Product should exist
SELECT d.*
FROM silver.Purchase d
LEFT JOIN silver.Product p
ON d.ProductID=p.ProductID
WHERE p.ProductID IS NULL;

-- 7. OrderQty should be >0
SELECT *
FROM silver.Purchase
WHERE OrderQty<=0;

-- 8. UnitPrice should be >=0
SELECT *
FROM silver.Purchase
WHERE UnitPrice<0;

-- 9. ReceivedQty should not exceed OrderQty
SELECT *
FROM silver.Purchase
WHERE ReceivedQty>OrderQty;

-- 10. RejectedQty should not exceed OrderQty
SELECT *
FROM silver.Purchase
WHERE RejectedQty>OrderQty;

-- 11. StockedQty should equal ReceivedQty − RejectedQty
SELECT *
FROM silver.Purchase
WHERE StockedQty<>(ReceivedQty-RejectedQty);

-- 12. ShipDate should be after OrderDate
SELECT *
FROM silver.Purchase
WHERE ShipDate IS NOT NULL
AND ShipDate<OrderDate;

-- 13. Freight should be >=0
SELECT *
FROM silver.Purchase
WHERE Freight<0;

-- 14. TaxAmt should be >=0
SELECT *
FROM silver.Purchase
WHERE TaxAmt<0;

-- 15. TotalDue should be >=0
SELECT *
FROM silver.Purchase
WHERE TotalDue<0;

-- ==================================================================== --



-- ==================================================================== --
---- Silver.Vendor Data Quality Tests ----
-- 1. VendorID Unique
SELECT VendorID, COUNT(*) AS DuplicateCount
FROM silver.Vendor
GROUP BY VendorID
HAVING COUNT(*) > 1;

-- 2. Vendor Name NOT NULL
SELECT *
FROM silver.Vendor
WHERE VendorName IS NULL;

-- 3. Account Number Unique
SELECT AccountNumber, COUNT(*) AS DuplicateCount
FROM silver.Vendor
GROUP BY AccountNumber
HAVING COUNT(*) > 1;

-- 4. Product Exists
SELECT pv.*
FROM silver.Vendor pv
LEFT JOIN silver.Product p
ON pv.ProductID = p.ProductID
WHERE p.ProductID IS NULL;

-- 5. AverageLeadTime >= 0
SELECT *
FROM silver.Vendor
WHERE AverageLeadTime < 0;

-- 6. StandardPrice >= 0
SELECT *
FROM silver.Vendor
WHERE StandardPrice < 0;

-- 7. LastReceiptCost >= 0
SELECT *
FROM silver.Vendor
WHERE LastReceiptCost < 0;

-- 8. MinOrderQty <= MaxOrderQty
SELECT *
FROM silver.Vendor
WHERE MinOrderQty > MaxOrderQty;

-- 9. OnOrderQty >= 0
SELECT *
FROM silver.Vendor
WHERE OnOrderQty < 0;

-- 10. CreditRating Valid
SELECT *
FROM silver.Vendor
WHERE CreditRating NOT BETWEEN 1 AND 5;

-- 11. PreferredVendorStatus Valid
SELECT *
FROM silver.Vendor
WHERE PreferredVendorStatus NOT IN (0,1);

-- 12. ActiveFlag Valid
SELECT *
FROM silver.Vendor
WHERE ActiveFlag NOT IN (0,1);

-- 13. Duplicate Vendor Product
SELECT VendorID,
       ProductID,
       COUNT(*) AS DuplicateCount
FROM silver.Vendor
GROUP BY VendorID,
         ProductID
HAVING COUNT(*) > 1;

-- ==================================================================== --



-- ==================================================================== --
---- Silver.Employee Data Quality Tests ----
-- 1. EmployeeID Unique
SELECT EmployeeID,
       COUNT(*) AS DuplicateCount
FROM silver.Employee
GROUP BY EmployeeID
HAVING COUNT(*) > 1;

-- 2. FirstName NOT NULL
SELECT *
FROM silver.Employee
WHERE EmployeeFirstName IS NULL;

-- 3. LastName NOT NULL
SELECT *
FROM silver.Employee
WHERE EmployeeLastName IS NULL;

-- 4. BirthDate Valid
SELECT *
FROM silver.Employee
WHERE BirthDate >= GETDATE();

-- 5. HireDate > BirthDate
SELECT *
FROM silver.Employee
WHERE HireDate <= BirthDate;

-- 6. Age >=18
SELECT *
FROM silver.Employee
WHERE DATEDIFF(YEAR,BirthDate,HireDate) < 18;

-- 7. Hourly Rate >0
SELECT *
FROM silver.Employee
WHERE HourlyRate <=0;

-- 8. VacationHours >=0
SELECT *
FROM silver.Employee
WHERE VacationHours<0;

-- 9. SickLeaveHours >=0
SELECT *
FROM silver.Employee
WHERE SickLeaveHours<0;

-- 10. CurrentFlag Valid
SELECT *
FROM silver.Employee
WHERE CurrentFlag NOT IN (0,1);

-- 11. Department Exists
SELECT edh.*
FROM silver.Employee edh
LEFT JOIN silver.Employee d
ON edh.DepartmentID=d.DepartmentID
WHERE d.DepartmentID IS NULL;

-- 12. Shift Exists
SELECT edh.*
FROM silver.Employee edh
LEFT JOIN silver.Employee s
ON edh.ShiftID=s.ShiftID
WHERE s.ShiftID IS NULL;

-- 13. PayFrequency Valid
SELECT *
FROM silver.Employee
WHERE PayFrequency NOT IN (1,2);

-- 14. Employee Name format in correct form
-- First Name
SELECT EmployeeFirstName 
FROM silver.Employee 
WHERE EmployeeFirstName != TRIM(EmployeeFirstName)
-- Middle Name
SELECT MiddleName 
FROM silver.Employee 
WHERE MiddleName != TRIM(MiddleName)
-- Last Name
SELECT EmployeeLastName
FROM silver.Employee 
WHERE EmployeeLastName != TRIM(EmployeeLastName)
-- Full Name
SELECT FullName 
FROM silver.Employee 
WHERE FullName != TRIM(FullName)

-- 15. Consistent Employee Gender
SELECT DISTINCT Gender 
FROM silver.Employee

-- 16. Consistent Employee Martial Status
SELECT DISTINCT MaritalStatus 
FROM silver.Employee

-- ==================================================================== --



-- ==================================================================== --
---- Silver.SalesTerritory Data Quality Tests ----
-- 1. TerritoryID Unique
SELECT TerritoryID,
       COUNT(*) AS DuplicateCount
FROM silver.SalesTerritory
GROUP BY TerritoryID
HAVING COUNT(*) >1;

-- 2. Territory Name NOT NULL
SELECT *
FROM silver.SalesTerritory
WHERE TerritoryName IS NULL;

-- 3. Country Exists
SELECT st.*
FROM silver.SalesTerritory st
LEFT JOIN silver.Location cr
ON st.TerritoryID=cr.TerritoryID
WHERE cr.TerritoryID IS NULL;

-- 4. SalesYTD >=0
SELECT *
FROM silver.SalesTerritory
WHERE SalesYTD<0;

-- 5. SalesLastYear >=0
SELECT *
FROM silver.SalesTerritory
WHERE SalesLastYear<0;

-- 6. CostYTD >=0
SELECT *
FROM silver.SalesTerritory
WHERE CostYTD<0;

-- 7. CostLastYear >=0
SELECT *
FROM silver.SalesTerritory
WHERE CostLastYear<0;

-- 8. Duplicate Territory Name
SELECT TerritoryName,
       COUNT(*) AS DuplicateCount
FROM silver.SalesTerritory
GROUP BY TerritoryName
HAVING COUNT(*)>1;

-- ==================================================================== --



-- ==================================================================== --
---- Silver.Promotion Data Quality Tests ----
-- 1. Duplicate SpecialOffer Product
SELECT SpecialOfferID,
       ProductID,
       COUNT(*) AS DuplicateCount
FROM silver.Promotion
GROUP BY SpecialOfferID,
         ProductID
HAVING COUNT(*)>1;

-- 2. Description NOT NULL
SELECT *
FROM silver.Promotion
WHERE Description IS NULL;

-- 3. DiscountPct Between 0 and 1
SELECT *
FROM silver.Promotion
WHERE DiscountPct<0
OR DiscountPct>1;

-- 4. StartDate < EndDate
SELECT *
FROM silver.Promotion
WHERE StartDate>EndDate;

-- 5. MinQty >=0
SELECT *
FROM silver.Promotion
WHERE MinQty<0;

-- 6. MaxQty >= MinQty
SELECT *
FROM silver.Promotion
WHERE MaxQty IS NOT NULL
AND MaxQty<MinQty;

-- 7. Promotion Type NOT NULL
SELECT *
FROM silver.Promotion
WHERE PromotionType IS NULL;

-- 8. Promotion Category NOT NULL
SELECT *
FROM silver.Promotion
WHERE PromotionCategory IS NULL;

-- 9. Product Exists
SELECT sop.*
FROM silver.Promotion sop
LEFT JOIN silver.Product p
ON sop.ProductID=p.ProductID
WHERE p.ProductID IS NULL;

-- 10. SpecialOffer Exists
SELECT sop.*
FROM silver.Promotion sop
LEFT JOIN silver.Promotion so
ON sop.SpecialOfferID=so.SpecialOfferID
WHERE so.SpecialOfferID IS NULL;

-- ==================================================================== --
