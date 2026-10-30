-- 04_customer_analysis.sql: Customer-level transaction activity and top spending customers
-- Note: Excluding rows with missing CustomerIDs as per data quality rules

SELECT TOP 20
    CustomerID,
    Country,
    COUNT(DISTINCT InvoiceNo) AS total_orders,
    SUM(Quantity) AS total_units_purchased,
    SUM(Quantity * UnitPrice) AS total_spend
FROM online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID, Country
ORDER BY total_spend DESC;
