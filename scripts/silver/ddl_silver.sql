/*
===============================================================================
DDL Script: Create Silver Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'silver' Tables
===============================================================================
*/

IF OBJECT_ID('silver.SalesOrderHeader', 'U') IS NOT NULL
    DROP TABLE silver.SalesOrderHeader;
GO
CREATE TABLE silver.SalesOrderHeader (
    SalesOrderID              INT NOT NULL,
    RevisionNumber            TINYINT NOT NULL,
    OrderDate                 DATETIME NOT NULL,
    DueDate                   DATETIME NOT NULL,
    ShipDate                  DATETIME NULL,
    [Status]                    TINYINT NOT NULL,
    OnlineOrderFlag           BIT NOT NULL,
    SalesOrderNumber          NVARCHAR(25) NOT NULL,
    PurchaseOrderNumber       NVARCHAR(25) NULL,
    AccountNumber             NVARCHAR(15) NULL,
    CustomerID                INT NOT NULL,
    SalesPersonID             INT NULL,
    TerritoryID               INT NULL,
    BillToAddressID           INT NOT NULL,
    ShipToAddressID           INT NOT NULL,
    ShipMethodID              INT NOT NULL,
    CreditCardID              INT NULL,
    CreditCardApprovalCode    VARCHAR(15) NULL,
    CurrencyRateID            INT NULL,
    SubTotal                  MONEY NOT NULL,
    TaxAmt                    MONEY NOT NULL,
    Freight                   MONEY NOT NULL,
    TotalDue                  MONEY NOT NULL,
    Comment                   NVARCHAR(128) NULL,
    rowguid                   UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate              DATETIME NOT NULL,
    dwh_create_date           DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.SalesOrderDetail', 'U') IS NOT NULL
    DROP TABLE silver.SalesOrderDetail;
GO
CREATE TABLE silver.SalesOrderDetail (
    SalesOrderID           INT NOT NULL,
    SalesOrderDetailID     INT NOT NULL,
    CarrierTrackingNumber  NVARCHAR(25) NULL,
    OrderQty               SMALLINT NOT NULL,
    ProductID              INT NOT NULL,
    SpecialOfferID         INT NOT NULL,
    UnitPrice              MONEY NOT NULL,
    UnitPriceDiscount      MONEY NOT NULL,
    LineTotal              NUMERIC(38,6) NOT NULL,
    rowguid                UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate           DATETIME NOT NULL,
    dwh_create_date        DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Customer', 'U') IS NOT NULL
    DROP TABLE silver.Customer;
GO
CREATE TABLE silver.Customer (
    CustomerID         INT NOT NULL,
    PersonID           INT NULL,
    StoreID            INT NULL,
    TerritoryID        INT NULL,
    AccountNumber      VARCHAR(10) NOT NULL,
    rowguid            UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate       DATETIME NOT NULL,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.SalesTerritory', 'U') IS NOT NULL
    DROP TABLE silver.SalesTerritory;
GO
CREATE TABLE silver.SalesTerritory (
    TerritoryID         INT NOT NULL,
    [Name]              NVARCHAR(50) NOT NULL,
    CountryRegionCode   NVARCHAR(3) NOT NULL,
    [Group]             NVARCHAR(50) NOT NULL,
    SalesYTD            MONEY NOT NULL,
    SalesLastYear       MONEY NOT NULL,
    CostYTD             MONEY NOT NULL,
    CostLastYear        MONEY NOT NULL,
    rowguid             UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate        DATETIME NOT NULL,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.SpecialOffer', 'U') IS NOT NULL
    DROP TABLE silver.SpecialOffer;
GO
CREATE TABLE silver.SpecialOffer (
    SpecialOfferID    INT NOT NULL,
    [Description]     NVARCHAR(255) NOT NULL,
    DiscountPct       SMALLMONEY NOT NULL,
    [Type]            NVARCHAR(50) NOT NULL,
    Category          NVARCHAR(50) NOT NULL,
    StartDate         DATETIME NOT NULL,
    EndDate           DATETIME NOT NULL,
    MinQty            INT NOT NULL,
    MaxQty            INT NULL,
    rowguid           UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate      DATETIME NOT NULL,
    dwh_create_date   DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.SpecialOfferProduct', 'U') IS NOT NULL
    DROP TABLE silver.SpecialOfferProduct;
GO
CREATE TABLE silver.SpecialOfferProduct (
    SpecialOfferID    INT NOT NULL,
    ProductID         INT NOT NULL,
    rowguid           UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate      DATETIME NOT NULL,
    dwh_create_date   DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Person', 'U') IS NOT NULL
    DROP TABLE silver.Person;
GO
CREATE TABLE silver.Person (
    BusinessEntityID         INT NOT NULL,
    PersonType               NCHAR(2) NOT NULL,
    NameStyle                BIT NOT NULL,
    Title                    NVARCHAR(8) NULL,
    FirstName                NVARCHAR(50) NOT NULL,
    MiddleName               NVARCHAR(50) NULL,
    LastName                 NVARCHAR(50) NOT NULL,
    Suffix                   NVARCHAR(10) NULL,
    EmailPromotion           INT NOT NULL,
    AdditionalContactInfo    XML NULL,
    Demographics             XML NULL,
    rowguid                  UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate             DATETIME NOT NULL,
    dwh_create_date          DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Address', 'U') IS NOT NULL
    DROP TABLE silver.[Address];
GO
CREATE TABLE silver.[Address] (
    AddressID          INT NOT NULL,
    AddressLine1       NVARCHAR(60) NOT NULL,
    AddressLine2       NVARCHAR(60) NULL,
    City               NVARCHAR(30) NOT NULL,
    StateProvinceID    INT NOT NULL,
    PostalCode         NVARCHAR(15) NOT NULL,
    SpatialLocation    GEOGRAPHY NULL,
    rowguid            UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate       DATETIME NOT NULL,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.StateProvince', 'U') IS NOT NULL
    DROP TABLE silver.StateProvince;
GO
CREATE TABLE silver.StateProvince (
    StateProvinceID          INT NOT NULL,
    StateProvinceCode        NCHAR(3) NOT NULL,
    CountryRegionCode        NVARCHAR(3) NOT NULL,
    IsOnlyStateProvinceFlag  BIT NOT NULL,
    [Name]                   NVARCHAR(50) NOT NULL,
    TerritoryID              INT NOT NULL,
    rowguid                  UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate             DATETIME NOT NULL,
    dwh_create_date          DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.CountryRegion', 'U') IS NOT NULL
    DROP TABLE silver.CountryRegion;
GO
CREATE TABLE silver.CountryRegion (
    CountryRegionCode    NVARCHAR(3) NOT NULL,
    [Name]               NVARCHAR(50) NOT NULL,
    ModifiedDate         DATETIME NOT NULL,
    dwh_create_date      DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.EmailAddress', 'U') IS NOT NULL
    DROP TABLE silver.EmailAddress;
GO
CREATE TABLE silver.EmailAddress (
    BusinessEntityID    INT NOT NULL,
    EmailAddressID      INT NOT NULL,
    EmailAddress        NVARCHAR(50) NULL,
    rowguid             UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate        DATETIME NOT NULL,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.PersonPhone', 'U') IS NOT NULL
    DROP TABLE silver.PersonPhone;
GO
CREATE TABLE silver.PersonPhone (
    BusinessEntityID    INT NOT NULL,
    PhoneNumber         NVARCHAR(25) NOT NULL,
    PhoneNumberTypeID   INT NOT NULL,
    ModifiedDate        DATETIME NOT NULL,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Store', 'U') IS NOT NULL
    DROP TABLE silver.Store;
GO
CREATE TABLE silver.Store (
    BusinessEntityID    INT NOT NULL,
    [Name]              NVARCHAR(50) NOT NULL,
    SalesPersonID       INT NULL,
    Demographics        XML NULL,
    rowguid             UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate        DATETIME NOT NULL,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Product', 'U') IS NOT NULL
    DROP TABLE silver.[Product];
GO
CREATE TABLE silver.[Product] (
    ProductID              INT NOT NULL,
    [Name]                 NVARCHAR(50) NOT NULL,
    ProductNumber          NVARCHAR(25) NOT NULL,
    MakeFlag               BIT NOT NULL,
    FinishedGoodsFlag      BIT NOT NULL,
    Color                  NVARCHAR(15) NULL,
    SafetyStockLevel       SMALLINT NOT NULL,
    ReorderPoint           SMALLINT NOT NULL,
    StandardCost           MONEY NOT NULL,
    ListPrice              MONEY NOT NULL,
    [Size]                 NVARCHAR(5) NULL,
    SizeUnitMeasureCode    NCHAR(3) NULL,
    WeightUnitMeasureCode  NCHAR(3) NULL,
    [Weight]               DECIMAL(8,2) NULL,
    DaysToManufacture      INT NOT NULL,
    ProductLine            NCHAR(2) NULL,
    Class                  NCHAR(2) NULL,
    Style                  NCHAR(2) NULL,
    ProductSubcategoryID   INT NULL,
    ProductModelID         INT NULL,
    SellStartDate          DATETIME NOT NULL,
    SellEndDate            DATETIME NULL,
    DiscontinuedDate       DATETIME NULL,
    rowguid                UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate           DATETIME NOT NULL,
    dwh_create_date        DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.ProductCategory', 'U') IS NOT NULL
    DROP TABLE silver.ProductCategory;
GO
CREATE TABLE silver.ProductCategory (
    ProductCategoryID    INT NOT NULL,
    [Name]               NVARCHAR(50) NOT NULL,
    rowguid              UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate         DATETIME NOT NULL,
    dwh_create_date      DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.ProductSubcategory', 'U') IS NOT NULL
    DROP TABLE silver.ProductSubcategory;
GO
CREATE TABLE silver.ProductSubcategory (
    ProductSubcategoryID    INT NOT NULL,
    ProductCategoryID       INT NOT NULL,
    [Name]                  NVARCHAR(50) NOT NULL,
    rowguid                 UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate            DATETIME NOT NULL,
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.ProductInventory', 'U') IS NOT NULL
    DROP TABLE silver.ProductInventory;
GO
CREATE TABLE silver.ProductInventory (
    ProductID           INT NOT NULL,
    LocationID          SMALLINT NOT NULL,
    Shelf               NVARCHAR(10) NOT NULL,
    Bin                 TINYINT NOT NULL,
    Quantity            SMALLINT NOT NULL,
    rowguid             UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate        DATETIME NOT NULL,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Location', 'U') IS NOT NULL
    DROP TABLE silver.[Location];
GO
CREATE TABLE silver.[Location] (
    LocationID                  SMALLINT NOT NULL,
    [Name]                      NVARCHAR(50) NOT NULL,
    CostRate                    SMALLMONEY NOT NULL,
    [Availability]              DECIMAL(8,2) NOT NULL,
    ModifiedDate                DATETIME NOT NULL,
    dwh_create_date             DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.TransactionHistory', 'U') IS NOT NULL
    DROP TABLE silver.TransactionHistory;
GO
CREATE TABLE silver.TransactionHistory (
    TransactionID         INT NOT NULL,
    ProductID             INT NOT NULL,
    ReferenceOrderID      INT NOT NULL,
    ReferenceOrderLineID  INT NOT NULL,
    TransactionDate       DATETIME NOT NULL,
    TransactionType       NCHAR(1) NOT NULL,
    Quantity              INT NOT NULL,
    ActualCost            MONEY NOT NULL,
    ModifiedDate          DATETIME NOT NULL,
    dwh_create_date       DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.ProductCostHistory', 'U') IS NOT NULL
    DROP TABLE silver.ProductCostHistory;
GO
CREATE TABLE silver.ProductCostHistory (
    ProductID           INT NOT NULL,
    StartDate           DATETIME NOT NULL,
    EndDate             DATETIME NULL,
    StandardCost        MONEY NOT NULL,
    ModifiedDate        DATETIME NOT NULL,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.ProductListPriceHistory', 'U') IS NOT NULL
    DROP TABLE silver.ProductListPriceHistory;
GO
CREATE TABLE silver.ProductListPriceHistory (
    ProductID                   INT NOT NULL,
    StartDate                   DATETIME NOT NULL,
    EndDate                     DATETIME NULL,
    ListPrice                   MONEY NOT NULL,
    ModifiedDate                DATETIME NOT NULL,
    dwh_create_date             DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID('silver.PurchaseOrderHeader', 'U') IS NOT NULL
    DROP TABLE silver.PurchaseOrderHeader;
GO
CREATE TABLE silver.PurchaseOrderHeader (
    PurchaseOrderID    INT NOT NULL,
    RevisionNumber     TINYINT NOT NULL,
    [Status]            TINYINT NOT NULL,
    EmployeeID         INT NOT NULL,
    VendorID           INT NOT NULL,
    ShipMethodID       INT NOT NULL,
    OrderDate          DATETIME NOT NULL,
    ShipDate           DATETIME NULL,
    SubTotal           MONEY NOT NULL,
    TaxAmt             MONEY NOT NULL,
    Freight            MONEY NOT NULL,
    TotalDue           MONEY NOT NULL,
    ModifiedDate       DATETIME NOT NULL,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.PurchaseOrderDetail', 'U') IS NOT NULL
    DROP TABLE silver.PurchaseOrderDetail;
GO
CREATE TABLE silver.PurchaseOrderDetail (
    PurchaseOrderID         INT NOT NULL,
    PurchaseOrderDetailID   INT NOT NULL,
    DueDate                 DATETIME NOT NULL,
    OrderQty                SMALLINT NOT NULL,
    ProductID               INT NOT NULL,
    UnitPrice               MONEY NOT NULL,
    LineTotal               MONEY NOT NULL,
    ReceivedQty             DECIMAL(8,2) NOT NULL,
    RejectedQty             DECIMAL(8,2) NOT NULL,
    StockedQty              DECIMAL(9,2) NOT NULL,
    ModifiedDate            DATETIME NOT NULL,
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Vendor', 'U') IS NOT NULL
    DROP TABLE silver.Vendor;
GO
CREATE TABLE silver.Vendor (
    BusinessEntityID          INT NOT NULL,
    AccountNumber             NVARCHAR(15) NOT NULL,
    [Name]                    NVARCHAR(50) NOT NULL,
    CreditRating              TINYINT NOT NULL,
    PreferredVendorStatus     BIT NOT NULL,
    ActiveFlag                BIT NOT NULL,
    PurchasingWebServiceURL   NVARCHAR(1024) NULL,
    ModifiedDate              DATETIME NOT NULL,
    dwh_create_date           DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.ProductVendor', 'U') IS NOT NULL
    DROP TABLE silver.ProductVendor;
GO
CREATE TABLE silver.ProductVendor (
    ProductID          INT NOT NULL,
    BusinessEntityID   INT NOT NULL,
    AverageLeadTime    INT NOT NULL,
    StandardPrice      MONEY NOT NULL,
    LastReceiptCost    MONEY NULL,
    LastReceiptDate    DATETIME NULL,
    MinOrderQty        INT NOT NULL,
    MaxOrderQty        INT NOT NULL,
    OnOrderQty         INT NULL,
    UnitMeasureCode    NCHAR(3) NOT NULL,
    ModifiedDate       DATETIME NOT NULL,
    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.ShipMethod', 'U') IS NOT NULL
    DROP TABLE silver.ShipMethod;
GO
CREATE TABLE silver.ShipMethod (
    ShipMethodID            INT NOT NULL,
    [Name]                  NVARCHAR(50) NOT NULL,
    ShipBase                MONEY NOT NULL,
    ShipRate                MONEY NOT NULL,
    rowguid                 UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate            DATETIME NOT NULL,
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Employee', 'U') IS NOT NULL
    DROP TABLE silver.Employee;
GO
CREATE TABLE silver.Employee (
    BusinessEntityID     INT NOT NULL,
    NationalIDNumber     NVARCHAR(15) NOT NULL,
    LoginID              NVARCHAR(256) NOT NULL,
    OrganizationNode     HIERARCHYID NULL,
    OrganizationLevel    SMALLINT NULL,
    JobTitle             NVARCHAR(50) NOT NULL,
    BirthDate            DATE NOT NULL,
    MaritalStatus        NCHAR(1) NOT NULL,
    Gender               NCHAR(1) NOT NULL,
    HireDate             DATE NOT NULL,
    SalariedFlag         BIT NOT NULL,
    VacationHours        SMALLINT NOT NULL,
    SickLeaveHours       SMALLINT NOT NULL,
    CurrentFlag          BIT NOT NULL,
    rowguid              UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate         DATETIME NOT NULL,
    dwh_create_date      DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Department', 'U') IS NOT NULL
    DROP TABLE silver.Department;
GO
CREATE TABLE silver.Department (
    DepartmentID            SMALLINT NOT NULL,
    [Name]                  NVARCHAR(50) NOT NULL,
    GroupName               NVARCHAR(50) NOT NULL,
    ModifiedDate            DATETIME NOT NULL,
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.EmployeeDepartmentHistory', 'U') IS NOT NULL
    DROP TABLE silver.EmployeeDepartmentHistory;
GO
CREATE TABLE silver.EmployeeDepartmentHistory (
    BusinessEntityID    INT NOT NULL,
    DepartmentID        SMALLINT NOT NULL,
    ShiftID             TINYINT NOT NULL,
    StartDate           DATE NOT NULL,
    EndDate             DATE NULL,
    ModifiedDate        DATETIME NOT NULL,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.EmployeePayHistory', 'U') IS NOT NULL
    DROP TABLE silver.EmployeePayHistory;
GO
CREATE TABLE silver.EmployeePayHistory (
    BusinessEntityID    INT NOT NULL,
    RateChangeDate      DATETIME NOT NULL,
    Rate                MONEY NOT NULL,
    PayFrequency        TINYINT NOT NULL,
    ModifiedDate        DATETIME NOT NULL,
    dwh_create_date     DATETIME2 DEFAULT GETDATE()
);
GO


IF OBJECT_ID('silver.Shift', 'U') IS NOT NULL
    DROP TABLE silver.[Shift];
GO
CREATE TABLE silver.[Shift] (
    ShiftID                 TINYINT NOT NULL,
    Name                    NVARCHAR(50) NOT NULL,
    StartTime               TIME NOT NULL,
    EndTime                 TIME NOT NULL,
    ModifiedDate            DATETIME NOT NULL,
    dwh_create_date         DATETIME2 DEFAULT GETDATE()
);
GO
