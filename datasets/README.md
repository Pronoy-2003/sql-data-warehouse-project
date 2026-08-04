# Dataset

This project uses the **Microsoft AdventureWorks2025 OLTP** sample database as the source system for building the SQL Data Warehouse.

## Official Download

Download the AdventureWorks2025 sample database from Microsoft's official website: https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure

## Setup Instructions

1. Download **AdventureWorks2025.bak** from the Microsoft Learn page.
2. Restore the backup into Microsoft SQL Server using SQL Server Management Studio (SSMS).
3. Execute the Bronze Layer scripts.
4. Execute the Silver Layer scripts.
5. Execute the Gold Layer scripts.
6. Open the Power BI report (`.pbix`) to explore the dashboards.

## Source Database

- **Database:** AdventureWorks2025 (OLTP)
- **Source:** Microsoft Sample Database
- **Version:** SQL Server 2025
- **Format:** `.bak` (SQL Server Backup)

> **Note:** The AdventureWorks2025 database is **not included in this repository** due to its large file size. Please download it from Microsoft's official website using the link above.