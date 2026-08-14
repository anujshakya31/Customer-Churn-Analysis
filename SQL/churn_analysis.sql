-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

CREATE DATABASE IF NOT EXISTS telco_churn;

USE telco_churn;


-- ============================================================
-- 2. CREATE CUSTOMERS TABLE
-- ============================================================

CREATE TABLE IF NOT EXISTS customers (
    CustomerID VARCHAR(20),
    City VARCHAR(100),
    Gender VARCHAR(20),
    `Senior Citizen` VARCHAR(10),
    Partner VARCHAR(10),
    Dependents VARCHAR(10),
    `Tenure Months` INT,
    `Phone Service` VARCHAR(10),
    `Multiple Lines` VARCHAR(50),
    `Internet Service` VARCHAR(50),
    `Online Security` VARCHAR(50),
    `Online Backup` VARCHAR(50),
    `Device Protection` VARCHAR(50),
    `Tech Support` VARCHAR(50),
    `Streaming TV` VARCHAR(50),
    `Streaming Movies` VARCHAR(50),
    Contract VARCHAR(50),
    `Paperless Billing` VARCHAR(10),
    `Payment Method` VARCHAR(50),
    `Monthly Charges` DECIMAL(10,2),
    `Total Charges` DECIMAL(10,2),
    `Churn Label` VARCHAR(10),
    `Churn Score` INT,
    CLTV INT,
    `Churn Reason` VARCHAR(255)
);


-- ============================================================
-- 3. VERIFY DATABASE AND TABLE
-- ============================================================

SHOW TABLES;

DESCRIBE customers;


-- ============================================================
-- 4. ENABLE LOCAL INFILE
-- ============================================================

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

SHOW VARIABLES LIKE 'local_infile';


-- ============================================================
-- 5. IMPORT CLEANED CSV DATA
-- ============================================================

LOAD DATA LOCAL INFILE
'C:/Users/Anuj Kumar/OneDrive/Desktop/Customer-Churn-Analysis/Cleaned_Dataset/Telco_Customer_Churn_Cleaned.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- ============================================================
-- 6. DATA VALIDATION
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM customers;


-- Display first 5 records to verify imported data

SELECT *
FROM customers
LIMIT 5;


-- ============================================================
-- 7. TOTAL CUSTOMERS
-- ============================================================

SELECT COUNT(*) AS total_customers
FROM customers;


-- ============================================================
-- 8. CHURNED CUSTOMERS
-- ============================================================

SELECT COUNT(*) AS churned_customers
FROM customers
WHERE `Churn Label` = 'Yes';


-- ============================================================
-- 9. RETAINED CUSTOMERS
-- ============================================================

SELECT COUNT(*) AS retained_customers
FROM customers
WHERE `Churn Label` = 'No';


-- ============================================================
-- 10. CHURN RATE
-- ============================================================

SELECT
    ROUND(
        SUM(
            CASE
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate
FROM customers;


-- ============================================================
-- 11. AVERAGE MONTHLY CHARGES & TENURE
-- ============================================================

SELECT
    ROUND(AVG(`Monthly Charges`), 2) AS avg_monthly_charges,
    ROUND(AVG(`Tenure Months`), 2) AS avg_tenure
FROM customers;


-- ============================================================
-- 12. CHURNED CUSTOMERS BY CONTRACT
-- ============================================================

SELECT
    Contract,
    COUNT(*) AS churned_customers
FROM customers
WHERE `Churn Label` = 'Yes'
GROUP BY Contract
ORDER BY churned_customers DESC;


-- ============================================================
-- 13. CHURN RATE BY CONTRACT
-- ============================================================

SELECT
    Contract,
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customers

GROUP BY Contract

ORDER BY churn_rate DESC;


-- ============================================================
-- 14. CHURN RATE BY PAYMENT METHOD
-- ============================================================

SELECT
    `Payment Method`,
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customers

GROUP BY `Payment Method`

ORDER BY churn_rate DESC;


-- ============================================================
-- 15. CHURN RATE BY INTERNET SERVICE
-- ============================================================

SELECT
    `Internet Service`,
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customers

GROUP BY `Internet Service`

ORDER BY churn_rate DESC;


-- ============================================================
-- 16. CHURN RATE BY GENDER
-- ============================================================

SELECT
    Gender,
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customers

GROUP BY Gender

ORDER BY churn_rate DESC;


-- ============================================================
-- 17. CHURN RATE BY SENIOR CITIZEN
-- ============================================================

SELECT
    `Senior Citizen`,
    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customers

GROUP BY `Senior Citizen`

ORDER BY churn_rate DESC;


-- ============================================================
-- 18. CHURN RATE BY TENURE GROUP
-- ============================================================

SELECT
    CASE
        WHEN `Tenure Months` BETWEEN 0 AND 12
            THEN '0-12 Months'

        WHEN `Tenure Months` BETWEEN 13 AND 24
            THEN '13-24 Months'

        WHEN `Tenure Months` BETWEEN 25 AND 48
            THEN '25-48 Months'

        WHEN `Tenure Months` BETWEEN 49 AND 72
            THEN '49-72 Months'
    END AS tenure_group,

    COUNT(*) AS total_customers,

    SUM(
        CASE
            WHEN `Churn Label` = 'Yes' THEN 1
            ELSE 0
        END
    ) AS churned_customers,

    ROUND(
        SUM(
            CASE
                WHEN `Churn Label` = 'Yes' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS churn_rate

FROM customers

GROUP BY tenure_group

ORDER BY churn_rate DESC;


-- ============================================================
-- 19. CHURN REASONS
-- ============================================================

SELECT
    `Churn Reason`,
    COUNT(*) AS churned_customers
FROM customers
WHERE `Churn Label` = 'Yes'
GROUP BY `Churn Reason`
ORDER BY churned_customers DESC;


-- ============================================================
-- 20. TOP 10 CHURN REASONS
-- ============================================================

SELECT
    `Churn Reason`,
    COUNT(*) AS churned_customers
FROM customers
WHERE `Churn Label` = 'Yes'
GROUP BY `Churn Reason`
ORDER BY churned_customers DESC
LIMIT 10;


-- ============================================================
-- END OF CUSTOMER CHURN ANALYSIS
-- ============================================================