-- ============================================
-- STEP 1: DROP DATABASE IF EXISTS
-- ============================================
USE master;
GO

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'FinanceAnalytics')
BEGIN
    ALTER DATABASE FinanceAnalytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE FinanceAnalytics;
END
GO

-- ============================================
-- STEP 2: CREATE FRESH DATABASE
-- ============================================
CREATE DATABASE FinanceAnalytics;
GO

USE FinanceAnalytics;
GO

-- ============================================
-- STEP 3: CREATE ALL TABLES
-- ============================================

-- DimDepartment
CREATE TABLE DimDepartment (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50),
    ManagerName VARCHAR(100)
);

-- DimRegion
CREATE TABLE DimRegion (
    RegionID INT PRIMARY KEY,
    RegionName VARCHAR(50),
    Country VARCHAR(50)
);

-- DimProduct
CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    UnitPrice DECIMAL(10,2)
);

-- DimDate
CREATE TABLE DimDate (
    DateID INT PRIMARY KEY,
    FullDate DATE,
    Year INT,
    Month INT,
    Quarter INT,
    MonthName VARCHAR(20)
);

-- FactFinance
CREATE TABLE FactFinance (
    TransactionID INT PRIMARY KEY,
    ProductID INT,
    DepartmentID INT,
    RegionID INT,
    DateID INT,
    Revenue DECIMAL(10,2),
    Cost DECIMAL(10,2),
    Quantity INT
);

-- ============================================
-- STEP 4: INSERT DATA INTO DIMENSION TABLES
-- ============================================

-- DimDepartment (5 rows)
INSERT INTO DimDepartment VALUES 
(1, 'Sales', 'John Smith'),
(2, 'Marketing', 'Sarah Jones'),
(3, 'R&D', 'David Chen'),
(4, 'Operations', 'Maria Garcia'),
(5, 'Finance', 'Robert Wilson');

-- DimRegion (5 rows)
INSERT INTO DimRegion VALUES 
(1, 'North', 'USA'),
(2, 'South', 'USA'),
(3, 'East', 'USA'),
(4, 'West', 'USA'),
(5, 'International', 'Canada');

-- DimProduct (8 rows)
INSERT INTO DimProduct VALUES 
(101, 'Laptop Pro', 'Electronics', 1200.00),
(102, 'Office Software', 'Software', 299.99),
(103, 'Cloud Storage', 'Software', 49.99),
(104, 'IT Consulting', 'Services', 250.00),
(105, 'External SSD', 'Hardware', 89.99),
(106, 'Video Software', 'Software', 199.99),
(107, 'Data Analytics', 'Services', 500.00),
(108, 'Wireless Mouse', 'Electronics', 25.00);

-- DimDate (12 rows)
INSERT INTO DimDate VALUES 
(20240101, '2024-01-01', 2024, 1, 1, 'January'),
(20240201, '2024-02-01', 2024, 2, 1, 'February'),
(20240301, '2024-03-01', 2024, 3, 1, 'March'),
(20240401, '2024-04-01', 2024, 4, 2, 'April'),
(20240501, '2024-05-01', 2024, 5, 2, 'May'),
(20240601, '2024-06-01', 2024, 6, 2, 'June'),
(20240701, '2024-07-01', 2024, 7, 3, 'July'),
(20240801, '2024-08-01', 2024, 8, 3, 'August'),
(20240901, '2024-09-01', 2024, 9, 3, 'September'),
(20241001, '2024-10-01', 2024, 10, 4, 'October'),
(20241101, '2024-11-01', 2024, 11, 4, 'November'),
(20241201, '2024-12-01', 2024, 12, 4, 'December');

-- ============================================
-- STEP 5: INSERT ALL 57 TRANSACTIONS INTO FactFinance
-- ============================================

