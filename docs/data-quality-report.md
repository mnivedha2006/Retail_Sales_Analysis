##  Detailed Findings on Missing Customer IDs

### Analysis & Inspection
* **Total Transactions Audited:** 541,909 records in the UCI Online Retail dataset.
* **Missing Customer Identifiers:** Through Excel data filtering and column inspection, we identified that **135,080 records** (approximately 24.9% of the total dataset) do not contain a valid `CustomerID`.
* **Nature of Missing Data:** These rows still contain valid transaction identifiers (`InvoiceNo`), product codes (`StockCode`), descriptions, quantities, invoice timestamps, and unit prices. However, the buyer's unique profile ID is absent.

### Business Impact & Handling Strategy
1. **Retention for Macro Analysis:** 
   * Since the transaction amounts, quantities, and pricing are intact, these records **will not be deleted** 
   * They will be fully included when calculating macro-level metrics such as **Total Gross Revenue, Monthly Sales Trends, and Country-wise Sales Distribution**. Excluding them would artificially deflate total retail performance.
2. **Exclusion for Customer-Level Analytics:**
   * For customer-centric tasks (such as Customer Segmentation, Repeat Purchase Behavior, and Individual Lifetime Value calculation), these 135,080 rows **must be excluded**. 
   * Attempting to include them in customer segmentation would create a single massive "Unknown/Anonymous" cluster, skewing the behavioral insights.

### Next Steps in Data Cleaning
* Document the handling rule clearly in the project repository.
* Proceed with creating calculated metrics (e.g., `LineValue = Quantity * UnitPrice`) for revenue and sales performance evaluation.
