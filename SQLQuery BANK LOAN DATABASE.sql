SELECT DB_NAME();  -- DATABASE NAME 
SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

-- --------------------------------------------------------------------------------

-- 1(a) Total Loan Applications

-- Meaning: The total number of loan applications received.
-- What to track:Overall Total Applications → all-time total

SELECT COUNT(id) AS TOTAL_LOAN_APPLICATION FROM bank_loan_data ; 


-- 1(b). Month-to-Date (MTD) Applications 

-- How many applications came from
-- the start of the current month up to today

SELECT COUNT(id) as TOTAL_APPLICATION FROM bank_loan_data WHERE
MONTH(issue_date) = 12 ; 


-- 1(c). Month-over-Month (MoM) Change 
-- compare the number of applications this month vs last month 
-- (percentage increase/decrease).

SELECT COUNT(id) as TOTAL_APPLICATION FROM bank_loan_data WHERE 
MONTH(issue_date) = 11 and YEAR(issue_date) = 2021 ; 

-- --------------------------------------------------------------------------------

-- 2. Total Funded Amount

-- Meaning: The total amount of money the bank has given out as loans.
-- What to track:

-- 2(a). Overall Funded Amount 
SELECT SUM(loan_amount) as TOTAL_FUNDED_AMOUNT FROM bank_loan_data ; 

-- 2(b). MTD Funded Amount → loan disbursed in the current month up to today

SELECT SUM(loan_amount) as MTD_FUNDED_AMOUNT FROM bank_loan_data 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 ; 

-- 2(c). MoM Change → compare funded amount with the previous month.

SELECT SUM(loan_amount) as PMTD_FUNDED_AMOUNT FROM bank_loan_data 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 ; 

-- --------------------------------------------------------------------------------

-- 3. Total Amount Received
-- Meaning: The total repayment received from borrowers.
-- What to track:

-- 3(a). Overall Amount Received 

SELECT SUM(total_payment) as TOTAL_PAYMENT_RECEIVED FROM bank_loan_data ; 

-- 3(b). MTD Amount Received → repayments in the current month

SELECT SUM(total_payment) as MTD_PAYMENT_RECEIVED FROM bank_loan_data 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 ; 
 
-- 3(c). MoM Change → compare repayments with the previous month.

SELECT SUM(total_payment) as PMTD_PAYMENT_RECEIVED FROM bank_loan_data 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 ; 

-- --------------------------------------------------------------------------------

SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

-- 4. Average Interest Rate
-- Meaning: The average interest rate applied across all loans.
-- What to track:

-- 4(a). Overall Average Interest Rate
SELECT ROUND(AVG(int_rate),4)*100  as AVG_INTEREST_RATE FROM bank_loan_data ; 

-- 4(b). MTD Average Interest Rate

SELECT ROUND(AVG(int_rate),4)*100  as MTD_AVG_INTEREST_RATE FROM bank_loan_data
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 ; 

-- 4(c). MoM Change → how interest rates are changing from month to month.

SELECT ROUND(AVG(int_rate),4)*100  as PMTD_AVG_INTEREST_RATE FROM bank_loan_data
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 ; 

-- --------------------------------------------------------------------------------

SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

-- 5. Average Debt-to-Income Ratio (DTI)
-- Meaning: Average ratio of borrowers’ monthly debt to their monthly income.
-- What to track:

-- 5(a). Overall Average DTI

SELECT ROUND(AVG(dti),4)*100 as Debt_to_Income_Ratio FROM bank_loan_data ; 

-- 5(b). MTD Average DTI

SELECT ROUND(AVG(dti),4)*100 as MTD_Debt_to_Income_Ratio FROM bank_loan_data 
WHERE MONTH(issue_date) = 12 AND YEAR(issue_date) = 2021 ; 

-- 5(c). MoM Change in DTI

SELECT ROUND(AVG(dti),4)*100 as PMTD_Debt_to_Income_Ratio FROM bank_loan_data 
WHERE MONTH(issue_date) = 11 AND YEAR(issue_date) = 2021 ; 

