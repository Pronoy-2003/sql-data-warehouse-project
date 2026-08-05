/*
===============================================================================
Exploratory Data Analysis (EDA) - Sales Analytics
===============================================================================
Business Domain:
    Sales Department

Business Objective:
    Analyze sales performance, customer purchasing behavior, product performance,
    promotion effectiveness, regional sales, and shipping efficiency to support
    strategic business decisions and Power BI dashboard development.

Data Source:
    gold.fact_sales
    gold.dim_customer
    gold.dim_product
    gold.dim_sales_territory
    gold.dim_promotion

===============================================================================
*/

PRINT '=========================================================';
PRINT 'EDA - SALES ANALYTICS';
PRINT '=========================================================';

--------------------------------------------------------------------------------
-- 1. Total Sales Performance
--------------------------------------------------------------------------------
-- Business Question:
-- What is the overall sales performance of the company?
--
-- Insight:
-- Gives a high-level summary of revenue, orders, discounts, and shipping.
-- These KPIs will become the KPI cards on the Executive Dashboard.
--------------------------------------------------------------------------------

SELECT
    SUM(GrossSales)                  AS TotalGrossSales,
    SUM(DiscountAmount)              AS TotalDiscount,
    SUM(NetSales)                    AS TotalNetSales,
    SUM(TotalDue)                    AS TotalRevenue,
    COUNT(DISTINCT SalesOrderID)     AS TotalOrders,
    SUM(OrderQty)                    AS TotalUnitsSold,
    AVG(NetSales)                    AS AverageSalesPerOrder,
    AVG(ShippingDays)                AS AverageShippingDays
FROM gold.fact_sales;

--------------------------------------------------------------------------------
-- 2. Sales Trend by Year
--------------------------------------------------------------------------------
-- Business Question:
-- How have sales changed over the years?
--
-- Insight:
-- Identifies long-term revenue growth or decline.
-- Used for yearly sales trend line chart.
--------------------------------------------------------------------------------

SELECT
    OrderYear,
    SUM(NetSales) AS TotalSales
FROM gold.fact_sales
GROUP BY OrderYear
ORDER BY OrderYear;

--------------------------------------------------------------------------------
-- 3. Sales Trend by Quarter
--------------------------------------------------------------------------------
-- Business Question:
-- Which quarter generates the highest revenue?
--------------------------------------------------------------------------------

SELECT
    OrderYear,
    OrderQuarter,
    SUM(NetSales) AS TotalSales
FROM gold.fact_sales
GROUP BY
    OrderYear,
    OrderQuarter
ORDER BY
    OrderYear,
    OrderQuarter;

--------------------------------------------------------------------------------
-- 4. Sales Trend by Month
--------------------------------------------------------------------------------
-- Business Question:
-- Which month has the highest sales?
--
-- Insight:
-- Useful for seasonality analysis.
--------------------------------------------------------------------------------

SELECT
    OrderYear,
    OrderMonth,
    SUM(NetSales) AS TotalSales
FROM gold.fact_sales
GROUP BY
    OrderYear,
    OrderMonth
ORDER BY
    OrderYear,
    OrderMonth;

--------------------------------------------------------------------------------
-- 5. Weekly Sales Trend
--------------------------------------------------------------------------------
-- Business Question:
-- Which weeks generate the highest revenue?
--------------------------------------------------------------------------------

SELECT
    OrderWeek,
    SUM(NetSales) AS WeeklySales
FROM gold.fact_sales
GROUP BY OrderWeek
ORDER BY OrderWeek;

--------------------------------------------------------------------------------
-- 6. Top 10 Selling Products
--------------------------------------------------------------------------------
-- Business Question:
-- Which products generate the highest sales revenue?
--
-- Insight:
-- Helps identify star-performing products.
--------------------------------------------------------------------------------

SELECT TOP 10

    p.ProductName,

    SUM(f.NetSales) AS SalesRevenue,

    SUM(f.OrderQty) AS UnitsSold

FROM gold.fact_sales f

INNER JOIN gold.dim_product p
ON f.ProductID=p.ProductID

GROUP BY
    p.ProductName

ORDER BY
    SalesRevenue DESC;

--------------------------------------------------------------------------------
-- 7. Bottom 10 Selling Products
--------------------------------------------------------------------------------
-- Business Question:
-- Which products perform the worst?
--
-- Insight:
-- Useful for inventory optimization and marketing decisions.
--------------------------------------------------------------------------------

SELECT TOP 10

    p.ProductName,

    SUM(f.NetSales) AS SalesRevenue,

    SUM(f.OrderQty) AS UnitsSold

FROM gold.fact_sales f

INNER JOIN gold.dim_product p
ON f.ProductID=p.ProductID

GROUP BY
    p.ProductName

ORDER BY
    SalesRevenue ASC;

--------------------------------------------------------------------------------
-- 8. Sales by Product Category
--------------------------------------------------------------------------------
-- Business Question:
-- Which product category generates the highest revenue?
--------------------------------------------------------------------------------

SELECT

    p.CategoryName,

    SUM(f.NetSales) AS SalesRevenue,

    SUM(f.OrderQty) AS UnitsSold

FROM gold.fact_sales f

INNER JOIN gold.dim_product p
ON f.ProductID=p.ProductID

GROUP BY
    p.CategoryName

ORDER BY
    SalesRevenue DESC;

--------------------------------------------------------------------------------
-- 9. Sales by Product Subcategory
--------------------------------------------------------------------------------
-- Business Question:
-- Which subcategory contributes the most revenue?
--------------------------------------------------------------------------------

SELECT

    p.SubcategoryName,

    SUM(f.NetSales) AS SalesRevenue

FROM gold.fact_sales f

INNER JOIN gold.dim_product p
ON f.ProductID=p.ProductID

GROUP BY
    p.SubcategoryName

ORDER BY
    SalesRevenue DESC;

--------------------------------------------------------------------------------
-- 10. Most Profitable Products
--------------------------------------------------------------------------------
-- Business Question:
-- Which products have the highest profit margin?
--------------------------------------------------------------------------------

SELECT TOP 10

    ProductName,

    ProfitMargin,

    ProfitMarginPct

FROM gold.dim_product

ORDER BY
    ProfitMargin DESC;

--------------------------------------------------------------------------------
-- 11. Top 10 Customers by Revenue
--------------------------------------------------------------------------------
-- Business Question:
-- Who are the highest-value customers?
--------------------------------------------------------------------------------

SELECT TOP 10

    c.FullName,

    SUM(f.NetSales) AS TotalSales,

    COUNT(DISTINCT SalesOrderID) AS TotalOrders

FROM gold.fact_sales f

INNER JOIN gold.dim_customer c
ON f.CustomerID=c.CustomerID

GROUP BY
    c.FullName

