# Data Catalog for Gold Layer

## Overview

The **Gold Layer** is the final, business-ready layer of the SQL Data Warehouse. It is designed to support business intelligence, reporting, dashboarding, and analytical workloads by providing a clean, integrated, and dimensional data model.

The Gold Layer is built from the transformed data available in the Silver Layer and consists of **Dimension Views** and **Fact Views** organized in a star schema. These views serve as the semantic layer for Power BI dashboards and enable fast, consistent, and reliable business analysis across multiple departments.

The Gold Layer contains **7 Dimension Views** and **3 Fact Views**.

---

## Dimension Views

## 1. gold.dim_customer

**Purpose:**  
Stores customer master data by consolidating customer, person, store, and contact information into a single business-friendly dimension. This dimension supports customer segmentation, sales analysis, and customer-centric reporting.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| CustomerKey | INT | Surrogate key uniquely identifying each customer record in the dimension view. |
| CustomerID | INT | Business key uniquely identifying the customer. |
| PersonID | INT | Identifier of the associated person record for individual customers. |
| StoreID | INT | Identifier of the associated store for store customers. |
| TerritoryID | INT | Identifier of the sales territory assigned to the customer. |
| CustomerTitle | NVARCHAR(8) | Customer title (e.g., Mr., Mrs., Ms.). |
| CustomerFirstName | NVARCHAR(50) | Customer's first name. |
| MiddleName | NVARCHAR(50) | Customer's middle name. |
| CustomerLastName | NVARCHAR(50) | Customer's last name or family name. |
| FullName | NVARCHAR(155) | Customer's complete name formed by combining first, middle, and last names. |
| CustomerEmail | NVARCHAR(50) | Primary email address of the customer. |
| CustomerPhone | NVARCHAR(25) | Primary contact phone number of the customer. |
| StoreName | NVARCHAR(50) | Name of the store associated with the customer, if applicable. |
| AccountNumber | VARCHAR(10) | Unique account number assigned to the customer. |
| CustomerType | VARCHAR(20) | Classification of the customer (e.g., Individual or Store). |

**Source Table:**  
`silver.Customer`

**Business Usage:**

- Customer segmentation
- Sales performance by customer
- Customer contact reporting
- Customer distribution by territory
- Customer profile analysis
- Power BI customer dashboards

---
## 2. gold.dim_product

**Purpose:**  
Stores product master data by consolidating product information, category hierarchy, pricing, manufacturing details, and product attributes into a single business-friendly dimension. This dimension supports product performance analysis, inventory reporting, sales analysis, and product portfolio management.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| ProductKey | INT | Surrogate key uniquely identifying each product record in the dimension view. |
| ProductID | INT | Business key uniquely identifying the product. |
| ProductName | NVARCHAR(50) | Descriptive name of the product. |
| ProductNumber | NVARCHAR(25) | Unique alphanumeric product number assigned to the product. |
| CategoryName | NVARCHAR(50) | High-level product category (e.g., Bikes, Components, Clothing). |
| SubcategoryName | NVARCHAR(50) | Detailed product classification within the product category. |
| Color | NVARCHAR(15) | Color of the product. |
| Size | NVARCHAR(5) | Size specification of the product. |
| Weight | DECIMAL(8,2) | Weight of the product. |
| ProductLine | NCHAR(2) | Product line classification (e.g., Road, Mountain, Touring). |
| Class | NCHAR(2) | Product class or quality classification. |
| Style | NCHAR(2) | Product style classification. |
| DaysToManufacture | INT | Number of days required to manufacture the product. |
| StandardCost | MONEY | Standard manufacturing cost of the product. |
| ListPrice | MONEY | Standard selling price of the product. |
| SellStartDate | DATETIME | Date when the product became available for sale. |
| SellEndDate | DATETIME | Date when the product was discontinued from sale, if applicable. |
| DiscontinuedDate | DATETIME | Date when the product was officially discontinued. |
| ProfitMargin | MONEY | Calculated profit earned per unit (List Price − Standard Cost). |
| ProfitMarginPct | DECIMAL(10,2) | Calculated profit margin percentage of the product. |
| ProductStatus | VARCHAR(20) | Current product status (e.g., Active, Discontinued). |
| PriceCategory | VARCHAR(20) | Product price classification (e.g., Low, Medium, High). |

