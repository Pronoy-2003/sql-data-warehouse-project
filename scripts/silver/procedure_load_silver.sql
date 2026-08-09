/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC silver.load_silver;
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
    BEGIN TRY
        SET @batch_start_time = GETDATE();
        PRINT '================================================';
        PRINT 'Loading Silver Layer';
        PRINT '================================================';

        PRINT '------------------------------------------------';
	    PRINT 'Loading Customer Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.Customer';
        TRUNCATE TABLE silver.Customer;
        PRINT '>> Inserting Data Into: silver.Customer';
        INSERT INTO silver.Customer
        (
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
        )
        SELECT
            c.CustomerID,
            c.PersonID,
            c.StoreID,
            c.TerritoryID,
            p.Title,
            p.FirstName,
            p.MiddleName,
            p.LastName,
            CONCAT(p.FirstName,' ',COALESCE(p.MiddleName + ' ',''),p.LastName),
            e.EmailAddress,
            ph.PhoneNumber,
            s.[Name],
            c.AccountNumber,
            CASE
                WHEN c.StoreID IS NULL THEN 'Individual'
                ELSE 'Store'
            END
        FROM bronze.Customer c
        LEFT JOIN bronze.Person p
            ON c.PersonID = p.BusinessEntityID
        LEFT JOIN bronze.EmailAddress e
            ON p.BusinessEntityID = e.BusinessEntityID
        LEFT JOIN bronze.PersonPhone ph
            ON p.BusinessEntityID = ph.BusinessEntityID
        LEFT JOIN bronze.Store s
            ON c.StoreID = s.BusinessEntityID;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';


        PRINT '------------------------------------------------';
	    PRINT 'Loading Location Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.Location';
        TRUNCATE TABLE silver.[Location];
        PRINT '>> Inserting Data Into: silver.Location';
        INSERT INTO silver.[Location]
        (
            AddressID,
            AddressLine1,
            AddressLine2,
            City,
            StateProvince,
            CountryName,
            PostalCode,
            TerritoryID,
            FullAddress
        )
        SELECT
            a.AddressID,
            a.AddressLine1,
            a.AddressLine2,
            a.City,
            sp.[Name],
            cr.[Name],
            a.PostalCode,
            sp.TerritoryID,
            CONCAT(
                a.AddressLine1,
                ', ',
                ISNULL(a.AddressLine2 + ', ',''),
                a.City,
                ', ',
                sp.[Name],
                ', ',
                cr.[Name]
            )
        FROM bronze.[Address] a
        LEFT JOIN bronze.StateProvince sp
        ON a.StateProvinceID=sp.StateProvinceID
        LEFT JOIN bronze.CountryRegion cr
        ON sp.CountryRegionCode=cr.CountryRegionCode;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';


        PRINT '------------------------------------------------';
	    PRINT 'Loading Product Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.Product';
        TRUNCATE TABLE silver.[Product];
        PRINT '>> Inserting Data Into: silver.Product';
        INSERT INTO silver.[Product]
        (
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
        )
        SELECT
            p.ProductID,
            p.[Name],
            p.ProductNumber,
            pc.[Name],
            ps.[Name],
            p.Color,
            p.[Size],
            p.[Weight],
            p.ProductLine,
            p.Class,
            p.Style,
            p.DaysToManufacture,
            p.StandardCost,
            p.ListPrice,
            p.SellStartDate,
            p.SellEndDate,
            p.DiscontinuedDate,
            p.ListPrice-p.StandardCost,
            CASE
                WHEN p.StandardCost=0 THEN NULL
                ELSE ((p.ListPrice-p.StandardCost)/p.StandardCost)*100
            END,
            CASE
                WHEN p.DiscontinuedDate IS NULL
                THEN 'Active'
                ELSE 'Discontinued'
            END,
            CASE
                WHEN p.ListPrice<100 THEN 'Budget'
                WHEN p.ListPrice<500 THEN 'Standard'
                WHEN p.ListPrice<1000 THEN 'Premium'
                ELSE 'Luxury'
            END
        FROM bronze.[Product] p
        LEFT JOIN bronze.ProductSubcategory ps
        ON p.ProductSubcategoryID=ps.ProductSubcategoryID
        LEFT JOIN bronze.ProductCategory pc
        ON ps.ProductCategoryID=pc.ProductCategoryID;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';



        PRINT '------------------------------------------------';
	    PRINT 'Loading Sales Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.Sales';
        TRUNCATE TABLE silver.Sales;
        PRINT '>> Inserting Data Into: silver.Sales';
        INSERT INTO silver.Sales
        (
            SalesOrderID,
            SalesOrderDetailID,
            OrderDate,
            DueDate,
            ShipDate,
            CustomerID,
            SalesPersonID,
            TerritoryID,
            ShipMethodID,
            ProductID,
            SpecialOfferID,
            OrderQty,
            UnitPrice,
            UnitPriceDiscount,
            LineTotal,
            SubTotal,
            TaxAmt,
            Freight,
            TotalDue,
            Status,
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
        )
        SELECT
            h.SalesOrderID,
            d.SalesOrderDetailID,
            h.OrderDate,
            h.DueDate,
            h.ShipDate,
            h.CustomerID,
            h.SalesPersonID,
            h.TerritoryID,
            h.ShipMethodID,
            d.ProductID,
            d.SpecialOfferID,
            d.OrderQty,
            d.UnitPrice,
            d.UnitPriceDiscount,
            d.LineTotal,
            h.SubTotal,
            h.TaxAmt,
            h.Freight,
            h.TotalDue,
            h.Status,
            h.OnlineOrderFlag,
            d.OrderQty*d.UnitPrice,
            d.OrderQty*d.UnitPrice*d.UnitPriceDiscount,
            (d.OrderQty*d.UnitPrice)-
            (d.OrderQty*d.UnitPrice*d.UnitPriceDiscount),
            DATEDIFF(DAY,h.OrderDate,h.ShipDate),
            YEAR(h.OrderDate),
            DATEPART(QUARTER,h.OrderDate),
            MONTH(h.OrderDate),
            DATEPART(WEEK,h.OrderDate),
            CASE
                WHEN h.ShipDate>h.DueDate THEN 1
                ELSE 0
            END
        FROM bronze.SalesOrderHeader h
        JOIN bronze.SalesOrderDetail d
        ON h.SalesOrderID=d.SalesOrderID;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';



        PRINT '------------------------------------------------';
	    PRINT 'Loading Inventory Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.Inventory';
        TRUNCATE TABLE silver.Inventory;
        PRINT '>> Inserting Data Into: silver.Inventory';
        INSERT INTO silver.Inventory
        (
            ProductID,
            LocationID,
            WarehouseLocationName,
            Shelf,
            Bin,
            Quantity,
            TransactionDate,
            TransactionType,
            ActualCost,
            StandardCost,
            ListPrice,
            InventoryValue,
            StockStatus,
            InventoryAge
        )
        SELECT
            pi.ProductID,
            pi.LocationID,
            l.Name AS WarehouseLocationName,
            pi.Shelf,
            pi.Bin,
            pi.Quantity,
            -- Transaction Date
            ISNULL(th.TransactionDate, pi.ModifiedDate) AS TransactionDate,
            -- Transaction Type
            ISNULL(th.TransactionType, 'N') AS TransactionType,
            -- Actual Cost
            ISNULL(th.ActualCost, p.StandardCost) AS ActualCost,
            -- Standard Cost
            ISNULL(pch.StandardCost, p.StandardCost) AS StandardCost,
            -- List Price
            ISNULL(plph.ListPrice, p.ListPrice) AS ListPrice,
            -- Inventory Value
            pi.Quantity * ISNULL(pch.StandardCost, p.StandardCost) AS InventoryValue,
            -- Stock Status
            CASE
                WHEN pi.Quantity = 0 THEN 'Out of Stock'
                WHEN pi.Quantity < 20 THEN 'Low Stock'
                ELSE 'In Stock'
            END AS StockStatus,
            -- Inventory Age
            DATEDIFF
            (
                DAY,
                ISNULL(th.TransactionDate, pi.ModifiedDate),
                GETDATE()
            ) AS InventoryAge
        FROM bronze.ProductInventory pi
        LEFT JOIN bronze.Location l
            ON pi.LocationID = l.LocationID
        LEFT JOIN bronze.Product p
            ON pi.ProductID = p.ProductID
        LEFT JOIN
        (
            SELECT
                ProductID,
                TransactionDate,
                TransactionType,
                ActualCost,
                ROW_NUMBER() OVER
                (
                    PARTITION BY ProductID
                    ORDER BY TransactionDate DESC
                ) AS rn
            FROM bronze.TransactionHistory
        ) th
        ON pi.ProductID = th.ProductID
        AND th.rn = 1
        LEFT JOIN
        (
            SELECT
                ProductID,
                StandardCost,
                ROW_NUMBER() OVER
                (
                    PARTITION BY ProductID
                    ORDER BY StartDate DESC
                ) AS rn
            FROM bronze.ProductCostHistory
        ) pch
        ON pi.ProductID = pch.ProductID
        AND pch.rn = 1
        LEFT JOIN
        (
            SELECT
                ProductID,
                ListPrice,
                ROW_NUMBER() OVER
                (
                    PARTITION BY ProductID
                    ORDER BY StartDate DESC
                ) AS rn
            FROM bronze.ProductListPriceHistory
        ) plph
        ON pi.ProductID = plph.ProductID
        AND plph.rn = 1;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';



        PRINT '------------------------------------------------';
	    PRINT 'Loading Purchase Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.Purchase';
        TRUNCATE TABLE silver.Purchase;
        PRINT '>> Inserting Data Into: silver.Purchase';
        INSERT INTO silver.Purchase
        (
            PurchaseOrderID,
            VendorID,
            EmployeeID,
            ShipMethodID,
            ProductID,
            OrderDate,
            DueDate,
            ShipDate,
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
        )
        SELECT
            h.PurchaseOrderID,
            h.VendorID,
            h.EmployeeID,
            h.ShipMethodID,
            d.ProductID,
            h.OrderDate,
            d.DueDate,
            h.ShipDate,
            d.OrderQty,
            d.UnitPrice,
            d.LineTotal,
            d.ReceivedQty,
            d.RejectedQty,
            d.StockedQty,
            h.SubTotal,
            h.TaxAmt,
            h.Freight,
            h.TotalDue,
            DATEDIFF(DAY, h.OrderDate, h.ShipDate),
            CASE
                WHEN d.OrderQty = 0 THEN NULL
                ELSE (d.ReceivedQty * 100.0) / d.OrderQty
            END,
            CASE
                WHEN d.OrderQty = 0 THEN NULL
                ELSE (d.RejectedQty * 100.0) / d.OrderQty
            END
        FROM bronze.PurchaseOrderHeader h
        INNER JOIN bronze.PurchaseOrderDetail d
        ON h.PurchaseOrderID = d.PurchaseOrderID;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';



        PRINT '------------------------------------------------';
	    PRINT 'Loading Vendor Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.Vendor';
        TRUNCATE TABLE silver.Vendor;
        PRINT '>> Inserting Data Into: silver.Vendor';
        INSERT INTO silver.Vendor
        (
            VendorID,
            VendorName,
            AccountNumber,
            CreditRating,
            PreferredVendorStatus,
            ActiveFlag,
            ProductID,
            AverageLeadTime,
            StandardPrice,
            LastReceiptCost,
            LastReceiptDate,
            MinOrderQty,
            MaxOrderQty,
            OnOrderQty,
            LeadTimeCategory,
            VendorStatus
        )
        SELECT
            VendorID,
            VendorName,
            AccountNumber,
            CreditRating,
            PreferredVendorStatus,
            ActiveFlag,
            ProductID,
            AverageLeadTime,
            StandardPrice,
            LastReceiptCost,
            LastReceiptDate,
            MinOrderQty,
            MaxOrderQty,
            OnOrderQty,
            LeadTimeCategory,
            VendorStatus
        FROM
        (
            SELECT
                v.BusinessEntityID     AS VendorID,
                v.Name                 AS VendorName,
                v.AccountNumber,
                v.CreditRating,
                v.PreferredVendorStatus,
                v.ActiveFlag,
                pv.ProductID,
                pv.AverageLeadTime,
                pv.StandardPrice,
                pv.LastReceiptCost,
                pv.LastReceiptDate,
                pv.MinOrderQty,
                pv.MaxOrderQty,
                pv.OnOrderQty,
                CASE
                    WHEN pv.AverageLeadTime <= 7 THEN 'Fast'
                    WHEN pv.AverageLeadTime <= 20 THEN 'Medium'
                    ELSE 'Slow'
                END AS LeadTimeCategory,
                CASE
                    WHEN v.ActiveFlag = 1 THEN 'Active'
                    ELSE 'Inactive'
                END AS VendorStatus,
                ROW_NUMBER() OVER (
                    PARTITION BY v.BusinessEntityID
                    ORDER BY pv.LastReceiptDate DESC, pv.StandardPrice ASC
                ) AS rn
            FROM bronze.Vendor v
            INNER JOIN bronze.ProductVendor pv
                ON v.BusinessEntityID = pv.BusinessEntityID
        ) AS ranked
        WHERE rn = 1;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';



        PRINT '------------------------------------------------';
	    PRINT 'Loading Employee Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.Employee';
        TRUNCATE TABLE silver.Employee;
        PRINT '>> Inserting Data Into: silver.Employee';

        ;WITH LatestDeptHistory AS
        (
            SELECT
                BusinessEntityID,
                DepartmentID,
                ShiftID,
                ROW_NUMBER() OVER (
                    PARTITION BY BusinessEntityID
                    ORDER BY StartDate DESC, EndDate DESC
                ) AS rn
            FROM bronze.EmployeeDepartmentHistory
        ),
        LatestPayHistory AS
        (
            SELECT
                BusinessEntityID,
                Rate,
                PayFrequency,
                ROW_NUMBER() OVER (
                    PARTITION BY BusinessEntityID
                    ORDER BY RateChangeDate DESC
                ) AS rn
            FROM bronze.EmployeePayHistory
        )

        INSERT INTO silver.Employee
        (
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
        )
        SELECT
            e.BusinessEntityID,
            p.FirstName,
            p.MiddleName,
            p.LastName,
            CONCAT(p.FirstName, ' ', COALESCE(p.MiddleName + ' ', ''), p.LastName),
            e.JobTitle,
            d.DepartmentID,
            d.Name,
            s.ShiftID,
            s.Name,
            e.BirthDate,
            e.Gender,
            e.MaritalStatus,
            e.HireDate,
            eph.Rate,
            eph.PayFrequency,
            e.VacationHours,
            e.SickLeaveHours,
            e.CurrentFlag,
            DATEDIFF(YEAR, e.BirthDate, GETDATE()),
            DATEDIFF(YEAR, e.HireDate, GETDATE()),
            CASE
                WHEN eph.Rate < 30 THEN 'Low'
                WHEN eph.Rate < 60 THEN 'Medium'
                ELSE 'High'
            END,
            CASE
                WHEN e.CurrentFlag = 1 THEN 'Active'
                ELSE 'Inactive'
            END
        FROM bronze.Employee e
        LEFT JOIN bronze.Person p
            ON e.BusinessEntityID = p.BusinessEntityID
        LEFT JOIN LatestDeptHistory edh
            ON e.BusinessEntityID = edh.BusinessEntityID
            AND edh.rn = 1
        LEFT JOIN bronze.Department d
            ON edh.DepartmentID = d.DepartmentID
        LEFT JOIN bronze.ShifT s
            ON edh.ShiftID = s.ShiftID
        LEFT JOIN LatestPayHistory eph
            ON e.BusinessEntityID = eph.BusinessEntityID
        AND eph.rn = 1;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';



        PRINT '------------------------------------------------';
	    PRINT 'Loading SalesTerritory Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.SalesTerritory';
        TRUNCATE TABLE silver.SalesTerritory;
        PRINT '>> Inserting Data Into: silver.SalesTerritory';
        INSERT INTO silver.SalesTerritory
        (
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
        )
        SELECT
            TerritoryID,
            Name,
            CountryRegionCode,
            [Group],
            SalesYTD,
            SalesLastYear,
            CostYTD,
            CostLastYear,
            SalesYTD - CostYTD,
            CASE
                WHEN SalesLastYear=0 THEN NULL
                ELSE ((SalesYTD-SalesLastYear)*100.0)/SalesLastYear
            END
        FROM bronze.SalesTerritory;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';



        PRINT '------------------------------------------------';
	    PRINT 'Loading Promotion Tables';
	    PRINT '------------------------------------------------';

        SET @start_time = GETDATE();
	    PRINT '>> Truncating Table: silver.Promotion';
        TRUNCATE TABLE silver.Promotion;
        PRINT '>> Inserting Data Into: silver.Promotion';

        ;WITH Ranked AS
        (
            SELECT
                so.SpecialOfferID,
                sop.ProductID,
                so.Description,
                so.DiscountPct,
                so.Type,
                so.Category,
                so.StartDate,
                so.EndDate,
                so.MinQty,
                so.MaxQty,
                CASE
                    WHEN GETDATE() BETWEEN so.StartDate AND so.EndDate
                        THEN 'Active'
                    ELSE 'Expired'
                END AS PromotionStatus,
                DATEDIFF(DAY, so.StartDate, so.EndDate) AS PromotionDuration,
                ROW_NUMBER() OVER (
                    PARTITION BY so.SpecialOfferID
                    ORDER BY sop.ProductID ASC
                ) AS rn
            FROM bronze.SpecialOffer so
            INNER JOIN bronze.SpecialOfferProduct sop
                ON so.SpecialOfferID = sop.SpecialOfferID
        )
        INSERT INTO silver.Promotion
        (
            SpecialOfferID,
            ProductID,
            Description,
            DiscountPct,
            PromotionType,
            PromotionCategory,
            StartDate,
            EndDate,
            MinQty,
            MaxQty,
            PromotionStatus,
            PromotionDuration
        )
        SELECT
            SpecialOfferID,
            ProductID,
            Description,
            DiscountPct,
            Type,
            Category,
            StartDate,
            EndDate,
            MinQty,
            MaxQty,
            PromotionStatus,
            PromotionDuration
        FROM Ranked
        WHERE rn = 1;
        SET @end_time = GETDATE();
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        PRINT '>> -------------';

    END TRY
    BEGIN CATCH
	    PRINT '=========================================='
	    PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	    PRINT 'Error Message' + ERROR_MESSAGE();
	    PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	    PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	    PRINT '=========================================='
    END CATCH
END





