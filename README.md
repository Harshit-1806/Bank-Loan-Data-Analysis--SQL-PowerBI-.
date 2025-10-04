
# 📈 Bank Loan Analysis: Credit Risk and Portfolio Performance Dashboard

## 🌟 Executive Summary

This is an end-to-end Data Analysis project focused on transforming raw bank loan application data into **actionable business intelligence**. The primary goal is to provide bank stakeholders with a dynamic dashboard to monitor **portfolio health**, manage **credit risk**, and track key **financial KPIs** using timely Month-to-Date (MTD) comparisons.

## 🛠️ Technology Stack

| Component | Tool Used | Purpose |
| :--- | :--- | :--- |
| **Data Processing/ETL** | **MS SQL Server** | Data cleaning, transformation, and pre-calculation of all key metrics and segmented data. |
| **Business Intelligence** | **Power BI** | Data modeling, implementing **DAX Time Intelligence**, and creating a user-friendly, interactive reporting solution. |
| **Source Data** | `financial_loan.csv` | Raw transactional data for loan applications. |

## 📊 Key Performance Indicators (KPIs)

The analysis revolves around five core KPIs, calculated both overall and with **Time Intelligence** metrics (MTD and Prior Month-to-Date, PMTD), to allow for direct performance comparisons.

  * **Total Loan Applications:** Volume of new loan requests.
  * **Total Funded Amount:** Total capital disbursed by the bank.
  * **Total Amount Received:** Total repayments collected from borrowers.
  * **Average Interest Rate:** Key metric for profitability and pricing strategy.
  * **Average Debt-to-Income (DTI) Ratio:** Critical indicator of borrower financial health and risk.

## 🔬 Risk Analysis & Loan Status Classification

A core component of this project is the classification and tracking of loan quality:

| Classification | Loan Statuses Included | Key Metrics Calculated |
| :--- | :--- | :--- |
| **✅ Good Loan** | `Fully Paid`, `Current` | Total Applications, Funded Amount, Received Amount, and Percentage of Total Applications. |
| **❌ Bad Loan** | `Charged Off`, `Default` | Total Applications, Funded Amount, Received Amount, and Percentage of Total Applications (Default Rate). |

## 💻 SQL Server: Technical Execution

The SQL layer was critical for data preparation and offloading complex calculations from Power BI, ensuring reporting performance. Key SQL deliverables included:

1.  **KPI Pre-Calculation:** Optimized `SUM()`, `COUNT()`, and `AVG()` queries were used to calculate all overall and time-based metrics (MTD/PMTD) efficiently.
2.  **Segmented Reporting:** Data was grouped using `GROUP BY` to generate datasets for detailed breakdowns by:
      * **Loan Status** (Comprehensive Grid View)
      * **Issue Month** (For trend analysis)
      * **Address State** (Geographical activity)
      * **Loan Term, Purpose, Employment Length,** and **Home Ownership** (Borrower profiling).

### SQL Code Example (Good Loan Percentage):

```sql
SELECT 
    (COUNT(CASE WHEN loan_status IN ('Fully Paid', 'Current') THEN id END) * 100.0) / 
    COUNT(id) AS Good_Loan_Percentage
FROM 
    bank_loan_data;
```

## 📈 Power BI: Visualization & Reporting

The analysis is presented across three interconnected dashboards, moving from a high-level summary to detailed drill-down views:

1.  **Summary Dashboard:** Presents all core KPIs with MTD/PMTD change percentages for quick operational assessment.
2.  **Loan Status Dashboard (Risk):** Visualizes the financial impact of **Good Loans** versus **Bad Loans**, providing immediate visibility into credit risk exposure.
3.  **Details Dashboard:** Allows analysts to deep dive into loan distribution and performance across all key dimensions (State, Purpose, Term, Grade, etc.).

## 🔑 Key Analytical Insights

The dashboard enables business users to answer critical questions such as:

  * **Geographical Risk:** Which states have the highest volume of funded loans but also the highest **Bad Loan Percentage**?
  * **Product Performance:** How does the average interest rate and total funded amount compare between **36-month** and **60-month** loan terms?
  * **Borrower Profile:** What is the average DTI for borrowers whose loan purpose is **'Debt Consolidation'** vs. **'Car'**?