**Source Table:**  
`silver.Product`

**Business Usage:**

- Product performance analysis
- Product portfolio management
- Sales analysis by category and subcategory
- Product profitability analysis
- Inventory valuation
- Manufacturing analysis
- Power BI product dashboards

---
## 3. gold.dim_employee

**Purpose:**  
Stores employee master data by consolidating employee, department, shift, and compensation information into a single business-friendly dimension. This dimension supports workforce analytics, procurement reporting, departmental performance analysis, and human resource reporting.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| EmployeeKey | INT | Surrogate key uniquely identifying each employee record in the dimension view. |
| EmployeeID | INT | Business key uniquely identifying the employee. |
| EmployeeFirstName | NVARCHAR(50) | Employee's first name. |
| MiddleName | NVARCHAR(50) | Employee's middle name. |
| EmployeeLastName | NVARCHAR(50) | Employee's last name or family name. |
| FullName | NVARCHAR(155) | Employee's complete name formed by combining first, middle, and last names. |
| JobTitle | NVARCHAR(50) | Official job title or designation of the employee. |
| DepartmentID | SMALLINT | Identifier of the department where the employee works. |
| DepartmentName | NVARCHAR(50) | Name of the employee's department. |
| ShiftID | TINYINT | Identifier of the work shift assigned to the employee. |
| ShiftName | NVARCHAR(50) | Name of the employee's work shift (e.g., Day, Evening, Night). |
| BirthDate | DATE | Employee's date of birth. |
| Gender | NCHAR(1) | Employee's gender. |
| MaritalStatus | NCHAR(1) | Employee's marital status. |
| HireDate | DATE | Date when the employee joined the organization. |
| HourlyRate | MONEY | Hourly pay rate of the employee. |
| PayFrequency | TINYINT | Frequency at which the employee is paid. |
| VacationHours | SMALLINT | Total accumulated vacation hours available to the employee. |
| SickLeaveHours | SMALLINT | Total accumulated sick leave hours available to the employee. |
| CurrentFlag | BIT | Indicates whether the employee is currently active (1 = Active, 0 = Inactive). |
| Age | INT | Calculated age of the employee. |
| YearsExperience | INT | Calculated years of service since the employee's hire date. |
| SalaryBand | VARCHAR(20) | Salary category derived from the employee's hourly rate. |
| EmploymentStatus | VARCHAR(20) | Current employment status (e.g., Active, Inactive). |

**Source Table:**  
`silver.Employee`

**Business Usage:**

- Employee performance analysis
- Department workforce reporting
- Procurement activity by employee
- Workforce demographic analysis
- Salary and compensation analysis
- Employee experience analysis
- HR operational reporting
- Power BI HR dashboards

---
## 4. gold.dim_vendor

**Purpose:**  
Stores vendor master data by consolidating vendor information, purchasing details, lead time metrics, pricing, and ordering constraints into a single business-friendly dimension. This dimension supports procurement analysis, supplier performance evaluation, vendor comparison, and purchasing decision-making.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| VendorKey | INT | Surrogate key uniquely identifying each vendor record in the dimension view. |
| VendorID | INT | Business key uniquely identifying the vendor. |
| VendorName | NVARCHAR(50) | Name of the vendor or supplier. |
| AccountNumber | NVARCHAR(15) | Unique account number assigned to the vendor. |
| CreditRating | TINYINT | Credit rating assigned to the vendor, indicating financial reliability. |
| PreferredVendorStatus | BIT | Indicates whether the vendor is marked as a preferred supplier (1 = Preferred, 0 = Not Preferred). |
| ActiveFlag | BIT | Indicates whether the vendor is currently active (1 = Active, 0 = Inactive). |
| AverageLeadTime | INT | Average number of days required by the vendor to deliver products. |
| StandardPrice | MONEY | Standard purchase price offered by the vendor for the product. |
| LastReceiptCost | MONEY | Cost of the most recent product receipt from the vendor. |
| LastReceiptDate | DATETIME | Date when the last shipment was received from the vendor. |
| MinOrderQty | INT | Minimum quantity that can be ordered from the vendor. |
| MaxOrderQty | INT | Maximum quantity that can be ordered from the vendor. |
| OnOrderQty | INT | Quantity currently on order from the vendor. |
| LeadTimeCategory | VARCHAR(20) | Categorized lead time based on average delivery duration (e.g., Fast, Medium, Slow). |
| VendorStatus | VARCHAR(20) | Current vendor status derived from the ActiveFlag (e.g., Active, Inactive). |