ORDER BY
    TotalSales DESC;

--------------------------------------------------------------------------------
-- 12. Sales by Customer Type
--------------------------------------------------------------------------------
-- Business Question:
-- Which customer type contributes the highest revenue?
--------------------------------------------------------------------------------

SELECT

    c.CustomerType,

    SUM(f.NetSales) AS Revenue,

    COUNT(DISTINCT f.CustomerID) AS Customers

FROM gold.fact_sales f

INNER JOIN gold.dim_customer c
ON f.CustomerID=c.CustomerID

GROUP BY
    c.CustomerType

ORDER BY
    Revenue DESC;

--------------------------------------------------------------------------------
-- 13. Sales by Territory
--------------------------------------------------------------------------------
-- Business Question:
-- Which sales territories perform the best?
--------------------------------------------------------------------------------

SELECT

    t.TerritoryName,

    t.TerritoryGroup,

    SUM(f.NetSales) AS Revenue

FROM gold.fact_sales f

INNER JOIN gold.dim_sales_territory t
ON f.TerritoryID=t.TerritoryID

GROUP BY
    t.TerritoryName,
    t.TerritoryGroup

ORDER BY
    Revenue DESC;

--------------------------------------------------------------------------------
-- 14. Promotion Effectiveness
--------------------------------------------------------------------------------
-- Business Question:
-- Which promotions generate the highest sales?
--------------------------------------------------------------------------------

SELECT

    p.Description,

    AVG(p.DiscountPct) AS AverageDiscount,

    SUM(f.NetSales) AS Revenue,

    SUM(f.OrderQty) AS UnitsSold

FROM gold.fact_sales f

INNER JOIN gold.dim_promotion p
ON f.SpecialOfferID=p.SpecialOfferID

GROUP BY
    p.Description

ORDER BY
    Revenue DESC;

--------------------------------------------------------------------------------
-- 15. Discount Analysis
--------------------------------------------------------------------------------
-- Business Question:
-- How much discount is given overall?
--------------------------------------------------------------------------------

SELECT

    SUM(DiscountAmount) AS TotalDiscount,

    AVG(UnitPriceDiscount) AS AverageDiscountPerOrder,

    MAX(UnitPriceDiscount) AS MaximumDiscount

FROM gold.fact_sales;

--------------------------------------------------------------------------------
-- 16. Shipping Performance
--------------------------------------------------------------------------------
-- Business Question:
-- How efficient is the shipping process?
--------------------------------------------------------------------------------

SELECT

    AVG(ShippingDays) AS AverageShippingDays,

    SUM(CASE WHEN IsLateShipment=1 THEN 1 ELSE 0 END) AS LateShipments,

    COUNT(*) AS TotalShipments,

    CAST(
        100.0 *
        SUM(CASE WHEN IsLateShipment=1 THEN 1 ELSE 0 END)
        / COUNT(*)
    AS DECIMAL(5,2)) AS LateShipmentPercentage

FROM gold.fact_sales;

--------------------------------------------------------------------------------
-- 17. Online vs Offline Sales
--------------------------------------------------------------------------------
-- Business Question:
-- What percentage of sales come from online orders?
--------------------------------------------------------------------------------

SELECT

    CASE
        WHEN OnlineOrderFlag=1 THEN 'Online'
        ELSE 'Offline'
    END AS OrderChannel,

    SUM(NetSales) AS Revenue,

    COUNT(*) AS Orders

FROM gold.fact_sales

GROUP BY
    OnlineOrderFlag;

--------------------------------------------------------------------------------
-- 18. Order Status Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- What is the distribution of sales order statuses?
--------------------------------------------------------------------------------

SELECT

    Status,

    COUNT(*) AS Orders

FROM gold.fact_sales

GROUP BY
    Status

ORDER BY
    Status;

--------------------------------------------------------------------------------
-- 19. Average Selling Price by Category
--------------------------------------------------------------------------------
-- Business Question:
-- Which product category has the highest average selling price?
--------------------------------------------------------------------------------

SELECT

    p.CategoryName,

    AVG(f.UnitPrice) AS AverageSellingPrice

FROM gold.fact_sales f

INNER JOIN gold.dim_product p
ON f.ProductID=p.ProductID

GROUP BY
    p.CategoryName

ORDER BY
    AverageSellingPrice DESC;

--------------------------------------------------------------------------------
-- 20. Executive Summary
--------------------------------------------------------------------------------
-- Business Question:
-- What are the most important business KPIs for executives?
--
-- Insight:
-- These metrics become KPI cards in the Executive Dashboard.
--------------------------------------------------------------------------------

SELECT

    SUM(NetSales) AS TotalSales,

    COUNT(DISTINCT SalesOrderID) AS TotalOrders,

    SUM(OrderQty) AS UnitsSold,

    AVG(NetSales) AS AverageOrderValue,

    SUM(DiscountAmount) AS TotalDiscount,

    AVG(ShippingDays) AS AverageShippingDays,

    CAST(
        100.0 *
        SUM(CASE WHEN IsLateShipment=1 THEN 1 ELSE 0 END)
        / COUNT(*)
    AS DECIMAL(5,2)) AS LateShipmentPercentage

FROM gold.fact_sales;

PRINT '=========================================================';
PRINT 'Sales Analytics EDA Completed';
PRINT '=========================================================';





/*
===============================================================================
Exploratory Data Analysis (EDA) - Customer Analytics
===============================================================================
Business Domain:
    Customer Analytics

Business Objective:
    Analyze customer demographics, purchasing behavior, customer segmentation,
    regional distribution, and customer value to support marketing and sales
    decision-making.

Data Source:
    gold.fact_sales
    gold.dim_customer
    gold.dim_sales_territory

===============================================================================
*/

PRINT '=========================================================';
PRINT 'EDA - CUSTOMER ANALYTICS';
PRINT '=========================================================';

--------------------------------------------------------------------------------
-- 1. Total Customers
--------------------------------------------------------------------------------
-- Business Question:
-- How many customers does the company have?
--
-- Insight:
-- Provides the total customer base.
-- KPI Card: Total Customers
--------------------------------------------------------------------------------

SELECT
    COUNT(*) AS TotalCustomers
FROM gold.dim_customer;

--------------------------------------------------------------------------------
-- 2. Customer Type Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- What types of customers does the company serve?
--
-- Insight:
-- Identifies whether sales are driven by Individuals or Stores.
-- Useful for customer segmentation.
--------------------------------------------------------------------------------

SELECT
    CustomerType,
    COUNT(*) AS TotalCustomers
FROM gold.dim_customer
GROUP BY CustomerType
ORDER BY TotalCustomers DESC;

--------------------------------------------------------------------------------
-- 3. Customers by Sales Territory
--------------------------------------------------------------------------------
-- Business Question:
-- Which sales territories have the largest customer base?
--
-- Insight:
-- Helps identify regions with the highest customer concentration.
--------------------------------------------------------------------------------