INSERT INTO FactFinance VALUES 
(1001, 101, 1, 1, 20240101, 12000, 7200, 10),
(1002, 102, 1, 1, 20240101, 2999, 1200, 10),
(1003, 103, 2, 2, 20240101, 4999, 2000, 100),
(1004, 104, 3, 3, 20240101, 5000, 3000, 20),
(1005, 105, 4, 4, 20240101, 26997, 15000, 300),
(1006, 101, 1, 5, 20240201, 6000, 3600, 5),
(1007, 102, 1, 1, 20240201, 1499, 600, 5),
(1008, 106, 2, 2, 20240201, 9999, 4000, 50),
(1009, 107, 3, 3, 20240201, 10000, 6000, 20),
(1010, 108, 4, 4, 20240201, 2500, 1250, 100),
(1011, 101, 1, 1, 20240301, 24000, 14400, 20),
(1012, 103, 2, 2, 20240301, 4999, 2000, 100),
(1013, 104, 3, 5, 20240301, 7500, 4500, 30),
(1014, 105, 4, 1, 20240301, 8990, 5000, 100),
(1015, 106, 1, 2, 20240301, 5999, 2400, 30),
(1016, 107, 2, 3, 20240401, 15000, 9000, 30),
(1017, 108, 3, 4, 20240401, 5000, 2500, 200),
(1018, 101, 4, 5, 20240401, 18000, 10800, 15),
(1019, 102, 1, 1, 20240401, 2999, 1200, 10),
(1020, 103, 2, 2, 20240401, 2499, 1000, 50),
(1021, 104, 3, 3, 20240501, 10000, 6000, 40),
(1022, 105, 4, 4, 20240501, 17980, 10000, 200),
(1023, 106, 5, 5, 20240501, 3999, 1600, 20),
(1024, 107, 1, 1, 20240501, 25000, 15000, 50),
(1025, 108, 2, 2, 20240501, 1250, 625, 50),
(1026, 101, 3, 3, 20240601, 12000, 7200, 10),
(1027, 102, 4, 4, 20240601, 5998, 2400, 20),
(1028, 103, 5, 5, 20240601, 4999, 2000, 100),
(1029, 104, 1, 1, 20240601, 5000, 3000, 20),
(1030, 105, 2, 2, 20240601, 8990, 5000, 100),
(1031, 106, 3, 3, 20240701, 9998, 4000, 50),
(1032, 107, 4, 4, 20240701, 10000, 6000, 20),
(1033, 108, 5, 5, 20240701, 2500, 1250, 100),
(1034, 101, 1, 1, 20240701, 24000, 14400, 20),
(1035, 102, 2, 2, 20240701, 4498, 1800, 15),
(1036, 103, 3, 3, 20240801, 7498, 3000, 150),
(1037, 104, 4, 4, 20240801, 12500, 7500, 50),
(1038, 105, 5, 5, 20240801, 13485, 7500, 150),
(1039, 106, 1, 1, 20240801, 7999, 3200, 40),
(1040, 107, 2, 2, 20240801, 15000, 9000, 30),
(1041, 108, 3, 3, 20240901, 3750, 1875, 150),
(1042, 101, 4, 4, 20240901, 12000, 7200, 10),
(1043, 102, 5, 5, 20240901, 2999, 1200, 10),
(1044, 103, 1, 1, 20240901, 4999, 2000, 100),
(1045, 104, 2, 2, 20241001, 7500, 4500, 30),
(1046, 105, 3, 3, 20241001, 17980, 10000, 200),
(1047, 106, 4, 4, 20241001, 11998, 4800, 60),
(1048, 107, 5, 5, 20241001, 20000, 12000, 40),
(1049, 108, 1, 1, 20241101, 5000, 2500, 200),
(1050, 101, 2, 2, 20241101, 18000, 10800, 15),
(1051, 102, 3, 3, 20241101, 5998, 2400, 20),
(1052, 103, 4, 4, 20241101, 4999, 2000, 100),
(1053, 104, 5, 5, 20241201, 10000, 6000, 40),
(1054, 105, 1, 1, 20241201, 26997, 15000, 300),
(1055, 106, 2, 2, 20241201, 7999, 3200, 40),
(1056, 107, 3, 3, 20241201, 25000, 15000, 50),
(1057, 108, 4, 4, 20241201, 6250, 3125, 250);

-- ============================================
-- STEP 6: VERIFY (Simple queries - run separately)
-- ============================================

-- Run these one by one after the script completes:
-- SELECT COUNT(*) FROM DimDepartment;
-- SELECT COUNT(*) FROM DimRegion;
-- SELECT COUNT(*) FROM DimProduct;
-- SELECT COUNT(*) FROM DimDate;
-- SELECT COUNT(*) FROM FactFinance;