**Source Table:**  
`silver.Vendor`

**Business Usage:**

- Vendor performance analysis
- Supplier comparison
- Procurement planning
- Lead time analysis
- Purchase cost analysis
- Preferred vendor evaluation
- Supply chain performance reporting
- Power BI procurement dashboards

---
## 5. gold.dim_location

**Purpose:**  
Stores geographical and address-related master data by consolidating address, city, state/province, country, and sales territory information into a single business-friendly dimension. This dimension supports regional analysis, customer location reporting, territory performance analysis, and geographic business intelligence.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| LocationKey | INT | Surrogate key uniquely identifying each location record in the dimension view. |
| AddressID | INT | Business key uniquely identifying the address. |
| AddressLine1 | NVARCHAR(60) | Primary street address of the location. |
| AddressLine2 | NVARCHAR(60) | Secondary address information such as apartment, suite, or building number. |
| City | NVARCHAR(30) | City where the address is located. |
| StateProvince | NVARCHAR(50) | State or province associated with the address. |
| CountryName | NVARCHAR(50) | Country in which the address is located. |
| PostalCode | NVARCHAR(15) | Postal or ZIP code of the address. |
| TerritoryID | INT | Business key identifying the sales territory associated with the location. |
| FullAddress | NVARCHAR(250) | Complete formatted address created by combining the address components. |

**Source Table:**  
`silver.Location`

**Business Usage:**

- Geographic sales analysis
- Customer location reporting
- Sales territory analysis
- Regional business performance reporting
- Address-based business intelligence
- Country and state-level analytics
- Power BI geographic dashboards

---
## 6. gold.dim_sales_territory

**Purpose:**  
Stores sales territory master data, including regional sales performance, cost metrics, and growth indicators. This dimension supports regional sales analysis, performance comparison, market evaluation, and executive reporting across different geographical territories.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| TerritoryKey | INT | Surrogate key uniquely identifying each sales territory record in the dimension view. |
| TerritoryID | INT | Business key uniquely identifying the sales territory. |
| TerritoryName | NVARCHAR(50) | Name of the sales territory or region. |
| CountryRegionCode | NVARCHAR(3) | Standard country or region code associated with the territory (e.g., US, CA, FR). |
| TerritoryGroup | NVARCHAR(50) | Geographic group or region to which the sales territory belongs (e.g., North America, Europe, Pacific). |
| SalesYTD | MONEY | Year-to-date sales revenue generated within the territory. |
| SalesLastYear | MONEY | Total sales revenue generated during the previous year. |
| CostYTD | MONEY | Year-to-date operational or sales-related costs incurred within the territory. |
| CostLastYear | MONEY | Total operational or sales-related costs incurred during the previous year. |
| Profit | MONEY | Calculated profit for the territory (SalesYTD − CostYTD). |
| GrowthRate | DECIMAL(10,2) | Calculated percentage growth in sales compared to the previous year. |

**Source Table:**  
`silver.SalesTerritory`

**Business Usage:**

- Regional sales performance analysis
- Territory comparison and benchmarking
- Sales growth trend analysis
- Profitability analysis by territory
- Country and regional performance reporting
- Executive sales reporting
- Sales planning and forecasting
- Power BI regional sales dashboards

## 7. gold.dim_promotion