SELECT

    t.TerritoryName,

    t.TerritoryGroup,

    COUNT(c.CustomerID) AS TotalCustomers

FROM gold.dim_customer c

LEFT JOIN gold.dim_sales_territory t
ON c.TerritoryID = t.TerritoryID

GROUP BY

    t.TerritoryName,

    t.TerritoryGroup

ORDER BY
    TotalCustomers DESC;

--------------------------------------------------------------------------------
-- 4. Customers by Store
--------------------------------------------------------------------------------
-- Business Question:
-- Which stores have the highest number of registered customers?
--
-- Insight:
-- Measures customer distribution across stores.
--------------------------------------------------------------------------------

SELECT

    StoreName,

    COUNT(*) AS Customers

FROM gold.dim_customer

WHERE StoreName IS NOT NULL

GROUP BY
    StoreName

ORDER BY
    Customers DESC;

--------------------------------------------------------------------------------
-- 5. Top 10 Customers by Revenue
--------------------------------------------------------------------------------
-- Business Question:
-- Which customers generate the highest revenue?
--
-- Insight:
-- Identifies VIP customers for retention and loyalty programs.
--------------------------------------------------------------------------------

SELECT TOP 10

    c.FullName,

    SUM(f.NetSales) AS TotalRevenue,

    COUNT(DISTINCT f.SalesOrderID) AS TotalOrders,

    SUM(f.OrderQty) AS TotalUnitsPurchased

FROM gold.fact_sales f

INNER JOIN gold.dim_customer c
ON f.CustomerID = c.CustomerID

GROUP BY
    c.FullName

ORDER BY
    TotalRevenue DESC;

--------------------------------------------------------------------------------
-- 6. Bottom 10 Customers by Revenue
--------------------------------------------------------------------------------
-- Business Question:
-- Which customers generate the lowest revenue?
--
-- Insight:
-- Identifies inactive or low-value customers for marketing campaigns.
--------------------------------------------------------------------------------

SELECT TOP 10

    c.FullName,

    SUM(f.NetSales) AS TotalRevenue

FROM gold.fact_sales f

INNER JOIN gold.dim_customer c
ON f.CustomerID = c.CustomerID

GROUP BY
    c.FullName

ORDER BY
    TotalRevenue ASC;

--------------------------------------------------------------------------------
-- 7. Average Revenue per Customer
--------------------------------------------------------------------------------
-- Business Question:
-- How much revenue does each customer generate on average?
--
-- Insight:
-- Measures average customer value.
--------------------------------------------------------------------------------

SELECT

    AVG(CustomerRevenue) AS AverageRevenuePerCustomer

FROM
(
    SELECT

        CustomerID,

        SUM(NetSales) AS CustomerRevenue

    FROM gold.fact_sales

    GROUP BY CustomerID

) AS CustomerSales;

--------------------------------------------------------------------------------
-- 8. Average Orders per Customer
--------------------------------------------------------------------------------
-- Business Question:
-- How frequently do customers place orders?
--
-- Insight:
-- Indicates customer engagement and purchasing frequency.
--------------------------------------------------------------------------------

SELECT

    AVG(OrderCount) AS AverageOrdersPerCustomer

FROM
(
    SELECT

        CustomerID,

        COUNT(DISTINCT SalesOrderID) AS OrderCount

    FROM gold.fact_sales

    GROUP BY CustomerID

) AS CustomerOrders;

--------------------------------------------------------------------------------
-- 9. Average Order Value by Customer Type
--------------------------------------------------------------------------------
-- Business Question:
-- Which customer type spends more per order?
--
-- Insight:
-- Helps compare purchasing behavior between customer segments.
--------------------------------------------------------------------------------

SELECT

    c.CustomerType,

    AVG(f.NetSales) AS AverageOrderValue

FROM gold.fact_sales f

INNER JOIN gold.dim_customer c
ON f.CustomerID = c.CustomerID

GROUP BY
    c.CustomerType

ORDER BY
    AverageOrderValue DESC;

--------------------------------------------------------------------------------
-- 10. Customer Revenue by Territory
--------------------------------------------------------------------------------
-- Business Question:
-- Which territory contributes the highest customer revenue?
--
-- Insight:
-- Measures regional customer value.
--------------------------------------------------------------------------------

SELECT

    t.TerritoryName,

    SUM(f.NetSales) AS Revenue

FROM gold.fact_sales f

INNER JOIN gold.dim_customer c
ON f.CustomerID = c.CustomerID

INNER JOIN gold.dim_sales_territory t
ON c.TerritoryID = t.TerritoryID

GROUP BY
    t.TerritoryName

ORDER BY
    Revenue DESC;

--------------------------------------------------------------------------------
-- 11. Customer Purchase Quantity
--------------------------------------------------------------------------------
-- Business Question:
-- Which customers purchase the largest quantity of products?
--
-- Insight:
-- Identifies high-volume buyers.
--------------------------------------------------------------------------------

SELECT TOP 10

    c.FullName,

    SUM(f.OrderQty) AS TotalQuantity

FROM gold.fact_sales f

INNER JOIN gold.dim_customer c
ON f.CustomerID = c.CustomerID

GROUP BY
    c.FullName

ORDER BY
    TotalQuantity DESC;

--------------------------------------------------------------------------------
-- 12. Customer Discount Analysis
--------------------------------------------------------------------------------
-- Business Question:
-- Which customers receive the highest discounts?
--
-- Insight:
-- Helps evaluate pricing and discount strategies.
--------------------------------------------------------------------------------

SELECT TOP 10

    c.FullName,

    SUM(f.DiscountAmount) AS TotalDiscount

FROM gold.fact_sales f

INNER JOIN gold.dim_customer c
ON f.CustomerID = c.CustomerID

GROUP BY
    c.FullName

ORDER BY
    TotalDiscount DESC;

--------------------------------------------------------------------------------
-- 13. Customer Shipping Performance
--------------------------------------------------------------------------------
-- Business Question:
-- Do some customers experience longer shipping times?
--
-- Insight:
-- Identifies customers affected by delivery delays.
--------------------------------------------------------------------------------

SELECT

    c.FullName,

    AVG(f.ShippingDays) AS AverageShippingDays

FROM gold.fact_sales f

INNER JOIN gold.dim_customer c
ON f.CustomerID = c.CustomerID

GROUP BY
    c.FullName

ORDER BY
    AverageShippingDays DESC;

--------------------------------------------------------------------------------
-- 14. Online vs Offline Customers
--------------------------------------------------------------------------------
-- Business Question:
-- How do customers place their orders?
--
-- Insight:
-- Measures customer preference for online or offline purchasing.
--------------------------------------------------------------------------------

