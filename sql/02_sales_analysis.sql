-- 02_sales_analysis.sql: Monthly sales trends and top countries by revenue
-- Note: LineValue represents Quantity * UnitPrice

-- 1. Monthly Sales & Revenue Trend
SELECT 
    FORMAT(InvoiceDate, 'yyyy-MM') AS month_year,
    SUM(Quantity * UnitPrice) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_retail
GROUP BY FORMAT(InvoiceDate, 'yyyy-MM')
ORDER BY month_year;

-- 2. Top 10 Countries by Revenue
SELECT TOP 10
    Country,
    SUM(Quantity * UnitPrice) AS total_revenue,
    COUNT(DISTINCT CustomerID) AS unique_customers
FROM online_retail
GROUP BY Country
ORDER BY total_revenue DESC;
