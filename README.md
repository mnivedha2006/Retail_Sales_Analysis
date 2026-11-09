# Retail Sales & Profitability Analysis (2010–2011)

##  Executive Summary
An enterprise-grade, end-to-end retail analytics suite built using **Excel, SQL, and Power BI**, analyzing over **540,000+ transaction records** from the UCI Online Retail dataset (2010–2011). This project moves beyond basic reporting into advanced commercial and supply chain intelligence—tracking global revenue drivers, quantifying return/cancellation leakage, and optimizing inventory management through automated **ABC Product Segmentation (Pareto Principle)** and **VIP Customer Lifetime Value (LTV) tiering**.

---

##  Business Context & Research Questions
Operating as a Junior Business Analyst, this case study addresses key operational and strategic questions for executive stakeholders:
* **Revenue Drivers:** Which products and geographic markets contribute the highest net revenue concentrations?
* **Seasonality:** Which months display peak commercial performance versus seasonal troughs?
* **Customer Concentration:** How heavily are sales concentrated among top-tier VIP buyers versus standard traffic?
* **Return Leakage:** What is the precise financial impact of invoice cancellations (starting with 'C') on gross versus net sales figures?
* **Actionable Strategy:** What practical interventions should management implement to stabilize revenue and optimize inventory distribution?

---

##  Dataset & Scope
* **Source:** UCI Machine Learning Repository — Online Retail Dataset.
* **Scope:** 541,909 transaction records from a UK-based online retailer covering the period from `01/12/2010` to `09/12/2011`.
* **Key Attributes:** `InvoiceNo`, `StockCode`, `Description`, `Quantity`, `InvoiceDate`, `UnitPrice`, `CustomerID`, `Country`.
* **Analytical Limitation Note:** Due to the absence of direct Cost of Goods Sold (COGS) data in the raw schema, analysis focuses strictly on revenue performance, sales trends, volume movement, and return leakage rather than net margins.

---

##  Data Cleaning & Methodology
Data quality issues were systematically audited and mitigated before modeling:
1. **Missing Identifiers:** Handled missing `CustomerID` and product descriptions by isolating them from customer-level tracking queries to maintain analytical integrity.
2. **Cancellation & Return Tracking:** Identified invoice numbers starting with `'C'` as cancellations. Developed robust return-handling logic using `ABS()` transformations to isolate true net revenue from gross turnover.
3. **Anomaly Checks:** Filtered out erroneous zero or negative price/quantity distributions to prevent mathematical distortion in aggregation metrics.

---

##  Tech Stack & Architecture
* **Data Preparation & Validation:** Microsoft Excel (data typing, anomaly identification, and initial exploratory data analysis).
* **Data Warehousing & Querying:** SQL (`sql/` scripts covering data quality, monthly/country aggregations, top products, and customer concentration).
* **BI & Visual Modeling:** Power BI Desktop (`retail-sales-dashboard.pbix`) featuring calculated calendar tables, 1:to-Many star schema relationships, and advanced DAX measures.

---

##  Advanced DAX & Analytical Tooling
* **Return-Handling Measure:** Calculates true net revenue by accounting for absolute return values separately from gross sales figures.
* **ABC Product Class (Pareto 80/20 Principle):** Calculated column that automatically segments inventory performance based on cumulative revenue contribution:
  * **Class A (Top 80% Revenue):** High-priority stock requiring tight inventory control and zero stock-outs.
  * **Class B (Next 15% Revenue):** Steady secondary inventory items.
  * **Class C (Bottom 5% Revenue):** Long-tail or slow-moving products evaluated for rationalization.
* **VIP Customer Segmentation Proxy:** Categorizes buyers by lifetime net spend brackets (`> £5k` VIP Tier, `£1k–£5k` Mid-Tier, and `< £1k` Standard Tier) to guide commercial retention campaigns.

---

##  Dashboard Architecture (3-Page Suite)
* **Page 01 – Executive Overview:** High-level KPI cards (`Total Revenue`, `Net Revenue`, `Total Orders`, `Total Customers`), monthly revenue trend line charts, and geographic breakdown visuals.
* **Page 02 – Product Analysis:** Deep-dive into top-selling inventory items, return value tracking, and interactive ABC classification donut charts.
* **Page 03 – Customer & Geography:** Regional net revenue performance, Average Order Value (AOV) metrics, and VIP customer distribution columns.

---

##  Strategic Business Recommendations
1. **Geographic Diversification:** The United Kingdom and EIRE command the vast majority of volume and revenue concentration. Management should pilot localized retention campaigns and optimized shipping tiers in secondary European markets to diversify revenue streams.
2. **Supply Chain & Inventory Prioritization:** Class A products drive the bulk of cash flow. Warehouse operations must automate inventory replenishment thresholds for these specific items while minimizing holding costs for Class C tail items.
3. **Customer Loyalty Programs:** With an Average Order Value hovering around £471 across active accounts, introducing tailored bundled packages and tiered membership rewards will increase repeat purchase frequency among mid-tier buyers.

---

##  Project Structure
```text
retail-sales-analysis/
├── README.md                  # Comprehensive project documentation
├── docs/                      # Reports and documentation
│   ├── case-study-report.pdf  # Full business report
│   ├── executive-summary.pdf  # Stakeholder summary
│   └── data-quality-report.md # Data cleaning rules and assumptions
├── sql/                       # SQL queries and scripts
│   ├── 01_data_quality.sql    # Null and anomaly checks
│   ├── 02_sales_analysis.sql  # Monthly and country-level aggregations
│   ├── 03_product_analysis.sql# Top products and performance queries
│   └── 04_customer_analysis.sql# Customer activity and concentration queries
├── power-bi/                  # Power BI report assets
│   ├── retail-sales-dashboard.pbix
│   └── screenshots/           # Visual exports of Executive, Product, and Customer pages
└── data/                      # Dataset documentation and download instructions