SELECT

    CASE

        WHEN OnlineOrderFlag = 1 THEN 'Online'

        ELSE 'Offline'

    END AS OrderChannel,

    COUNT(DISTINCT CustomerID) AS Customers,

    SUM(NetSales) AS Revenue

FROM gold.fact_sales

GROUP BY
    OnlineOrderFlag;

--------------------------------------------------------------------------------
-- 15. Executive Customer Summary
--------------------------------------------------------------------------------
-- Business Question:
-- What are the most important customer KPIs?
--
-- Insight:
-- These KPIs become cards in the Customer Dashboard.
--------------------------------------------------------------------------------

SELECT

    COUNT(DISTINCT CustomerID) AS TotalCustomers,

    COUNT(DISTINCT SalesOrderID) AS TotalOrders,

    SUM(NetSales) AS TotalRevenue,

    AVG(NetSales) AS AverageOrderValue,

    SUM(OrderQty) AS TotalUnitsSold,

    AVG(ShippingDays) AS AverageShippingDays

FROM gold.fact_sales;

PRINT '=========================================================';
PRINT 'Customer Analytics EDA Completed';
PRINT '=========================================================';



/*
===============================================================================
Exploratory Data Analysis (EDA) - Product & Inventory Analytics
===============================================================================
Business Domain:
    Product & Inventory Analytics

Business Objective:
    Analyze product catalog, pricing, profitability, inventory levels,
    warehouse utilization, stock movement, and inventory health to support
    inventory planning, warehouse management, and product decision-making.

Data Source:
    gold.dim_product
    gold.fact_inventory
    gold.dim_location

===============================================================================
*/

PRINT '=========================================================';
PRINT 'EDA - PRODUCT & INVENTORY ANALYTICS';
PRINT '=========================================================';

--------------------------------------------------------------------------------
-- 1. Product Catalog Overview
--------------------------------------------------------------------------------
-- Business Question:
-- How many products are available in the catalog?
--
-- Insight:
-- Provides the total number of products managed by the business.
-- KPI Card: Total Products
--------------------------------------------------------------------------------

SELECT
    COUNT(*) AS TotalProducts
FROM gold.dim_product;

--------------------------------------------------------------------------------
-- 2. Products by Category
--------------------------------------------------------------------------------
-- Business Question:
-- Which product categories contain the most products?
--
-- Insight:
-- Identifies the largest product categories.
--------------------------------------------------------------------------------

SELECT

    CategoryName,

    COUNT(*) AS TotalProducts

FROM gold.dim_product

GROUP BY
    CategoryName

ORDER BY
    TotalProducts DESC;

--------------------------------------------------------------------------------
-- 3. Products by Subcategory
--------------------------------------------------------------------------------
-- Business Question:
-- Which subcategories contain the most products?
--
-- Insight:
-- Helps understand product distribution.
--------------------------------------------------------------------------------

SELECT

    CategoryName,

    SubcategoryName,

    COUNT(*) AS TotalProducts

FROM gold.dim_product

GROUP BY

    CategoryName,

    SubcategoryName

ORDER BY
    TotalProducts DESC;

--------------------------------------------------------------------------------
-- 4. Product Status Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- How many products are Active, Discontinued, etc.?
--
-- Insight:
-- Measures the lifecycle of products.
--------------------------------------------------------------------------------

SELECT

    ProductStatus,

    COUNT(*) AS Products

FROM gold.dim_product

GROUP BY
    ProductStatus

ORDER BY
    Products DESC;

--------------------------------------------------------------------------------
-- 5. Price Category Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- How are products distributed across pricing segments?
--
-- Insight:
-- Understands pricing strategy.
--------------------------------------------------------------------------------

SELECT

    PriceCategory,

    COUNT(*) AS Products

FROM gold.dim_product

GROUP BY
    PriceCategory

ORDER BY
    Products DESC;

--------------------------------------------------------------------------------
-- 6. Average Product Cost & Selling Price
--------------------------------------------------------------------------------
-- Business Question:
-- What is the average manufacturing cost and selling price?
--
-- Insight:
-- Measures pricing efficiency.
--------------------------------------------------------------------------------

SELECT

    AVG(StandardCost) AS AverageCost,

    AVG(ListPrice) AS AverageSellingPrice,

    AVG(ProfitMargin) AS AverageProfitMargin

FROM gold.dim_product;

--------------------------------------------------------------------------------
-- 7. Most Expensive Products
--------------------------------------------------------------------------------
-- Business Question:
-- Which products have the highest selling price?
--
-- Insight:
-- Identifies premium products.
--------------------------------------------------------------------------------

SELECT TOP 10

    ProductName,

    CategoryName,

    ListPrice

FROM gold.dim_product

ORDER BY
    ListPrice DESC;

--------------------------------------------------------------------------------
-- 8. Highest Profit Margin Products
--------------------------------------------------------------------------------
-- Business Question:
-- Which products generate the highest profit?
--
-- Insight:
-- Useful for product portfolio optimization.
--------------------------------------------------------------------------------

SELECT TOP 10

    ProductName,

    CategoryName,

    ProfitMargin,

    ProfitMarginPct

FROM gold.dim_product

ORDER BY
    ProfitMargin DESC;

--------------------------------------------------------------------------------
-- 9. Inventory Overview
--------------------------------------------------------------------------------
-- Business Question:
-- What is the current inventory status?
--
-- Insight:
-- Executive inventory KPIs.
--------------------------------------------------------------------------------

SELECT

    SUM(Quantity) AS TotalInventoryUnits,

    SUM(InventoryValue) AS TotalInventoryValue,

    AVG(InventoryAge) AS AverageInventoryAge

FROM gold.fact_inventory;

--------------------------------------------------------------------------------
-- 10. Inventory by Warehouse
--------------------------------------------------------------------------------
-- Business Question:
-- Which warehouse stores the most inventory?
--
-- Insight:
-- Identifies warehouse utilization.
--------------------------------------------------------------------------------

SELECT

    l.FullAddress,

    SUM(f.Quantity) AS TotalStock,

    SUM(f.InventoryValue) AS InventoryValue

FROM gold.fact_inventory f

INNER JOIN gold.dim_location l
ON f.LocationID = l.AddressID

GROUP BY
    l.FullAddress

ORDER BY
    TotalStock DESC;

--------------------------------------------------------------------------------
-- 11. Inventory by Product Category
--------------------------------------------------------------------------------
-- Business Question:
-- Which product categories occupy the largest inventory?
--
-- Insight:
-- Supports inventory planning.
--------------------------------------------------------------------------------

SELECT

    p.CategoryName,

    SUM(f.Quantity) AS StockQuantity,

    SUM(f.InventoryValue) AS InventoryValue

FROM gold.fact_inventory f

INNER JOIN gold.dim_product p
ON f.ProductID = p.ProductID

