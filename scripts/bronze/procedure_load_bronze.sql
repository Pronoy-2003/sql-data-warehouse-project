/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external Database. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `INSERT` command to load data from AdventureWorks2025 Database to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '================================================';
		PRINT '------------------------------------------------';
		PRINT 'Loading SalesOrderHeader';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.SalesOrderHeader';
		TRUNCATE TABLE bronze.SalesOrderHeader;

		PRINT '>> Inserting Data Into: bronze.SalesOrderHeader';

		INSERT INTO bronze.SalesOrderHeader
		SELECT *
		FROM AdventureWorks2025.Sales.SalesOrderHeader;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading SalesOrderDetail';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.SalesOrderDetail';
		TRUNCATE TABLE bronze.SalesOrderDetail;

		PRINT '>> Inserting Data Into: bronze.SalesOrderDetail';

		INSERT INTO bronze.SalesOrderDetail
		SELECT *
		FROM AdventureWorks2025.Sales.SalesOrderDetail;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading Customer';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Customer';
		TRUNCATE TABLE bronze.Customer;

		PRINT '>> Inserting Data Into: bronze.Customer';

		INSERT INTO bronze.Customer
		SELECT *
		FROM AdventureWorks2025.Sales.Customer;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading SalesTerritory';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.SalesTerritory';
		TRUNCATE TABLE bronze.SalesTerritory;

		PRINT '>> Inserting Data Into: bronze.SalesTerritory';

		INSERT INTO bronze.SalesTerritory
		SELECT *
		FROM AdventureWorks2025.Sales.SalesTerritory;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading SpecialOffer';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.SpecialOffer';
		TRUNCATE TABLE bronze.SpecialOffer;

		PRINT '>> Inserting Data Into: bronze.SpecialOffer';

		INSERT INTO bronze.SpecialOffer
		SELECT *
		FROM AdventureWorks2025.Sales.SpecialOffer;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading SpecialOfferProduct';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.SpecialOfferProduct';
		TRUNCATE TABLE bronze.SpecialOfferProduct;

		PRINT '>> Inserting Data Into: bronze.SpecialOfferProduct';

		INSERT INTO bronze.SpecialOfferProduct
		SELECT *
		FROM AdventureWorks2025.Sales.SpecialOfferProduct;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading Person';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Person';
		TRUNCATE TABLE bronze.Person;

		PRINT '>> Inserting Data Into: bronze.Person';

		INSERT INTO bronze.Person
		SELECT *
		FROM AdventureWorks2025.Person.Person;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading Address';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Address';
		TRUNCATE TABLE bronze.[Address];

		PRINT '>> Inserting Data Into: bronze.Address';

		INSERT INTO bronze.[Address]
		SELECT *
		FROM AdventureWorks2025.Person.[Address];

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading StateProvince';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.StateProvince';
		TRUNCATE TABLE bronze.StateProvince;

		PRINT '>> Inserting Data Into: bronze.StateProvince';

		INSERT INTO bronze.StateProvince
		SELECT *
		FROM AdventureWorks2025.Person.StateProvince;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading CountryRegion';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.CountryRegion';
		TRUNCATE TABLE bronze.CountryRegion;

		PRINT '>> Inserting Data Into: bronze.CountryRegion';

		INSERT INTO bronze.CountryRegion
		SELECT *
		FROM AdventureWorks2025.Person.CountryRegion;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading EmailAddress';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.EmailAddress';
		TRUNCATE TABLE bronze.EmailAddress;

		PRINT '>> Inserting Data Into: bronze.EmailAddress';

		INSERT INTO bronze.EmailAddress
		SELECT *
		FROM AdventureWorks2025.Person.EmailAddress;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';


 
		PRINT '------------------------------------------------';
		PRINT 'Loading PersonPhone';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.PersonPhone';
		TRUNCATE TABLE bronze.PersonPhone;

		PRINT '>> Inserting Data Into: bronze.PersonPhone';

		INSERT INTO bronze.PersonPhone
		SELECT *
		FROM AdventureWorks2025.Person.PersonPhone;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading Store';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Store';
		TRUNCATE TABLE bronze.Store;

		PRINT '>> Inserting Data Into: bronze.Store';

		INSERT INTO bronze.Store
		SELECT *
		FROM AdventureWorks2025.Sales.Store;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading Product';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Product';
		TRUNCATE TABLE bronze.[Product];

		PRINT '>> Inserting Data Into: bronze.Product';

		INSERT INTO bronze.[Product]
		SELECT *
		FROM AdventureWorks2025.Production.[Product];

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading ProductCategory';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.ProductCategory';
		TRUNCATE TABLE bronze.ProductCategory;

		PRINT '>> Inserting Data Into: bronze.ProductCategory';

		INSERT INTO bronze.ProductCategory
		SELECT *
		FROM AdventureWorks2025.Production.ProductCategory;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading ProductSubcategory';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.ProductSubcategory';
		TRUNCATE TABLE bronze.ProductSubcategory;

		PRINT '>> Inserting Data Into: bronze.ProductSubcategory';

		INSERT INTO bronze.ProductSubcategory
		SELECT *
		FROM AdventureWorks2025.Production.ProductSubcategory;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading ProductInventory';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.ProductInventory';
		TRUNCATE TABLE bronze.ProductInventory;

		PRINT '>> Inserting Data Into: bronze.ProductInventory';

		INSERT INTO bronze.ProductInventory
		SELECT *
		FROM AdventureWorks2025.Production.ProductInventory;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading Location';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Location';
		TRUNCATE TABLE bronze.[Location];

		PRINT '>> Inserting Data Into: bronze.Location';

		INSERT INTO bronze.[Location]
		SELECT *
		FROM AdventureWorks2025.Production.[Location];

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading TransactionHistory';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.TransactionHistory';
		TRUNCATE TABLE bronze.TransactionHistory;

		PRINT '>> Inserting Data Into: bronze.TransactionHistory';

		INSERT INTO bronze.TransactionHistory
		SELECT *
		FROM AdventureWorks2025.Production.TransactionHistory;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

 

		PRINT '------------------------------------------------';
		PRINT 'Loading ProductCostHistory';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.ProductCostHistory';
		TRUNCATE TABLE bronze.ProductCostHistory;

		PRINT '>> Inserting Data Into: bronze.ProductCostHistory';

		INSERT INTO bronze.ProductCostHistory
		SELECT *
		FROM AdventureWorks2025.Production.ProductCostHistory;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading ProductListPriceHistory';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.ProductListPriceHistory';
		TRUNCATE TABLE bronze.ProductListPriceHistory;

		PRINT '>> Inserting Data Into: bronze.ProductListPriceHistory';

		INSERT INTO bronze.ProductListPriceHistory
		SELECT *
		FROM AdventureWorks2025.Production.ProductListPriceHistory;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading PurchaseOrderHeader';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.PurchaseOrderHeader';
		TRUNCATE TABLE bronze.PurchaseOrderHeader;

		PRINT '>> Inserting Data Into: bronze.PurchaseOrderHeader';

		INSERT INTO bronze.PurchaseOrderHeader
		SELECT *
		FROM AdventureWorks2025.Purchasing.PurchaseOrderHeader;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



		PRINT '------------------------------------------------';
		PRINT 'Loading PurchaseOrderDetail';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.PurchaseOrderDetail';
		TRUNCATE TABLE bronze.PurchaseOrderDetail;

		PRINT '>> Inserting Data Into: bronze.PurchaseOrderDetail';

		INSERT INTO bronze.PurchaseOrderDetail
		SELECT *
		FROM AdventureWorks2025.Purchasing.PurchaseOrderDetail;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



 
		PRINT '------------------------------------------------';
		PRINT 'Loading Vendor';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Vendor';
		TRUNCATE TABLE bronze.Vendor;

		PRINT '>> Inserting Data Into: bronze.Vendor';

		INSERT INTO bronze.Vendor
		SELECT *
		FROM AdventureWorks2025.Purchasing.Vendor;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading ProductVendor';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.ProductVendor';
		TRUNCATE TABLE bronze.ProductVendor;

		PRINT '>> Inserting Data Into: bronze.ProductVendor';

		INSERT INTO bronze.ProductVendor
		SELECT *
		FROM AdventureWorks2025.Purchasing.ProductVendor;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



 
		PRINT '------------------------------------------------';
		PRINT 'Loading ShipMethod';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.ShipMethod';
		TRUNCATE TABLE bronze.ShipMethod;

		PRINT '>> Inserting Data Into: bronze.ShipMethod';

		INSERT INTO bronze.ShipMethod
		SELECT *
		FROM AdventureWorks2025.Purchasing.ShipMethod;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



 
		PRINT '------------------------------------------------';
		PRINT 'Loading Employee';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Employee';
		TRUNCATE TABLE bronze.Employee;

		PRINT '>> Inserting Data Into: bronze.Employee';

		INSERT INTO bronze.Employee
		SELECT *
		FROM AdventureWorks2025.HumanResources.Employee;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading Department';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Department';
		TRUNCATE TABLE bronze.Department;

		PRINT '>> Inserting Data Into: bronze.Department';

		INSERT INTO bronze.Department
		SELECT *
		FROM AdventureWorks2025.HumanResources.Department;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';



 
		PRINT '------------------------------------------------';
		PRINT 'Loading EmployeeDepartmentHistory';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.EmployeeDepartmentHistory';
		TRUNCATE TABLE bronze.EmployeeDepartmentHistory;

		PRINT '>> Inserting Data Into: bronze.EmployeeDepartmentHistory';

		INSERT INTO bronze.EmployeeDepartmentHistory
		SELECT *
		FROM AdventureWorks2025.HumanResources.EmployeeDepartmentHistory;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading EmployeePayHistory';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.EmployeePayHistory';
		TRUNCATE TABLE bronze.EmployeePayHistory;

		PRINT '>> Inserting Data Into: bronze.EmployeePayHistory';

		INSERT INTO bronze.EmployeePayHistory
		SELECT *
		FROM AdventureWorks2025.HumanResources.EmployeePayHistory;

		SET @end_time = GETDATE();

		PRINT '>> Load Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';




		PRINT '------------------------------------------------';
		PRINT 'Loading Shift';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();

		PRINT '>> Truncating Table: bronze.Shift';
		TRUNCATE TABLE bronze.[Shift];

		PRINT '>> Inserting Data Into: bronze.Shift';

		INSERT INTO bronze.[Shift]
		SELECT *
		FROM AdventureWorks2025.HumanResources.[Shift];

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
