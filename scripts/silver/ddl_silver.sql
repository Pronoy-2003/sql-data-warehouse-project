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

IF OBJECT_ID('silver.Sales', 'U') IS NOT NULL
    DROP TABLE silver.Sales;
GO
CREATE TABLE silver.Sales
(
    -- Order Information
    SalesOrderID           INT             NOT NULL,
    SalesOrderDetailID     INT             NOT NULL,

    -- Dates
    OrderDate              DATETIME        NOT NULL,
    DueDate                DATETIME        NOT NULL,
    ShipDate               DATETIME        NULL,

    -- Customer Information
    CustomerID             INT             NOT NULL,
    SalesPersonID          INT             NULL,
    TerritoryID            INT             NULL,

    -- Shipping
    ShipMethodID           INT             NOT NULL,

    -- Product Information
    ProductID              INT             NOT NULL,
    SpecialOfferID         INT             NOT NULL,

    -- Order Details
    OrderQty               SMALLINT        NOT NULL,
    UnitPrice              MONEY           NOT NULL,
    UnitPriceDiscount      MONEY           NOT NULL,
    LineTotal              NUMERIC(38,6)   NOT NULL,

    -- Financial Information
    SubTotal               MONEY           NOT NULL,
    TaxAmt                 MONEY           NOT NULL,
    Freight                MONEY           NOT NULL,
    TotalDue               MONEY           NOT NULL,

    -- Order Status
    [Status]               TINYINT         NOT NULL,
    OnlineOrderFlag        BIT             NOT NULL,

    -- Derived Columns
    GrossSales             MONEY           NULL,
    DiscountAmount         MONEY           NULL,
    NetSales               MONEY           NULL,
    ShippingDays           INT             NULL,

    OrderYear              SMALLINT        NULL,
    OrderQuarter           TINYINT         NULL,
    OrderMonth             TINYINT         NULL,
    OrderWeek              TINYINT         NULL,

    IsLateShipment         BIT             NULL,

    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO



IF OBJECT_ID('silver.Customer', 'U') IS NOT NULL
    DROP TABLE silver.Customer;
GO
CREATE TABLE silver.Customer
(
    -- Customer Keys
    CustomerID              INT             NOT NULL,
    PersonID                INT             NULL,
    StoreID                 INT             NULL,
    TerritoryID             INT             NULL,

    -- Customer Information
    CustomerTitle           NVARCHAR(8)     NULL,
    CustomerFirstName       NVARCHAR(50)    NULL,
    MiddleName              NVARCHAR(50)    NULL,
    CustomerLastName        NVARCHAR(50)    NULL,
    FullName                NVARCHAR(155)   NULL,

    -- Contact Information
    CustomerEmail           NVARCHAR(50)    NULL,
    CustomerPhone           NVARCHAR(25)    NULL,

    -- Store Information
    StoreName               NVARCHAR(50)    NULL,

    -- Customer Details
    AccountNumber           VARCHAR(10)     NOT NULL,
    CustomerType            VARCHAR(20)     NULL,

    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO



IF OBJECT_ID('silver.Location', 'U') IS NOT NULL
    DROP TABLE silver.[Location];
GO
CREATE TABLE silver.[Location]
(
    AddressID               INT             NOT NULL,

    AddressLine1            NVARCHAR(60)    NOT NULL,
    AddressLine2            NVARCHAR(60)    NULL,

    City                    NVARCHAR(30)    NOT NULL,
    StateProvince           NVARCHAR(50)    NOT NULL,
    CountryName             NVARCHAR(50)    NOT NULL,

    PostalCode              NVARCHAR(15)    NOT NULL,

    TerritoryID             INT             NOT NULL,

    FullAddress             NVARCHAR(250)   NULL,

    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO



IF OBJECT_ID('silver.Product', 'U') IS NOT NULL
    DROP TABLE silver.[Product];
GO
CREATE TABLE silver.[Product]
(
    -- Product Information
    ProductID               INT             NOT NULL,
    ProductName             NVARCHAR(50)    NOT NULL,
    ProductNumber           NVARCHAR(25)    NOT NULL,

    -- Product Classification
    CategoryName            NVARCHAR(50)    NULL,
    SubcategoryName         NVARCHAR(50)    NULL,

    -- Product Attributes
    Color                   NVARCHAR(15)    NULL,
    [Size]                    NVARCHAR(5)     NULL,
    [Weight]                  DECIMAL(8,2)    NULL,

    ProductLine             NCHAR(2)        NULL,
    Class                   NCHAR(2)        NULL,
    Style                   NCHAR(2)        NULL,

    DaysToManufacture       INT             NOT NULL,

    -- Pricing
    StandardCost            MONEY           NOT NULL,
    ListPrice               MONEY           NOT NULL,

    -- Selling Information
    SellStartDate           DATETIME        NOT NULL,
    SellEndDate             DATETIME        NULL,
    DiscontinuedDate        DATETIME        NULL,

    -- Derived Columns
    ProfitMargin            MONEY           NULL,
    ProfitMarginPct         DECIMAL(10,2)   NULL,
    ProductStatus           VARCHAR(20)     NULL,
    PriceCategory           VARCHAR(20)     NULL,

    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO



IF OBJECT_ID('silver.Inventory', 'U') IS NOT NULL
    DROP TABLE silver.Inventory;
GO
CREATE TABLE silver.Inventory
(
    -- Product Information
    ProductID               INT             NOT NULL,

    -- Warehouse Information
    LocationID              SMALLINT        NOT NULL,
    WarehouseLocationName   NVARCHAR(50)    NOT NULL,
    Shelf                   NVARCHAR(10)    NOT NULL,
    Bin                     TINYINT         NOT NULL,

    -- Inventory
    Quantity                SMALLINT        NOT NULL,

    -- Transaction Information
    TransactionDate         DATETIME        NOT NULL,
    TransactionType         NCHAR(1)        NOT NULL,

    -- Cost Information
    ActualCost              MONEY           NOT NULL,
    StandardCost            MONEY           NOT NULL,
    ListPrice               MONEY           NOT NULL,

    -- Derived Columns
    InventoryValue          MONEY           NULL,
    StockStatus             VARCHAR(20)     NULL,
    InventoryAge            INT             NULL,


    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO



IF OBJECT_ID('silver.Purchase', 'U') IS NOT NULL
    DROP TABLE silver.Purchase;
GO
CREATE TABLE silver.Purchase
(
    -- Purchase Order
    PurchaseOrderID         INT             NOT NULL,

    -- Foreign Keys
    VendorID                INT             NOT NULL,
    EmployeeID              INT             NOT NULL,
    ShipMethodID            INT             NOT NULL,
    ProductID               INT             NOT NULL,

    -- Dates
    OrderDate               DATETIME        NOT NULL,
    DueDate                 DATETIME        NOT NULL,
    ShipDate                DATETIME        NULL,

    -- Order Details
    OrderQty                SMALLINT        NOT NULL,
    UnitPrice               MONEY           NOT NULL,
    LineTotal               MONEY           NOT NULL,

    -- Receiving Details
    ReceivedQty             DECIMAL(8,2)    NOT NULL,
    RejectedQty             DECIMAL(8,2)    NOT NULL,
    StockedQty              DECIMAL(9,2)    NOT NULL,

    -- Financial Details
    SubTotal                MONEY           NOT NULL,
    TaxAmt                  MONEY           NOT NULL,
    Freight                 MONEY           NOT NULL,
    TotalDue                MONEY           NOT NULL,

    -- Derived Columns
    DeliveryDays            INT             NULL,
    ReceivedPercentage      DECIMAL(5,2)    NULL,
    RejectedPercentage      DECIMAL(5,2)    NULL,


    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO



IF OBJECT_ID('silver.Vendor', 'U') IS NOT NULL
    DROP TABLE silver.Vendor;
GO
CREATE TABLE silver.Vendor
(
    -- Vendor Information
    VendorID                INT             NOT NULL,
    VendorName              NVARCHAR(50)    NOT NULL,
    AccountNumber           NVARCHAR(15)    NOT NULL,

    -- Vendor Status
    CreditRating            TINYINT         NOT NULL,
    PreferredVendorStatus   BIT             NOT NULL,
    ActiveFlag              BIT             NOT NULL,

    -- Product Information
    ProductID               INT             NOT NULL,

    -- Purchasing Information
    AverageLeadTime         INT             NOT NULL,
    StandardPrice           MONEY           NOT NULL,
    LastReceiptCost         MONEY           NULL,
    LastReceiptDate         DATETIME        NULL,

    -- Ordering Limits
    MinOrderQty             INT             NOT NULL,
    MaxOrderQty             INT             NOT NULL,
    OnOrderQty              INT             NULL,

    -- Derived Columns
    LeadTimeCategory        VARCHAR(20)     NULL,
    VendorStatus            VARCHAR(20)     NULL,


    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO



IF OBJECT_ID('silver.Employee', 'U') IS NOT NULL
    DROP TABLE silver.Employee;
GO
CREATE TABLE silver.Employee
(
    -- Employee Keys
    EmployeeID              INT             NOT NULL,

    -- Employee Information
    EmployeeFirstName       NVARCHAR(50)    NOT NULL,
    MiddleName              NVARCHAR(50)    NULL,
    EmployeeLastName        NVARCHAR(50)    NOT NULL,
    FullName                NVARCHAR(155)   NULL,

    JobTitle                NVARCHAR(50)    NOT NULL,

    -- Department Information
    DepartmentID            SMALLINT        NOT NULL,
    DepartmentName          NVARCHAR(50)    NOT NULL,

    -- Shift Information
    ShiftID                 TINYINT         NOT NULL,
    ShiftName               NVARCHAR(50)    NOT NULL,

    -- Personal Information
    BirthDate               DATE            NOT NULL,
    Gender                  NCHAR(1)        NOT NULL,
    MaritalStatus           NCHAR(1)        NOT NULL,

    -- Employment Information
    HireDate                DATE            NOT NULL,
    HourlyRate              MONEY           NOT NULL,
    PayFrequency            TINYINT         NOT NULL,

    VacationHours           SMALLINT        NOT NULL,
    SickLeaveHours          SMALLINT        NOT NULL,
    CurrentFlag             BIT             NOT NULL,

    -- Derived Columns
    Age                     INT             NULL,
    YearsExperience         INT             NULL,
    SalaryBand              VARCHAR(20)     NULL,
    EmploymentStatus        VARCHAR(20)     NULL,


    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO



IF OBJECT_ID('silver.SalesTerritory', 'U') IS NOT NULL
    DROP TABLE silver.SalesTerritory;
GO
CREATE TABLE silver.SalesTerritory
(
    TerritoryID             INT             NOT NULL,

    TerritoryName           NVARCHAR(50)    NOT NULL,
    CountryRegionCode       NVARCHAR(3)     NOT NULL,
    TerritoryGroup          NVARCHAR(50)    NOT NULL,

    SalesYTD                MONEY           NOT NULL,
    SalesLastYear           MONEY           NOT NULL,

    CostYTD                 MONEY           NOT NULL,
    CostLastYear            MONEY           NOT NULL,

    -- Derived Columns
    Profit                  MONEY           NULL,
    GrowthRate              DECIMAL(10,2)   NULL,


    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO



IF OBJECT_ID('silver.Promotion', 'U') IS NOT NULL
    DROP TABLE silver.Promotion;
GO
CREATE TABLE silver.Promotion
(
    -- Promotion Information
    SpecialOfferID          INT             NOT NULL,
    ProductID               INT             NOT NULL,

    [Description]           NVARCHAR(255)   NOT NULL,

    DiscountPct             SMALLMONEY      NOT NULL,

    PromotionType           NVARCHAR(50)    NOT NULL,
    PromotionCategory       NVARCHAR(50)    NOT NULL,

    StartDate               DATETIME        NOT NULL,
    EndDate                 DATETIME        NOT NULL,

    MinQty                  INT             NOT NULL,
    MaxQty                  INT             NULL,

    -- Derived Columns
    PromotionStatus         VARCHAR(20)     NULL,
    PromotionDuration       INT             NULL,


    dwh_create_date    DATETIME2 DEFAULT GETDATE()
);
GO