GROUP BY
    p.CategoryName

ORDER BY
    InventoryValue DESC;

--------------------------------------------------------------------------------
-- 12. Stock Status Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- How many products are In Stock, Low Stock, or Out of Stock?
--
-- Insight:
-- Inventory health monitoring.
--------------------------------------------------------------------------------

SELECT

    StockStatus,

    COUNT(*) AS Products

FROM gold.fact_inventory

GROUP BY
    StockStatus

ORDER BY
    Products DESC;

--------------------------------------------------------------------------------
-- 13. Low Stock Products
--------------------------------------------------------------------------------
-- Business Question:
-- Which products require replenishment?
--
-- Insight:
-- Supports procurement planning.
--------------------------------------------------------------------------------

SELECT

    p.ProductName,

    f.Quantity,

    f.StockStatus

FROM gold.fact_inventory f

INNER JOIN gold.dim_product p
ON f.ProductID = p.ProductID

WHERE
    StockStatus = 'Low Stock'

ORDER BY
    Quantity ASC;

--------------------------------------------------------------------------------
-- 14. Out of Stock Products
--------------------------------------------------------------------------------
-- Business Question:
-- Which products are unavailable?
--
-- Insight:
-- Identifies stock-out risks.
--------------------------------------------------------------------------------

SELECT

    p.ProductName,

    f.Quantity

FROM gold.fact_inventory f

INNER JOIN gold.dim_product p
ON f.ProductID = p.ProductID

WHERE
    StockStatus = 'Out of Stock';

--------------------------------------------------------------------------------
-- 15. Highest Inventory Value Products
--------------------------------------------------------------------------------
-- Business Question:
-- Which products contribute the most inventory value?
--
-- Insight:
-- Identifies high-value inventory.
--------------------------------------------------------------------------------

SELECT TOP 10

    p.ProductName,

    SUM(f.InventoryValue) AS InventoryValue

FROM gold.fact_inventory f

INNER JOIN gold.dim_product p
ON f.ProductID = p.ProductID

GROUP BY
    p.ProductName

ORDER BY
    InventoryValue DESC;

--------------------------------------------------------------------------------
-- 16. Oldest Inventory
--------------------------------------------------------------------------------
-- Business Question:
-- Which inventory has been stored the longest?
--
-- Insight:
-- Helps identify slow-moving inventory.
--------------------------------------------------------------------------------

SELECT TOP 20

    p.ProductName,

    f.InventoryAge,

    f.Quantity

FROM gold.fact_inventory f

INNER JOIN gold.dim_product p
ON f.ProductID = p.ProductID

ORDER BY
    InventoryAge DESC;

--------------------------------------------------------------------------------
-- 17. Inventory Transactions by Type
--------------------------------------------------------------------------------
-- Business Question:
-- What types of inventory transactions occur most frequently?
--
-- Insight:
-- Understands inventory movement patterns.
--------------------------------------------------------------------------------

SELECT

    TransactionType,

    COUNT(*) AS Transactions,

    SUM(Quantity) AS QuantityMoved

FROM gold.fact_inventory

GROUP BY
    TransactionType

ORDER BY
    Transactions DESC;

--------------------------------------------------------------------------------
-- 18. Warehouse Inventory Value
--------------------------------------------------------------------------------
-- Business Question:
-- Which warehouse stores the highest inventory value?
--
-- Insight:
-- Measures warehouse asset allocation.
--------------------------------------------------------------------------------

SELECT

    l.FullAddress,

    SUM(f.InventoryValue) AS InventoryValue

FROM gold.fact_inventory f

INNER JOIN gold.dim_location l
ON f.LocationID = l.AddressID

GROUP BY
    l.FullAddress

ORDER BY
    InventoryValue DESC;

--------------------------------------------------------------------------------
-- 19. Products Requiring Long Manufacturing Time
--------------------------------------------------------------------------------
-- Business Question:
-- Which products require the longest manufacturing time?
--
-- Insight:
-- Useful for production planning.
--------------------------------------------------------------------------------

SELECT TOP 10

    ProductName,

    DaysToManufacture

FROM gold.dim_product

ORDER BY
    DaysToManufacture DESC;

--------------------------------------------------------------------------------
-- 20. Executive Product & Inventory Summary
--------------------------------------------------------------------------------
-- Business Question:
-- What are the key product and inventory KPIs?
--
-- Insight:
-- KPI cards for the Product & Inventory dashboard.
--------------------------------------------------------------------------------

SELECT

    (SELECT COUNT(*) FROM gold.dim_product) AS TotalProducts,

    SUM(Quantity) AS TotalInventoryUnits,

    SUM(InventoryValue) AS TotalInventoryValue,

    AVG(InventoryAge) AS AverageInventoryAge,

    COUNT(DISTINCT LocationID) AS Warehouses,

    COUNT(DISTINCT ProductID) AS InventoryProducts

FROM gold.fact_inventory;

PRINT '=========================================================';
PRINT 'Product & Inventory Analytics EDA Completed';
PRINT '=========================================================';



/*
===============================================================================
Exploratory Data Analysis (EDA) - Procurement Analytics
===============================================================================
Business Domain:
    Procurement Analytics

Business Objective:
    Analyze purchasing activities, vendor performance, procurement costs,
    delivery efficiency, receiving quality, and employee purchasing performance
    to support procurement decision-making and supply chain optimization.

Data Source:
    gold.fact_purchase
    gold.dim_vendor
    gold.dim_product
    gold.dim_employee

===============================================================================
*/

PRINT '=========================================================';
PRINT 'EDA - PROCUREMENT ANALYTICS';
PRINT '=========================================================';

--------------------------------------------------------------------------------
-- 1. Procurement Overview
--------------------------------------------------------------------------------
-- Business Question:
-- What is the overall procurement performance?
--
-- Insight:
-- Provides high-level procurement KPIs including total purchase cost,
-- purchase orders, purchased quantity, and average delivery time.
--------------------------------------------------------------------------------

SELECT

    SUM(TotalDue) AS TotalProcurementCost,

    COUNT(DISTINCT PurchaseOrderID) AS TotalPurchaseOrders,

    SUM(OrderQty) AS TotalPurchasedQuantity,

    AVG(DeliveryDays) AS AverageDeliveryDays,

    AVG(ReceivedPercentage) AS AverageReceivedPercentage,

    AVG(RejectedPercentage) AS AverageRejectedPercentage

FROM gold.fact_purchase;

--------------------------------------------------------------------------------
-- 2. Procurement Trend by Year
--------------------------------------------------------------------------------
-- Business Question:
-- How has procurement spending changed over time?
--
-- Insight:
-- Identifies yearly procurement trends.
--------------------------------------------------------------------------------

