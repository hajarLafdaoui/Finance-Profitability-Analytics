SELECT 
    d.DepartmentName,
    SUM(f.Revenue) AS TotalRevenue,
    SUM(f.Cost) AS TotalCost,
    SUM(f.Revenue) - SUM(f.Cost) AS TotalProfit,
    ((SUM(f.Revenue) - SUM(f.Cost)) / NULLIF(SUM(f.Revenue), 0)) * 100 AS ProfitMarginPercent
FROM FactFinance f
JOIN DimDepartment d ON f.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY ProfitMarginPercent DESC;    

SELECT 
    d.MonthName,
    d.Month,
    SUM(f.Revenue) AS Revenue,
    SUM(f.Cost) AS Cost,
    SUM(SUM(f.Revenue)) OVER (ORDER BY d.Month) AS RunningRevenueTotal,
    SUM(SUM(f.Cost)) OVER (ORDER BY d.Month) AS RunningCostTotal
FROM FactFinance f
JOIN DimDate d ON f.DateID = d.DateID
GROUP BY d.MonthName, d.Month
ORDER BY d.Month;

SELECT 
    r.RegionName,
    SUM(f.Revenue) - SUM(f.Cost) AS TotalProfit,
    RANK() OVER (ORDER BY SUM(f.Revenue) - SUM(f.Cost) DESC) AS ProfitRank
FROM FactFinance f
JOIN DimRegion r ON f.RegionID = r.RegionID
GROUP BY r.RegionName
ORDER BY ProfitRank;

SELECT 
    p.Category,
    SUM(f.Cost) AS TotalCost,
    (SUM(f.Cost) / (SELECT SUM(Cost) FROM FactFinance)) * 100 AS CostPercentage
FROM FactFinance f
JOIN DimProduct p ON f.ProductID = p.ProductID
GROUP BY p.Category
ORDER BY CostPercentage DESC;

SELECT 
    d.MonthName,
    d.Month,
    SUM(f.Revenue) AS Revenue,
    SUM(f.Cost) AS Cost,
    SUM(f.Revenue) - SUM(f.Cost) AS Profit,
    ((SUM(f.Revenue) - SUM(f.Cost)) / NULLIF(SUM(f.Revenue), 0)) * 100 AS MarginPercent
FROM FactFinance f
JOIN DimDate d ON f.DateID = d.DateID
GROUP BY d.MonthName, d.Month
ORDER BY d.Month;

SELECT 
    d.MonthName,
    d.Month,
    SUM(f.Revenue) - SUM(f.Cost) AS MonthlyProfit,
    SUM(SUM(f.Revenue) - SUM(f.Cost)) OVER (ORDER BY d.Month) AS YTD_Profit
FROM FactFinance f
JOIN DimDate d ON f.DateID = d.DateID
GROUP BY d.MonthName, d.Month
ORDER BY d.Month;