**Purpose:**  
Stores promotion and special offer information by consolidating discount details, promotion categories, eligibility criteria, and promotion duration into a single business-friendly dimension. This dimension supports promotion effectiveness analysis, discount reporting, sales campaign evaluation, and marketing performance analysis.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| PromotionKey | INT | Surrogate key uniquely identifying each promotion record in the dimension view. |
| SpecialOfferID | INT | Business key uniquely identifying the promotion or special offer. |
| ProductID | INT | Business key identifying the product associated with the promotion. |
| Description | NVARCHAR(255) | Description of the promotion or special offer. |
| DiscountPct | SMALLMONEY | Discount percentage offered for the promotion. |
| PromotionType | NVARCHAR(50) | Type of promotion (e.g., Discount, Seasonal Offer, Volume Discount). |
| PromotionCategory | NVARCHAR(50) | Business category of the promotion used for marketing analysis. |
| StartDate | DATETIME | Date on which the promotion becomes effective. |
| EndDate | DATETIME | Date on which the promotion expires. |
| MinQty | INT | Minimum quantity required to qualify for the promotion. |
| MaxQty | INT | Maximum quantity eligible for the promotion, if applicable. |
| PromotionStatus | VARCHAR(20) | Current status of the promotion (e.g., Active, Expired). |
| PromotionDuration | INT | Total duration of the promotion in days. |

**Source Table:**  
`silver.Promotion`

**Business Usage:**

- Promotion effectiveness analysis
- Discount performance reporting
- Sales campaign analysis
- Marketing performance evaluation
- Product promotion tracking
- Seasonal promotion analysis
- Revenue impact of promotional offers
- Power BI marketing and sales dashboards

---

## Fact Views

## 8. gold.fact_sales

**Purpose:**  
Stores sales transaction data by combining order information, customer details, product references, sales territory, shipping details, promotional offers, and financial measures into a single business-ready fact view. This fact view serves as the primary source for sales analytics, revenue reporting, profitability analysis, and business intelligence dashboards.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| SalesOrderID | INT | Business key uniquely identifying each sales order. |
| SalesOrderDetailID | INT | Business key uniquely identifying each sales order line item. |
| OrderDate | DATETIME | Date when the customer placed the sales order. |
| DueDate | DATETIME | Expected due date for the sales order. |
| ShipDate | DATETIME | Date when the sales order was shipped to the customer. |
| CustomerID | INT | Business key identifying the customer associated with the sales order. |
| SalesPersonID | INT | Identifier of the salesperson responsible for the sales transaction. |
| TerritoryID | INT | Business key identifying the sales territory where the transaction occurred. |
| ShipMethodID | INT | Identifier of the shipping method used to deliver the order. |
| ProductID | INT | Business key identifying the product sold. |
| SpecialOfferID | INT | Business key identifying the promotion or special offer applied to the sales order. |
| OrderQty | SMALLINT | Quantity of products ordered in the sales transaction. |
| UnitPrice | MONEY | Selling price per unit of the product before discounts. |
| UnitPriceDiscount | MONEY | Discount amount applied to each unit of the product. |
| LineTotal | NUMERIC(38,6) | Total sales amount for the order line after applying quantity and discounts. |
| SubTotal | MONEY | Total value of all line items before taxes and freight charges. |
| TaxAmt | MONEY | Tax amount applied to the sales order. |
| Freight | MONEY | Freight or shipping cost charged for the sales order. |
| TotalDue | MONEY | Final amount payable by the customer, including subtotal, tax, and freight. |
| Status | TINYINT | Current processing status of the sales order. |
| OnlineOrderFlag | BIT | Indicates whether the order was placed online (1 = Online, 0 = Offline). |
| GrossSales | MONEY | Calculated gross sales amount before applying discounts. |
| DiscountAmount | MONEY | Total discount amount applied to the sales transaction. |
| NetSales | MONEY | Final sales revenue after deducting discounts. |
| ShippingDays | INT | Number of days between the order date and ship date. |
| OrderYear | SMALLINT | Calendar year in which the sales order was placed. |
| OrderQuarter | TINYINT | Calendar quarter in which the sales order was placed. |
| OrderMonth | TINYINT | Calendar month in which the sales order was placed. |
| OrderWeek | TINYINT | Calendar week number in which the sales order was placed. |
| IsLateShipment | BIT | Indicates whether the shipment was delivered later than the due date (1 = Late, 0 = On Time). |

**Source Table:**  
`silver.Sales`

**Business Usage:**

- Sales performance analysis
- Revenue and profitability reporting
- Sales trend analysis
- Customer purchasing analysis
- Product sales analysis
- Territory performance analysis
- Promotion effectiveness analysis
- Order fulfillment and shipping analysis
- Executive sales reporting
- Power BI sales dashboards

---
## 9. gold.fact_purchase