SELECT

    YEAR(OrderDate) AS PurchaseYear,

    SUM(TotalDue) AS ProcurementCost,

    COUNT(DISTINCT PurchaseOrderID) AS PurchaseOrders

FROM gold.fact_purchase

GROUP BY
    YEAR(OrderDate)

ORDER BY
    PurchaseYear;

--------------------------------------------------------------------------------
-- 3. Procurement Trend by Month
--------------------------------------------------------------------------------
-- Business Question:
-- Which months have the highest procurement cost?
--
-- Insight:
-- Useful for seasonal procurement planning.
--------------------------------------------------------------------------------

SELECT

    YEAR(OrderDate) AS PurchaseYear,

    MONTH(OrderDate) AS PurchaseMonth,

    SUM(TotalDue) AS ProcurementCost

FROM gold.fact_purchase

GROUP BY

    YEAR(OrderDate),

    MONTH(OrderDate)

ORDER BY

    PurchaseYear,

    PurchaseMonth;

--------------------------------------------------------------------------------
-- 4. Top Vendors by Procurement Cost
--------------------------------------------------------------------------------
-- Business Question:
-- Which vendors receive the highest procurement spending?
--
-- Insight:
-- Identifies strategic suppliers.
--------------------------------------------------------------------------------

SELECT TOP 10

    v.VendorName,

    SUM(f.TotalDue) AS ProcurementCost,

    COUNT(DISTINCT f.PurchaseOrderID) AS PurchaseOrders

FROM gold.fact_purchase f

INNER JOIN gold.dim_vendor v
ON f.VendorID = v.VendorID

GROUP BY
    v.VendorName

ORDER BY
    ProcurementCost DESC;

--------------------------------------------------------------------------------
-- 5. Vendors with Lowest Procurement Cost
--------------------------------------------------------------------------------
-- Business Question:
-- Which vendors receive the lowest procurement spending?
--
-- Insight:
-- Helps identify inactive suppliers.
--------------------------------------------------------------------------------

SELECT TOP 10

    v.VendorName,

    SUM(f.TotalDue) AS ProcurementCost

FROM gold.fact_purchase f

INNER JOIN gold.dim_vendor v
ON f.VendorID = v.VendorID

GROUP BY
    v.VendorName

ORDER BY
    ProcurementCost ASC;

--------------------------------------------------------------------------------
-- 6. Procurement Cost by Product Category
--------------------------------------------------------------------------------
-- Business Question:
-- Which product categories require the highest purchasing investment?
--
-- Insight:
-- Helps understand procurement allocation.
--------------------------------------------------------------------------------

SELECT

    p.CategoryName,

    SUM(f.TotalDue) AS ProcurementCost

FROM gold.fact_purchase f

INNER JOIN gold.dim_product p
ON f.ProductID = p.ProductID

GROUP BY
    p.CategoryName

ORDER BY
    ProcurementCost DESC;

--------------------------------------------------------------------------------
-- 7. Top Purchased Products
--------------------------------------------------------------------------------
-- Business Question:
-- Which products are purchased most frequently?
--
-- Insight:
-- Identifies high-demand products.
--------------------------------------------------------------------------------

SELECT TOP 10

    p.ProductName,

    SUM(f.OrderQty) AS PurchasedQuantity,

    SUM(f.TotalDue) AS ProcurementCost

FROM gold.fact_purchase f

INNER JOIN gold.dim_product p
ON f.ProductID = p.ProductID

GROUP BY
    p.ProductName

ORDER BY
    PurchasedQuantity DESC;

--------------------------------------------------------------------------------
-- 8. Vendor Lead Time Analysis
--------------------------------------------------------------------------------
-- Business Question:
-- Which vendors have the longest average lead time?
--
-- Insight:
-- Identifies suppliers that may impact supply chain efficiency.
--------------------------------------------------------------------------------

SELECT

    VendorName,

    AverageLeadTime,

    LeadTimeCategory

FROM gold.dim_vendor

ORDER BY
    AverageLeadTime DESC;

--------------------------------------------------------------------------------
-- 9. Vendor Credit Rating Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- What is the distribution of vendor credit ratings?
--
-- Insight:
-- Evaluates supplier reliability.
--------------------------------------------------------------------------------

SELECT

    CreditRating,

    COUNT(*) AS Vendors

FROM gold.dim_vendor

GROUP BY
    CreditRating

ORDER BY
    CreditRating;

--------------------------------------------------------------------------------
-- 10. Preferred Vendor Analysis
--------------------------------------------------------------------------------
-- Business Question:
-- How many vendors are preferred suppliers?
--
-- Insight:
-- Measures dependence on preferred vendors.
--------------------------------------------------------------------------------

SELECT

    CASE

        WHEN PreferredVendorStatus = 1 THEN 'Preferred'

        ELSE 'Non-Preferred'

    END AS VendorType,

    COUNT(*) AS Vendors

FROM gold.dim_vendor

GROUP BY
    PreferredVendorStatus;

--------------------------------------------------------------------------------
-- 11. Delivery Performance
--------------------------------------------------------------------------------
-- Business Question:
-- How efficient is product delivery?
--
-- Insight:
-- Measures average delivery duration.
--------------------------------------------------------------------------------

SELECT

    AVG(DeliveryDays) AS AverageDeliveryDays,

    MIN(DeliveryDays) AS MinimumDeliveryDays,

    MAX(DeliveryDays) AS MaximumDeliveryDays

FROM gold.fact_purchase;

--------------------------------------------------------------------------------
-- 12. Receiving Performance
--------------------------------------------------------------------------------
-- Business Question:
-- What percentage of ordered goods are successfully received?
--
-- Insight:
-- Evaluates receiving efficiency.
--------------------------------------------------------------------------------

SELECT

    AVG(ReceivedPercentage) AS AverageReceivedPercentage,

    AVG(RejectedPercentage) AS AverageRejectedPercentage,

    SUM(ReceivedQty) AS TotalReceived,

    SUM(RejectedQty) AS TotalRejected

FROM gold.fact_purchase;

--------------------------------------------------------------------------------
-- 13. Highest Rejection Rate Vendors
--------------------------------------------------------------------------------
-- Business Question:
-- Which vendors have the highest rejection percentage?
--
-- Insight:
-- Identifies potential quality issues.
--------------------------------------------------------------------------------

SELECT TOP 10

    v.VendorName,

    AVG(f.RejectedPercentage) AS AverageRejectedPercentage

FROM gold.fact_purchase f

INNER JOIN gold.dim_vendor v
ON f.VendorID = v.VendorID

GROUP BY
    v.VendorName

ORDER BY
    AverageRejectedPercentage DESC;

--------------------------------------------------------------------------------
-- 14. Employee Procurement Performance
--------------------------------------------------------------------------------
-- Business Question:
-- Which employees manage the largest procurement volume?
--
-- Insight:
-- Measures procurement workload by employee.
--------------------------------------------------------------------------------

