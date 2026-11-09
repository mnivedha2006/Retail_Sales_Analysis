

# 1. Detailed Findings on Missing Customer IDs

## 1.1 Analysis & Inspection

During initial data inspection and column profiling through Excel data filtering and exploratory queries, a significant data-quality issue was identified in the `CustomerID` column.

- **Total Transactions Audited:** 541,909 records in the UCI Online Retail dataset.
- **Missing Customer Identifiers:** Exactly 135,080 records, representing approximately 24.9% of the entire dataset, do not contain a valid `CustomerID`.
- **Nature of Missing Data:** These rows still contain valid transaction identifiers (`InvoiceNo`), product codes (`StockCode`), descriptions, quantities, invoice timestamps, and unit prices. However, the buyer's unique customer identifier is absent.

## 1.2 Business Impact & Handling Strategy

The missing CustomerID records require different treatment depending on the type of business analysis being performed.

### 1. Retention for Macro-Level Analysis

Since the transaction amounts, quantities, and pricing information are available, these records will not be deleted.

They will be retained when calculating macro-level performance metrics such as:

- Total Gross Revenue.
- Monthly Sales Trends.
- Country-wise Sales Distribution.
- Product-level Revenue Contribution.
- Overall Transaction Performance.

Excluding these records would potentially underestimate the overall retail performance represented by the dataset.

### 2. Exclusion for Customer-Level Analytics

For customer-centric analytical activities, records without valid CustomerID values will be excluded.

This applies to:

- Customer Segmentation.
- Repeat Purchase Behaviour.
- Individual Customer Lifetime Value (LTV).
- Customer Purchase Frequency.
- Customer Retention Analysis.

Including unidentified records in these calculations would combine unrelated transactions into a single anonymous customer group and distort behavioural insights.

## 1.3 Final Handling Decision

The 135,080 records with missing CustomerID values will therefore be retained for transaction-level and macro-level financial analysis while being excluded from customer-specific behavioural calculations.

This dual-layer approach preserves available transaction information without compromising customer-level analytical accuracy.

---

# 2. Calculated Fields & Transaction-Level Revenue Derivation

To enable consistent financial analysis across Excel, SQL, and Power BI, a standardized transaction-level monetary calculation was established.

## 2.1 Line-Level Revenue Calculation

A calculated field named `LineValue` was defined using the following formula:

**LineValue = Quantity × UnitPrice**

This calculation represents the monetary value of an individual transaction line before considering cancellations and returns.

- **Positive LineValue:** Represents a positive-value transaction line.
- **Negative LineValue:** Represents a transaction line involving a negative quantity or negative unit price.
- **Zero LineValue:** Represents a transaction with no monetary value.

The calculated field provides a consistent foundation for product-level revenue analysis, monthly sales aggregation, country-wise performance evaluation, and return-value calculations.

## 2.2 Separation of Sales and Return Values

To prevent cancellation transactions from distorting commercial performance indicators, transaction records were classified into separate analytical categories.

| Transaction Category | Identification Rule | Analytical Treatment |
|---|---|---|
| Regular Sales | Invoice number does not begin with 'C', Quantity > 0, UnitPrice > 0 | Included in gross sales |
| Cancelled / Returned Transactions | Invoice number begins with 'C' or Quantity < 0 | Evaluated separately |
| Zero-Value Transactions | UnitPrice = 0 or calculated LineValue = 0 | Excluded from monetary revenue calculations |
| Invalid Price Transactions | UnitPrice < 0 | Flagged for separate investigation |

This classification enables sales performance and return activity to be evaluated independently.

## 2.3 Financial Metrics Definition

The following financial measures were established for the analytical process:

- **Gross Revenue:** Sum of eligible positive commercial transaction values before returns.
- **Return Value:** Absolute monetary value of identified return and cancellation transactions.
- **Net Revenue:** Gross Revenue minus Return Value.

These definitions provide a consistent financial calculation framework across Excel, SQL, and Power BI.

---

# 3. Duplicate Transaction Inspection

Duplicate records were considered as part of the data-quality assessment because repeated transaction entries can potentially inflate revenue, quantity, and order-level calculations.

## 3.1 Duplicate Identification

The following fields were considered during duplicate inspection:

- InvoiceNo
- StockCode
- Description
- Quantity
- InvoiceDate
- UnitPrice
- CustomerID

Records containing identical values across these fields were treated as potential exact duplicates requiring investigation.

## 3.2 Duplicate Handling Strategy

A blanket deletion approach was avoided.

The presence of multiple records containing the same invoice number and product code does not automatically indicate an error. Retail transactions may legitimately contain repeated product lines or multiple purchases.

Therefore:

1. Exact duplicate records were identified separately for inspection.
2. Potential duplicates were examined against their invoice and transaction details.
3. Legitimate repeated purchases were preserved.
4. Only confirmed erroneous duplicate records were considered for removal.

This approach protects the original transaction information while reducing the possibility of artificially inflated sales figures.

---

# 4. Data Standardization & Structural Consistency

Data standardization was considered essential to ensure that the dataset could be integrated reliably into the Excel, SQL, and Power BI analytical environments.

## 4.1 Column Data Types

The following data-type conventions were established:

| Column | Expected Data Type |
|---|---|
| InvoiceNo | Text |
| StockCode | Text |
| Description | Text |
| Quantity | Whole Number |
| InvoiceDate | Date/Time |
| UnitPrice | Decimal Number |
| CustomerID | Nullable Whole Number |
| Country | Text |
| LineValue | Decimal Number |