-- This shows the financial health of borrowers and helps assess risk.


-- --------------------------------------------------------------------------------


-- 6. ✅ Good Loan

SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

-- A loan is classified as a Good Loan if its status is either 
-- “Fully Paid” or “Current”.

-- The following KPIs need to be calculated:

-- 6(a). Good Loan Application Percentage → Percentage of total applications 
-- that are good loans.

select 
      COUNT(CASE 
           WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id 

      END ) *100 / 
      COUNT(id) AS Good_Loan_Percentage from bank_loan_data ; 

-- 6(b). Good Loan Applications → Total count of applications with a
-- good loan status.

SELECT COUNT(id) as Total_Good_loan_Status from bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- 6(c). Good Loan Funded Amount → Total funded amount disbursed for good loans.
SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

SELECT SUM(loan_amount) as Total_Good_Loan_Funded_Amount from bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- 6(d). Good Loan Total Received Amount → Total repayment amount received from
-- borrowers for good loans.

SELECT SUM(total_payment) as  Good_Loan_Total_Received_Amount from bank_loan_data 
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

-- --------------------------------------------------------------------------------

-- 7. ❌ Bad Loan

-- A loan is classified as a Bad Loan if its status is either “Charged Off” or “Default”.
-- The following KPIs need to be calculated:

-- 7(a). Bad Loan Application Percentage → Percentage of total applications that 
-- are bad loans.

SELECT 
      (COUNT(CASE 
           WHEN loan_status = 'Charged Off' THEN id 
      END ) * 100 / COUNT(id))  as Bad_LoanApplication_Percentage 
      from bank_loan_data ; 

-- 7(b). Bad Loan Applications → Total count of applications with a bad 
-- loan status.

SELECT COUNT(id) as Total_Bad_Loan_Applications from bank_loan_data
WHERE loan_status = 'Charged Off';  

-- 7(c). Bad Loan Funded Amount → Total funded amount disbursed for bad loans.

SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

SELECT SUM(loan_amount) as Bad_Loan_Funded_Amount  from bank_loan_data
WHERE loan_status = 'Charged Off'; 

-- 7(d). Bad Loan Total Received Amount → Total repayment amount received 
-- from borrowers for bad loans.


SELECT SUM(total_payment) as Total_Bad_Loan_Total_Received_Amount  from bank_loan_data
WHERE loan_status = 'Charged Off'; 

-- --------------------------------------------------------------------------------

-- 8. Loan Status Grid View
-- To gain a comprehensive overview of loan performance, a grid view 
-- report should be created, categorized by Loan Status.

-- The grid must display the following metrics for each loan status category:

--1. Total Loan Applications → Number of applications per loan status.
--2. Total Funded Amount → Sum of the total funded amount per loan status.
--3. Total Amount Received → Sum of the repayment amount received per loan status.
--4. Month-to-Date (MTD) Funded Amount → Funded amount disbursed in the current month per loan status.
--5. MTD Amount Received → Amount received from borrowers in the current month per loan status.
--6. Average Interest Rate → Average interest rate per loan status.
--7. Average Debt-to-Income Ratio (DTI) → Average DTI value per loan status.

SELECT loan_status ,  COUNT(id) as Total_loan_application,
SUM(loan_amount) as Total_funded_amount , 
SUM(total_payment) as Total_Received_amount , 
AVG(int_rate*100) as Avg_interest_rate , 
Avg(dti*100) as avg_debt_to_income_ratio 
from bank_loan_data 
group by loan_status  ; 

-- 4. Month-to-Date (MTD) Funded Amount → Funded amount disbursed in the
-- current month per loan status.
-- 5. MTD Amount Received → Amount received from borrowers in the current
-- month per loan status.

SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

SELECT loan_status , SUM(loan_amount) as MTD_Total_funded_amount,
SUM(total_payment) as MTD_Total_received_amount 
FROM bank_loan_data WHERE MONTH(issue_date) = 12 GROUP BY loan_status ; 