SELECT

    e.FullName,

    COUNT(DISTINCT f.PurchaseOrderID) AS PurchaseOrders,

    SUM(f.TotalDue) AS ProcurementCost

FROM gold.fact_purchase f

INNER JOIN gold.dim_employee e
ON f.EmployeeID = e.EmployeeID

GROUP BY
    e.FullName

ORDER BY
    ProcurementCost DESC;

--------------------------------------------------------------------------------
-- 15. Procurement by Department
--------------------------------------------------------------------------------
-- Business Question:
-- Which departments are responsible for the highest procurement activity?
--
-- Insight:
-- Helps evaluate departmental purchasing responsibilities.
--------------------------------------------------------------------------------

SELECT

    e.DepartmentName,

    SUM(f.TotalDue) AS ProcurementCost,

    COUNT(DISTINCT f.PurchaseOrderID) AS PurchaseOrders

FROM gold.fact_purchase f

INNER JOIN gold.dim_employee e
ON f.EmployeeID = e.EmployeeID

GROUP BY
    e.DepartmentName

ORDER BY
    ProcurementCost DESC;

--------------------------------------------------------------------------------
-- 16. Vendor Status Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- How many vendors are active or inactive?
--
-- Insight:
-- Measures supplier availability.
--------------------------------------------------------------------------------

SELECT

    VendorStatus,

    COUNT(*) AS Vendors

FROM gold.dim_vendor

GROUP BY
    VendorStatus;

--------------------------------------------------------------------------------
-- 17. Product Receiving Efficiency
--------------------------------------------------------------------------------
-- Business Question:
-- Which products have the highest receiving efficiency?
--
-- Insight:
-- Helps identify products with smooth procurement operations.
--------------------------------------------------------------------------------

SELECT TOP 10

    p.ProductName,

    AVG(f.ReceivedPercentage) AS AverageReceivedPercentage

FROM gold.fact_purchase f

INNER JOIN gold.dim_product p
ON f.ProductID = p.ProductID

GROUP BY
    p.ProductName

ORDER BY
    AverageReceivedPercentage DESC;

--------------------------------------------------------------------------------
-- 18. Executive Procurement Summary
--------------------------------------------------------------------------------
-- Business Question:
-- What are the key procurement KPIs?
--
-- Insight:
-- KPI cards for the Procurement Dashboard.
--------------------------------------------------------------------------------

SELECT

    SUM(TotalDue) AS TotalProcurementCost,

    COUNT(DISTINCT PurchaseOrderID) AS PurchaseOrders,

    SUM(OrderQty) AS PurchasedQuantity,

    AVG(DeliveryDays) AS AverageDeliveryDays,

    AVG(ReceivedPercentage) AS AverageReceivedPercentage,

    AVG(RejectedPercentage) AS AverageRejectedPercentage,

    COUNT(DISTINCT VendorID) AS TotalVendors

FROM gold.fact_purchase;

PRINT '=========================================================';
PRINT 'Procurement Analytics EDA Completed';
PRINT '=========================================================';



/*
===============================================================================
Exploratory Data Analysis (EDA) - Human Resources (HR) Analytics
===============================================================================
Business Domain:
    Human Resources (HR)

Business Objective:
    Analyze workforce distribution, employee demographics, compensation,
    experience, hiring trends, department performance, and employee status
    to support workforce planning and strategic HR decision-making.

Data Source:
    gold.dim_employee

===============================================================================
*/

PRINT '=========================================================';
PRINT 'EDA - HUMAN RESOURCES ANALYTICS';
PRINT '=========================================================';

--------------------------------------------------------------------------------
-- 1. Workforce Overview
--------------------------------------------------------------------------------
-- Business Question:
-- What is the overall workforce profile?
--
-- Insight:
-- Provides executive HR KPIs such as total employees, average age,
-- average experience, and average hourly rate.
--------------------------------------------------------------------------------

SELECT

    COUNT(*) AS TotalEmployees,

    AVG(Age) AS AverageAge,

    AVG(YearsExperience) AS AverageExperience,

    AVG(HourlyRate) AS AverageHourlyRate

FROM gold.dim_employee;

--------------------------------------------------------------------------------
-- 2. Employees by Department
--------------------------------------------------------------------------------
-- Business Question:
-- Which departments have the highest number of employees?
--
-- Insight:
-- Helps identify workforce distribution across departments.
--------------------------------------------------------------------------------

SELECT

    DepartmentName,

    COUNT(*) AS TotalEmployees

FROM gold.dim_employee

GROUP BY
    DepartmentName

ORDER BY
    TotalEmployees DESC;

--------------------------------------------------------------------------------
-- 3. Employees by Job Title
--------------------------------------------------------------------------------
-- Business Question:
-- Which job roles are most common?
--
-- Insight:
-- Identifies workforce composition by role.
--------------------------------------------------------------------------------

SELECT

    JobTitle,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY
    JobTitle

ORDER BY
    Employees DESC;

--------------------------------------------------------------------------------
-- 4. Employees by Shift
--------------------------------------------------------------------------------
-- Business Question:
-- How are employees distributed across work shifts?
--
-- Insight:
-- Supports workforce scheduling.
--------------------------------------------------------------------------------

SELECT

    ShiftName,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY
    ShiftName

ORDER BY
    Employees DESC;

--------------------------------------------------------------------------------
-- 5. Gender Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- What is the gender distribution of employees?
--
-- Insight:
-- Measures workforce diversity.
--------------------------------------------------------------------------------

SELECT

    CASE

        WHEN Gender='M' THEN 'Male'

        WHEN Gender='F' THEN 'Female'

        ELSE 'Unknown'

    END AS Gender,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY
    Gender

ORDER BY
    Employees DESC;

--------------------------------------------------------------------------------
-- 6. Marital Status Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- What is the marital status distribution of employees?
--
-- Insight:
-- Useful for workforce demographic analysis.
--------------------------------------------------------------------------------

SELECT

    CASE

        WHEN MaritalStatus='M' THEN 'Married'

        WHEN MaritalStatus='S' THEN 'Single'

        ELSE 'Unknown'

    END AS MaritalStatus,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY
    MaritalStatus

ORDER BY
    Employees DESC;

--------------------------------------------------------------------------------
-- 7. Employment Status
--------------------------------------------------------------------------------
-- Business Question:
-- How many employees are Active or Inactive?
--
-- Insight:
-- Monitors workforce availability.
--------------------------------------------------------------------------------

SELECT

    EmploymentStatus,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY
    EmploymentStatus

ORDER BY
    Employees DESC;

--------------------------------------------------------------------------------
-- 8. Salary Band Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- How are employees distributed across salary bands?
--
-- Insight:
-- Helps evaluate compensation structure.
--------------------------------------------------------------------------------

