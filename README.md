# Retail Sales & Profitability Analysis (2010–2011)

> **Portfolio Case Study 01**: End-to-end data analysis project investigating online retail transaction patterns, revenue drivers, customer concentration, and returns/cancellations to provide actionable business recommendations.

---

##  1. Executive Summary
* **Business Problem:** Management needed to understand what drives online revenue, identify sales concentrations across products and countries, and measure the impact of customer cancellations and returns.
* **Key Approach:** Inspected transactional data, cleaned data anomalies (cancellations and missing IDs), executed SQL aggregations, built interactive Power BI visualizations, and formulated evidence-backed business recommendations.
* **Key Findings:** *(To be updated upon completing the analysis)*
* **Tools Used:** Excel, SQL, Power BI, GitHub.

---

##  2. Business Context & Research Questions
As a Junior Business Analyst handling historical online retail transaction data, the core research questions are:
1. Which products and countries contribute most to total revenue?
2. Which months show stronger or weaker sales performance?
3. How concentrated are sales among individual customers?
4. How do cancellations and returns affect net sales figures?
5. What practical actions should the business investigate to improve revenue stability and performance?

---

##  3. Dataset Information
* **Source:** UCI Machine Learning Repository — [Online Retail Dataset](https://archive.ics.uci.edu/ml/datasets/online+retail)
* **Scope:** 541,909 transaction records from a UK-based online retailer between 01/12/2010 and 09/12/2011.
* **Key Columns:** `InvoiceNo`, `StockCode`, `Description`, `Quantity`, `InvoiceDate`, `UnitPrice`, `CustomerID`, `Country`.
* **Data Limitations:** The dataset contains transaction quantities and prices, but lacks product cost data (COGS) or operating expenses. Analysis is therefore focused strictly on **revenue performance, sales trends, and revenue leakage** rather than true net profit.

---

##  4. Data Cleaning & Methodology
Before performing calculations, data quality issues were systematically identified and documented in [`docs/data-quality-report.md`](docs/data-quality-report.md):
* **Missing Values:** Handled missing `CustomerID` and product descriptions by isolating them where customer-level tracking was required.
* **Cancellations & Returns:** Investigated `InvoiceNo` entries starting with `'C'` (indicating cancellations). Separated them from positive sales to accurately evaluate gross vs. net sales impact.
* **Anomalies:** Checked for zero/negative prices and quantities to avoid mathematical distortions.

---

##  5. Project Structure & Repository Contents

retail-sales-analysis/
├── README.md                  # Project overview and documentation
├── docs/                      # Reports and documentation
│   ├── case-study-report.pdf  # Full 4-6 page business report
│   ├── executive-summary.pdf  # 1-page summary for stakeholders
│   └── data-quality-report.md # Data cleaning rules and assumptions
├── sql/                       # SQL queries and scripts
│   ├── 01_data_quality.sql    # Data quality & null checks
│   ├── 02_sales_analysis.sql  # Monthly and country-level sales aggregation
│   ├── 03_product_analysis.sql# Top products and performance queries
│   └── 04_customer_analysis.sql# Customer activity and concentration queries
├── power-bi/                  # Power BI report files and assets
│   ├── retail-sales-dashboard.pbix
│   └── screenshots/           # Dashboard visual exports
└── data/                      # Dataset info (Raw data not stored directly)
    └── README.md              # Instructions on how to download and set up the dataset
