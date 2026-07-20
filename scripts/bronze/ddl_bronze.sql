/*
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables 
    if they already exist.
	  Run this script to re-define the DDL structure of 'bronze' Tables
===============================================================================
*/


IF OBJECT_ID('bronze.SalesOrderHeader', 'U') IS NOT NULL
    DROP TABLE bronze.SalesOrderHeader;
GO
CREATE TABLE bronze.SalesOrderHeader (
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
    ModifiedDate              DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.SalesOrderDetail', 'U') IS NOT NULL
    DROP TABLE bronze.SalesOrderDetail;
GO
CREATE TABLE bronze.SalesOrderDetail (
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
    ModifiedDate           DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Customer', 'U') IS NOT NULL
    DROP TABLE bronze.Customer;
GO
CREATE TABLE bronze.Customer (
    CustomerID      INT NOT NULL,
    PersonID        INT NULL,
    StoreID         INT NULL,
    TerritoryID     INT NULL,
    AccountNumber   VARCHAR(10) NOT NULL,
    rowguid         UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate    DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.SalesTerritory', 'U') IS NOT NULL
    DROP TABLE bronze.SalesTerritory;
GO
CREATE TABLE bronze.SalesTerritory (
    TerritoryID         INT NOT NULL,
    Name                NVARCHAR(50) NOT NULL,
    CountryRegionCode   NVARCHAR(3) NOT NULL,
    [Group]             NVARCHAR(50) NOT NULL,
    SalesYTD            MONEY NOT NULL,
    SalesLastYear       MONEY NOT NULL,
    CostYTD             MONEY NOT NULL,
    CostLastYear        MONEY NOT NULL,
    rowguid             UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate        DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.SpecialOffer', 'U') IS NOT NULL
    DROP TABLE bronze.SpecialOffer;
GO
CREATE TABLE bronze.SpecialOffer (
    SpecialOfferID    INT NOT NULL,
    Description       NVARCHAR(255) NOT NULL,
    DiscountPct       SMALLMONEY NOT NULL,
    Type              NVARCHAR(50) NOT NULL,
    Category          NVARCHAR(50) NOT NULL,
    StartDate         DATETIME NOT NULL,
    EndDate           DATETIME NOT NULL,
    MinQty            INT NOT NULL,
    MaxQty            INT NULL,
    rowguid           UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate      DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.SpecialOfferProduct', 'U') IS NOT NULL
    DROP TABLE bronze.SpecialOfferProduct;
GO
CREATE TABLE bronze.SpecialOfferProduct (
    SpecialOfferID    INT NOT NULL,
    ProductID         INT NOT NULL,
    rowguid           UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate      DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Person', 'U') IS NOT NULL
    DROP TABLE bronze.Person;
GO
CREATE TABLE bronze.Person (
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
    ModifiedDate             DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Address', 'U') IS NOT NULL
    DROP TABLE bronze.[Address];
GO
CREATE TABLE bronze.[Address] (
    AddressID          INT NOT NULL,
    AddressLine1       NVARCHAR(60) NOT NULL,
    AddressLine2       NVARCHAR(60) NULL,
    City               NVARCHAR(30) NOT NULL,
    StateProvinceID    INT NOT NULL,
    PostalCode         NVARCHAR(15) NOT NULL,
    SpatialLocation    GEOGRAPHY NULL,
    rowguid            UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate       DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.StateProvince', 'U') IS NOT NULL
    DROP TABLE bronze.StateProvince;
GO
CREATE TABLE bronze.StateProvince (
    StateProvinceID          INT NOT NULL,
    StateProvinceCode        NCHAR(3) NOT NULL,
    CountryRegionCode        NVARCHAR(3) NOT NULL,
    IsOnlyStateProvinceFlag  BIT NOT NULL,
    Name                     NVARCHAR(50) NOT NULL,
    TerritoryID              INT NOT NULL,
    rowguid                  UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate             DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.CountryRegion', 'U') IS NOT NULL
    DROP TABLE bronze.CountryRegion;
GO
CREATE TABLE bronze.CountryRegion (
    CountryRegionCode    NVARCHAR(3) NOT NULL,
    Name                 NVARCHAR(50) NOT NULL,
    ModifiedDate         DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.EmailAddress', 'U') IS NOT NULL
    DROP TABLE bronze.EmailAddress;
GO
CREATE TABLE bronze.EmailAddress (
    BusinessEntityID    INT NOT NULL,
    EmailAddressID      INT NOT NULL,
    EmailAddress        NVARCHAR(50) NULL,
    rowguid             UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate        DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.PersonPhone', 'U') IS NOT NULL
    DROP TABLE bronze.PersonPhone;
GO
CREATE TABLE bronze.PersonPhone (
    BusinessEntityID    INT NOT NULL,
    PhoneNumber         NVARCHAR(25) NOT NULL,
    PhoneNumberTypeID   INT NOT NULL,
    ModifiedDate        DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Store', 'U') IS NOT NULL
    DROP TABLE bronze.Store;
GO
CREATE TABLE bronze.Store (
    BusinessEntityID    INT NOT NULL,
    Name                NVARCHAR(50) NOT NULL,
    SalesPersonID       INT NULL,
    Demographics        XML NULL,
    rowguid             UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate        DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Product', 'U') IS NOT NULL
    DROP TABLE bronze.[Product];
GO
CREATE TABLE bronze.[Product] (
    ProductID              INT NOT NULL,
    Name                   NVARCHAR(50) NOT NULL,
    ProductNumber          NVARCHAR(25) NOT NULL,
    MakeFlag               BIT NOT NULL,
    FinishedGoodsFlag      BIT NOT NULL,
    Color                  NVARCHAR(15) NULL,
    SafetyStockLevel       SMALLINT NOT NULL,
    ReorderPoint           SMALLINT NOT NULL,
    StandardCost           MONEY NOT NULL,
    ListPrice              MONEY NOT NULL,
    Size                   NVARCHAR(5) NULL,
    SizeUnitMeasureCode    NCHAR(3) NULL,
    WeightUnitMeasureCode  NCHAR(3) NULL,
    Weight                 DECIMAL(8,2) NULL,
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
    ModifiedDate           DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.ProductCategory', 'U') IS NOT NULL
    DROP TABLE bronze.ProductCategory;
GO
CREATE TABLE bronze.ProductCategory (
    ProductCategoryID    INT NOT NULL,
    Name                 NVARCHAR(50) NOT NULL,
    rowguid              UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate         DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.ProductSubcategory', 'U') IS NOT NULL
    DROP TABLE bronze.ProductSubcategory;
GO
CREATE TABLE bronze.ProductSubcategory (
    ProductSubcategoryID    INT NOT NULL,
    ProductCategoryID       INT NOT NULL,
    Name                    NVARCHAR(50) NOT NULL,
    rowguid                 UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate            DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.ProductInventory', 'U') IS NOT NULL
    DROP TABLE bronze.ProductInventory;
GO
CREATE TABLE bronze.ProductInventory (
    ProductID       INT NOT NULL,
    LocationID      SMALLINT NOT NULL,
    Shelf           NVARCHAR(10) NOT NULL,
    Bin             TINYINT NOT NULL,
    Quantity        SMALLINT NOT NULL,
    rowguid         UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate    DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Location', 'U') IS NOT NULL
    DROP TABLE bronze.[Location];
GO
CREATE TABLE bronze.[Location] (
    LocationID      SMALLINT NOT NULL,
    [Name]            NVARCHAR(50) NOT NULL,
    CostRate        SMALLMONEY NOT NULL,
    [Availability]    DECIMAL(8,2) NOT NULL,
    ModifiedDate    DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.TransactionHistory', 'U') IS NOT NULL
    DROP TABLE bronze.TransactionHistory;
GO
CREATE TABLE bronze.TransactionHistory (
    TransactionID         INT NOT NULL,
    ProductID             INT NOT NULL,
    ReferenceOrderID      INT NOT NULL,
    ReferenceOrderLineID  INT NOT NULL,
    TransactionDate       DATETIME NOT NULL,
    TransactionType       NCHAR(1) NOT NULL,
    Quantity              INT NOT NULL,
    ActualCost            MONEY NOT NULL,
    ModifiedDate          DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.ProductCostHistory', 'U') IS NOT NULL
    DROP TABLE bronze.ProductCostHistory;
GO
CREATE TABLE bronze.ProductCostHistory (
    ProductID       INT NOT NULL,
    StartDate       DATETIME NOT NULL,
    EndDate         DATETIME NULL,
    StandardCost    MONEY NOT NULL,
    ModifiedDate    DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.ProductListPriceHistory', 'U') IS NOT NULL
    DROP TABLE bronze.ProductListPriceHistory;
GO
CREATE TABLE bronze.ProductListPriceHistory (
    ProductID      INT NOT NULL,
    StartDate      DATETIME NOT NULL,
    EndDate        DATETIME NULL,
    ListPrice      MONEY NOT NULL,
    ModifiedDate   DATETIME NOT NULL
);


IF OBJECT_ID('bronze.PurchaseOrderHeader', 'U') IS NOT NULL
    DROP TABLE bronze.PurchaseOrderHeader;
GO
CREATE TABLE bronze.PurchaseOrderHeader (
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
    ModifiedDate       DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.PurchaseOrderDetail', 'U') IS NOT NULL
    DROP TABLE bronze.PurchaseOrderDetail;
GO
CREATE TABLE bronze.PurchaseOrderDetail (
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
    ModifiedDate            DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Vendor', 'U') IS NOT NULL
    DROP TABLE bronze.Vendor;
GO
CREATE TABLE bronze.Vendor (
    BusinessEntityID          INT NOT NULL,
    AccountNumber             NVARCHAR(15) NOT NULL,
    Name                      NVARCHAR(50) NOT NULL,
    CreditRating              TINYINT NOT NULL,
    PreferredVendorStatus     BIT NOT NULL,
    ActiveFlag                BIT NOT NULL,
    PurchasingWebServiceURL   NVARCHAR(1024) NULL,
    ModifiedDate              DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.ProductVendor', 'U') IS NOT NULL
    DROP TABLE bronze.ProductVendor;
GO
CREATE TABLE bronze.ProductVendor (
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
    ModifiedDate       DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.ShipMethod', 'U') IS NOT NULL
    DROP TABLE bronze.ShipMethod;
GO
CREATE TABLE bronze.ShipMethod (
    ShipMethodID     INT NOT NULL,
    [Name]           NVARCHAR(50) NOT NULL,
    ShipBase         MONEY NOT NULL,
    ShipRate         MONEY NOT NULL,
    rowguid          UNIQUEIDENTIFIER NOT NULL,
    ModifiedDate     DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Employee', 'U') IS NOT NULL
    DROP TABLE bronze.Employee;
GO
CREATE TABLE bronze.Employee (
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
    ModifiedDate         DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Department', 'U') IS NOT NULL
    DROP TABLE bronze.Department;
GO
CREATE TABLE bronze.Department (
    DepartmentID    SMALLINT NOT NULL,
    [Name]          NVARCHAR(50) NOT NULL,
    GroupName       NVARCHAR(50) NOT NULL,
    ModifiedDate    DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.EmployeeDepartmentHistory', 'U') IS NOT NULL
    DROP TABLE bronze.EmployeeDepartmentHistory;
GO
CREATE TABLE bronze.EmployeeDepartmentHistory (
    BusinessEntityID    INT NOT NULL,
    DepartmentID        SMALLINT NOT NULL,
    ShiftID             TINYINT NOT NULL,
    StartDate           DATE NOT NULL,
    EndDate             DATE NULL,
    ModifiedDate        DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.EmployeePayHistory', 'U') IS NOT NULL
    DROP TABLE bronze.EmployeePayHistory;
GO
CREATE TABLE bronze.EmployeePayHistory (
    BusinessEntityID    INT NOT NULL,
    RateChangeDate      DATETIME NOT NULL,
    Rate                MONEY NOT NULL,
    PayFrequency        TINYINT NOT NULL,
    ModifiedDate        DATETIME NOT NULL
);
GO


IF OBJECT_ID('bronze.Shift', 'U') IS NOT NULL
    DROP TABLE bronze.[Shift];
GO
CREATE TABLE bronze.[Shift] (
    ShiftID         TINYINT NOT NULL,
    Name            NVARCHAR(50) NOT NULL,
    StartTime       TIME NOT NULL,
    EndTime         TIME NOT NULL,
    ModifiedDate    DATETIME NOT NULL
);
GO