Invoice numbers and stock codes were maintained as text identifiers rather than numerical measures.

## 4.2 Date Standardization

The `InvoiceDate` column was standardized into a consistent date/time format.

Additional date attributes were defined for analytical reporting:

- Year
- Month
- Month Number
- Quarter
- Year-Month

These attributes support chronological sales analysis, monthly performance comparisons, quarterly reporting, and time-based visualizations.

## 4.3 Country Standardization

The Country column was reviewed to maintain consistent geographical categorization.

Country names were retained as descriptive text values, with unnecessary whitespace and formatting inconsistencies identified for correction.

This standardization supports reliable country-level grouping and geographical sales comparisons.

---

# 5. Data Quality Validation & Verification

Following the inspection and cleaning procedures, a validation framework was established to evaluate the consistency and reliability of the analytical dataset.

The validation process focused on the following dimensions:

| Data Quality Dimension | Validation Objective |
|---|---|
| Completeness | Identify missing CustomerID and other incomplete fields |
| Accuracy | Inspect invalid prices and unusual quantity values |
| Consistency | Maintain standardized data types and formats |
| Uniqueness | Investigate potential duplicate transaction records |
| Validity | Verify invoice, quantity, date, and monetary calculation rules |
| Integrity | Ensure calculated transaction values remain mathematically consistent |

## 5.1 Transaction-Level Validation

The calculated `LineValue` was checked against the underlying Quantity and UnitPrice fields.

The calculation was expected to satisfy:

`LineValue = Quantity × UnitPrice`

Any discrepancies arising from incorrect data types, missing values, or invalid monetary inputs were identified for investigation.

## 5.2 Revenue Reconciliation

Revenue reconciliation was established to ensure consistency between transaction-level calculations and aggregated financial metrics.

The following relationship was defined:

`Net Revenue = Gross Revenue - Return Value`

Aggregated results from Excel and SQL were compared using consistent transaction filters and calculation definitions.

This validation is particularly important because differences in cancellation handling, missing identifiers, and invalid monetary records can lead to inconsistent reporting results.

---

# 6. Final Data Handling Framework

Based on the data-quality assessment, a structured transaction-handling framework was established for downstream analysis.

| Data Condition | Final Analytical Decision |
|---|---|
| Missing CustomerID | Retain for overall sales analysis; exclude from customer-level behavioural analysis |
| Cancelled invoices | Separate from regular commercial sales |
| Negative quantities | Investigate and classify as return-related transactions |
| Zero UnitPrice | Exclude from monetary revenue calculations and flag |
| Negative UnitPrice | Flag for investigation |
| Potential duplicate records | Validate before removal |
| Missing product descriptions | Retain transaction identifiers and investigate descriptive completeness |
| Valid positive transactions | Include in gross sales calculations |

The framework ensures that records are handled according to their business meaning rather than applying identical cleaning rules to every transaction.

---

# 7. Analytical Limitations & Business Considerations

Although the dataset provides a substantial volume of retail transaction information, certain limitations must be considered when interpreting analytical results.

## 7.1 Missing Customer Identifiers

Approximately 24.9% of the original records lack CustomerID values.

Consequently, customer-level behavioural analysis cannot represent all recorded transactions.

Customer segmentation and repeat-purchase analysis will therefore be restricted to identifiable customers.

## 7.2 Absence of Product Cost Information

The dataset contains transaction quantities and unit selling prices but does not provide corresponding product acquisition costs or operating expenses.

Therefore:

- Actual gross profit cannot be calculated.
- Net profit cannot be established.
- Profit margins cannot be reliably determined.
- High-revenue products must not automatically be classified as high-profit products.

The project therefore focuses on revenue performance, sales volume, customer behaviour, product contribution, and return activity rather than claiming unsupported profitability results.

## 7.3 Return and Cancellation Interpretation

The dataset contains cancellation-related records and negative quantities.

These transactions are useful for evaluating return activity and revenue adjustments. However, their presence does not independently establish the exact financial settlement or refund status of every transaction.

Accordingly, return-related monetary values will be reported as transaction-based estimates rather than verified cash refunds.

## 7.4 Dataset Time Coverage

The dataset covers transactions from 1 December 2010 to 9 December 2011.

This relatively short observation period limits long-term seasonal analysis and year-over-year comparisons.

Business recommendations must therefore consider the available observation period.

---

# 8. Final Conclusion

The UCI Online Retail dataset provides a substantial foundation for conducting structured retail sales analysis, with 541,909 original transaction records covering approximately one year of retail activity.

The data-quality assessment identified important analytical considerations, particularly missing customer identifiers, cancellation transactions, return-related quantities, potential duplicates, and monetary anomalies.

A structured handling framework was established to preserve valid transaction information while maintaining analytical consistency across different reporting requirements.

The completed data preparation methodology supports the different analytical stages of the Retail Sales Analysis case study:

1. **Excel Analysis:** Exploratory data analysis, KPI calculations, pivot tables, and initial business insights.
2. **SQL Analysis:** Structured querying, aggregations, customer analysis, product analysis, and revenue calculations.
3. **Power BI Dashboard Development:** Interactive visualizations, sales performance indicators, monthly trends, and geographical analysis.
4. **Business Recommendations:** Evidence-based recommendations derived from the completed analytical findings.

The overall objective is to transform raw retail transaction records into meaningful business intelligence that supports informed commercial decision-making.

**End of Data Quality & Comprehensive Cleaning Report.**