**Purpose:**  
Stores purchase transaction data by combining purchase order information, vendor details, employee references, product information, shipping details, receiving quantities, and financial measures into a single business-ready fact view. This fact view supports procurement analytics, vendor performance evaluation, purchasing cost analysis, supply chain reporting, and business intelligence dashboards.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| PurchaseOrderID | INT | Business key uniquely identifying each purchase order. |
| VendorID | INT | Business key identifying the vendor supplying the purchased products. |
| EmployeeID | INT | Business key identifying the employee responsible for the purchase order. |
| ShipMethodID | INT | Identifier of the shipping method used for product delivery. |
| ProductID | INT | Business key identifying the purchased product. |
| OrderDate | DATETIME | Date when the purchase order was created. |
| DueDate | DATETIME | Expected delivery date of the purchase order. |
| ShipDate | DATETIME | Actual date when the purchase order was shipped by the vendor. |
| OrderQty | SMALLINT | Quantity of products ordered from the vendor. |
| UnitPrice | MONEY | Purchase price per unit of the product. |
| LineTotal | MONEY | Total cost of the purchase order line (Unit Price × Quantity). |
| ReceivedQty | DECIMAL(8,2) | Quantity of products successfully received from the vendor. |
| RejectedQty | DECIMAL(8,2) | Quantity of products rejected due to quality or other issues. |
| StockedQty | DECIMAL(9,2) | Quantity of products accepted into inventory after inspection. |
| SubTotal | MONEY | Total purchase amount before taxes and freight charges. |
| TaxAmt | MONEY | Tax amount applied to the purchase order. |
| Freight | MONEY | Freight or shipping cost associated with the purchase order. |
| TotalDue | MONEY | Final payable amount for the purchase order, including subtotal, tax, and freight. |
| DeliveryDays | INT | Number of days between the purchase order date and shipment date. |
| ReceivedPercentage | DECIMAL(5,2) | Percentage of ordered quantity successfully received from the vendor. |
| RejectedPercentage | DECIMAL(5,2) | Percentage of ordered quantity rejected during the receiving process. |

**Source Table:**  
`silver.Purchase`

**Business Usage:**

- Procurement performance analysis
- Purchase cost analysis
- Vendor performance evaluation
- Purchase order monitoring
- Delivery performance analysis
- Product receiving analysis
- Supply chain performance reporting
- Procurement KPI reporting
- Executive procurement dashboards
- Power BI procurement dashboards

---
## 10. gold.fact_inventory

**Purpose:**  
Stores inventory transaction data by combining inventory quantities, warehouse locations, product references, transaction history, inventory valuation, and stock status into a single business-ready fact view. This fact view supports inventory monitoring, stock valuation, warehouse management, inventory movement analysis, and business intelligence reporting.

**Columns:**

| Column Name | Data Type | Description |
|-------------|-----------|-------------|
| ProductID | INT | Business key identifying the product associated with the inventory transaction. |
| LocationID | SMALLINT | Business key identifying the warehouse or storage location where the inventory is maintained. |
| TransactionDate | DATETIME | Date and time when the inventory transaction occurred. |
| TransactionType | NCHAR(1) | Type of inventory transaction (e.g., purchase, sale, adjustment, transfer). |
| Quantity | SMALLINT | Quantity of product available or affected by the inventory transaction. |
| ActualCost | MONEY | Actual cost incurred for the inventory transaction. |
| StandardCost | MONEY | Standard cost assigned to the product for inventory valuation. |
| ListPrice | MONEY | Standard selling price of the product used for comparison and profitability analysis. |
| InventoryValue | MONEY | Calculated monetary value of the inventory (Quantity × Standard Cost). |
| InventoryAge | INT | Number of days since the inventory transaction occurred. |
| StockStatus | VARCHAR(20) | Current inventory status based on available quantity (e.g., In Stock, Low Stock, Out of Stock). |

**Source Table:**  
`silver.Inventory`

**Business Usage:**

- Inventory level monitoring
- Warehouse stock analysis
- Inventory valuation
- Stock availability reporting
- Inventory aging analysis
- Product movement tracking
- Warehouse performance analysis
- Inventory replenishment planning
- Supply chain reporting
- Power BI inventory dashboards

---