SELECT

    SalaryBand,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY
    SalaryBand

ORDER BY
    Employees DESC;

--------------------------------------------------------------------------------
-- 9. Average Salary by Department
--------------------------------------------------------------------------------
-- Business Question:
-- Which departments have the highest average hourly rate?
--
-- Insight:
-- Compares compensation across departments.
--------------------------------------------------------------------------------

SELECT

    DepartmentName,

    AVG(HourlyRate) AS AverageHourlyRate

FROM gold.dim_employee

GROUP BY
    DepartmentName

ORDER BY
    AverageHourlyRate DESC;

--------------------------------------------------------------------------------
-- 10. Average Experience by Department
--------------------------------------------------------------------------------
-- Business Question:
-- Which departments have the most experienced employees?
--
-- Insight:
-- Identifies departments with senior workforce.
--------------------------------------------------------------------------------

SELECT

    DepartmentName,

    AVG(YearsExperience) AS AverageExperience

FROM gold.dim_employee

GROUP BY
    DepartmentName

ORDER BY
    AverageExperience DESC;

--------------------------------------------------------------------------------
-- 11. Hiring Trend
--------------------------------------------------------------------------------
-- Business Question:
-- How has employee hiring changed over time?
--
-- Insight:
-- Shows recruitment trends by hiring year.
--------------------------------------------------------------------------------

SELECT

    YEAR(HireDate) AS HireYear,

    COUNT(*) AS EmployeesHired

FROM gold.dim_employee

GROUP BY
    YEAR(HireDate)

ORDER BY
    HireYear;

--------------------------------------------------------------------------------
-- 12. Age Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- What is the age distribution of employees?
--
-- Insight:
-- Supports workforce planning and succession management.
--------------------------------------------------------------------------------

SELECT

    CASE

        WHEN Age < 30 THEN 'Below 30'

        WHEN Age BETWEEN 30 AND 39 THEN '30-39'

        WHEN Age BETWEEN 40 AND 49 THEN '40-49'

        WHEN Age BETWEEN 50 AND 59 THEN '50-59'

        ELSE '60+'

    END AS AgeGroup,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY

    CASE

        WHEN Age < 30 THEN 'Below 30'

        WHEN Age BETWEEN 30 AND 39 THEN '30-39'

        WHEN Age BETWEEN 40 AND 49 THEN '40-49'

        WHEN Age BETWEEN 50 AND 59 THEN '50-59'

        ELSE '60+'

    END

ORDER BY
    AgeGroup;

--------------------------------------------------------------------------------
-- 13. Experience Distribution
--------------------------------------------------------------------------------
-- Business Question:
-- How experienced is the workforce?
--
-- Insight:
-- Shows employee experience levels.
--------------------------------------------------------------------------------

SELECT

    CASE

        WHEN YearsExperience < 5 THEN '0-4 Years'

        WHEN YearsExperience BETWEEN 5 AND 9 THEN '5-9 Years'

        WHEN YearsExperience BETWEEN 10 AND 14 THEN '10-14 Years'

        WHEN YearsExperience BETWEEN 15 AND 19 THEN '15-19 Years'

        ELSE '20+ Years'

    END AS ExperienceGroup,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY

    CASE

        WHEN YearsExperience < 5 THEN '0-4 Years'

        WHEN YearsExperience BETWEEN 5 AND 9 THEN '5-9 Years'

        WHEN YearsExperience BETWEEN 10 AND 14 THEN '10-14 Years'

        WHEN YearsExperience BETWEEN 15 AND 19 THEN '15-19 Years'

        ELSE '20+ Years'

    END

ORDER BY
    ExperienceGroup;

--------------------------------------------------------------------------------
-- 14. Vacation & Sick Leave Analysis
--------------------------------------------------------------------------------
-- Business Question:
-- What are the average vacation and sick leave balances?
--
-- Insight:
-- Helps HR monitor employee leave utilization.
--------------------------------------------------------------------------------

SELECT

    AVG(VacationHours) AS AverageVacationHours,

    AVG(SickLeaveHours) AS AverageSickLeaveHours,

    MAX(VacationHours) AS MaximumVacationHours,

    MAX(SickLeaveHours) AS MaximumSickLeaveHours

FROM gold.dim_employee;

--------------------------------------------------------------------------------
-- 15. Top 10 Highest Paid Employees
--------------------------------------------------------------------------------
-- Business Question:
-- Who are the highest paid employees?
--
-- Insight:
-- Identifies employees with the highest hourly compensation.
--------------------------------------------------------------------------------

SELECT TOP 10

    FullName,

    JobTitle,

    DepartmentName,

    HourlyRate

FROM gold.dim_employee

ORDER BY
    HourlyRate DESC;

--------------------------------------------------------------------------------
-- 16. Department Gender Diversity
--------------------------------------------------------------------------------
-- Business Question:
-- How is gender distributed across departments?
--
-- Insight:
-- Evaluates diversity within each department.
--------------------------------------------------------------------------------

SELECT

    DepartmentName,

    CASE

        WHEN Gender='M' THEN 'Male'

        WHEN Gender='F' THEN 'Female'

        ELSE 'Unknown'

    END AS Gender,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY

    DepartmentName,

    Gender

ORDER BY

    DepartmentName,

    Employees DESC;

--------------------------------------------------------------------------------
-- 17. Current Employees
--------------------------------------------------------------------------------
-- Business Question:
-- How many employees are currently active?
--
-- Insight:
-- Measures the active workforce.
--------------------------------------------------------------------------------

SELECT

    CASE

        WHEN CurrentFlag = 1 THEN 'Current Employee'

        ELSE 'Former Employee'

    END AS EmployeeStatus,

    COUNT(*) AS Employees

FROM gold.dim_employee

GROUP BY
    CurrentFlag;

--------------------------------------------------------------------------------
-- 18. Executive HR Summary
--------------------------------------------------------------------------------
-- Business Question:
-- What are the key HR KPIs?
--
-- Insight:
-- KPI cards for the HR Dashboard.
--------------------------------------------------------------------------------

SELECT

    COUNT(*) AS TotalEmployees,

    AVG(Age) AS AverageAge,

    AVG(YearsExperience) AS AverageExperience,

    AVG(HourlyRate) AS AverageHourlyRate,

    SUM(CASE WHEN CurrentFlag = 1 THEN 1 ELSE 0 END) AS ActiveEmployees,

    SUM(CASE WHEN Gender='M' THEN 1 ELSE 0 END) AS MaleEmployees,

    SUM(CASE WHEN Gender='F' THEN 1 ELSE 0 END) AS FemaleEmployees

FROM gold.dim_employee;

PRINT '=========================================================';
PRINT 'HR Analytics EDA Completed';
PRINT '=========================================================';
