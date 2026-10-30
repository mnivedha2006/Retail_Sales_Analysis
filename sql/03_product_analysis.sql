-- 03_product_analysis.sql: Top-selling products by revenue and quantity sold

SELECT TOP 20
    StockCode,
    Description,
    SUM(Quantity) AS total_units_sold,
    SUM(Quantity * UnitPrice) AS total_revenue,
    COUNT(DISTINCT InvoiceNo) AS total_orders
FROM online_retail
WHERE Quantity > 0 -- Focusing on positive sales to find top-performing products
GROUP BY StockCode, Description
ORDER BY total_revenue DESC;