-- --------------------------------------------------------------------------------

--📌 Requirements for SQL Queries
--1️⃣ Monthly Trends by Issue Date (Line Chart)

--•	Purpose: Identify seasonality and long-term lending trends.

--•	Requirements:

--o	Group data by Month (Issue_Date)
--o	Calculate:
--	COUNT(id) → Total Loan Applications
--	SUM(funded_amount) → Total Funded Amount
--	SUM(amount_received) → Total Amount Received

SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

SELECT MONTH(issue_date) as Month_Number , 
DATENAME(MONTH , issue_date) as Month_Name , 
COUNT(id) as Total_Loan_Application , 
SUM(loan_amount) as Total_funded_Amount , 
SUM(total_payment) as Total_Received_Amount 
FROM bank_loan_data 
GROUP BY MONTH(issue_date) ,  
DATENAME(MONTH , issue_date) ORDER BY  MONTH(issue_date)  

-- --------------------------------------------------------------------------------
SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 
--2️⃣ Regional Analysis by State (Filled Map)

--•	Purpose: Compare lending activity across regions.

--•	Requirements:

--o	Group data by State
--o	Calculate the same 3 metrics (Applications, Funded Amount, Amount Received)

SELECT address_state , COUNT(id) AS Total_Loan_Application , 
SUM(loan_amount) as Total_funded_Amount , 
SUM(total_payment) as Total_Received_Amount 
FROM bank_loan_data 
GROUP BY address_state ;

-- --------------------------------------------------------------------------------

--3️⃣ Loan Term Analysis (Donut Chart)
SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

--•	Purpose: Show distribution of loans by term length.
--•	Requirements:

--o	Group data by Loan_Term
--o	Calculate: Applications, Funded Amount, Amount Received

SELECT term , COUNT(id) AS Total_Loan_Application , 
SUM(loan_amount) as Total_funded_Amount , 
SUM(total_payment) as Total_Received_Amount 
FROM bank_loan_data 
GROUP BY term
ORDER BY term ;

-- --------------------------------------------------------------------------------

--4️⃣ Employment Length Analysis (Bar Chart)

--•	Purpose: See how employment history impacts lending.
--•	Requirements:

SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

--o	Group data by Employment_Length
--o	Calculate: Applications, Funded Amount, Amount Received


SELECT emp_length , COUNT(id) AS Total_Loan_Application , 
SUM(loan_amount) as Total_funded_Amount , 
SUM(total_payment) as Total_Received_Amount 
FROM bank_loan_data 
GROUP BY emp_length
ORDER BY emp_length ;

-- --------------------------------------------------------------------------------


--5️⃣ Loan Purpose Breakdown (Bar Chart)

--•	Purpose: Show why borrowers take loans.
--•	Requirements:

SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

--o	Group data by Loan_Purpose
--o	Calculate: Applications, Funded Amount, Amount Received

SELECT purpose ,
COUNT(id) AS TOTAL_LOAN_APPLICATION , 
SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT , 
SUM(total_payment) AS TOTAL_RECEIVED_AMOUNT  
FROM bank_loan_data 
GROUP BY purpose ORDER BY COUNT(id) ; 

-- --------------------------------------------------------------------------------

--6️⃣ Home Ownership Analysis (Tree Map)

--•	Purpose: Show loan distribution by home ownership status.
--•	Requirements:

SELECT * FROM BANK_LOAN_DATA ; -- TAKING ALL THE ROWS FROM THE TABLE 

--o	Group data by Home_Ownership
--o	Calculate: Applications, Funded Amount, Amount Received

SELECT home_ownership , COUNT(id) AS TOTAL_LOAN_APPLICATION , 
SUM(loan_amount) AS TOTAL_FUNDED_AMOUNT , 
SUM(total_payment) AS TOTAL_RECEIVED_AMOUNT 
FROM bank_loan_data 
GROUP BY home_ownership
ORDER BY home_ownership ; 

-- --------------------------------------------------------------------------------
