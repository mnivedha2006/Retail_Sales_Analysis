-- 01_data_quality.sql: Check for null values, total record counts, and data anomalies
SELECT 
    COUNT(*) AS total_records,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS missing_customer_ids,
    SUM(CASE WHEN Quantity < 0 THEN 1 ELSE 0 END) AS cancellation_records,
    SUM(CASE WHEN UnitPrice <= 0 THEN 1 ELSE 0 END) AS invalid_prices
FROM online_retail;
