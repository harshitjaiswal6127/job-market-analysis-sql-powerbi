-- Project: Job Market Analysis
-- File: 01_Job_Market_EDA.sql
-- Purpose: Exploratory Data Analysis (EDA)
-- Database: project_job_market_analysis
-- Table: Market
-- Note: Read-only analysis using SELECT queries.

-- Q01: Check exact duplicate job records
-- Purpose: Identify possible duplicate postings before analysis.

SELECT COUNT(*) AS exact_duplicate_pairs FROM Market m1 JOIN Market m2 ON m1.ID < m2.ID AND m1.`Job_Title` <=> m2.`Job_Title` AND m1.`Salary_Estimate` <=> m2.`Salary_Estimate` AND m1.`FIELD4` <=> m2.`FIELD4` AND m1.`Rating` <=> m2.`Rating` AND m1.`Company_Name` <=> m2.`Company_Name` AND m1.`Location` <=> m2.`Location` AND m1.`Headquarters` <=> m2.`Headquarters` AND m1.`Size` <=> m2.`Size` AND m1.`Founded` <=> m2.`Founded` AND m1.`Type_of_ownership` <=> m2.`Type_of_ownership` AND m1.`Industry` <=> m2.`Industry` AND m1.`Sector` <=> m2.`Sector` AND m1.`Revenue` <=> m2.`Revenue` AND m1.`Competitors` <=> m2.`Competitors` AND m1.`Hourly` <=> m2.`Hourly` AND m1.`Employer_provided` <=> m2.`Employer_provided` AND m1.`Lower_Salary` <=> m2.`Lower_Salary` AND m1.`Upper_Salary` <=> m2.`Upper_Salary` AND m1.`Avg_SalaryK` <=> m2.`Avg_SalaryK` AND m1.`company_txt` <=> m2.`company_txt` AND m1.`Job_Location` <=> m2.`Job_Location` AND m1.`Age` <=> m2.`Age` AND m1.`Python` <=> m2.`Python` AND m1.`spark` <=> m2.`spark` AND m1.`aws` <=> m2.`aws` AND m1.`excel` <=> m2.`excel` AND m1.`sql_` <=> m2.`sql_` AND m1.`sas` <=> m2.`sas` AND m1.`keras` <=> m2.`keras` AND m1.`pytorch` <=> m2.`pytorch` AND m1.`scikit` <=> m2.`scikit` AND m1.`tensor` <=> m2.`tensor` AND m1.`hadoop` <=> m2.`hadoop` AND m1.`tableau` <=> m2.`tableau` AND m1.`bi` <=> m2.`bi` AND m1.`flink` <=> m2.`flink` AND m1.`mongo` <=> m2.`mongo` AND m1.`google_an` <=> m2.`google_an` AND m1.`job_title_sim` <=> m2.`job_title_sim` AND m1.`seniority_by_title` <=> m2.`seniority_by_title` AND m1.`Degree` <=> m2.`Degree`;

-- Q02: Check total records and unique IDs
-- Purpose: Verify dataset size and ID uniqueness.

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT ID) AS unique_ids
FROM Market;

-- Q03: Count distinct job combinations
-- Purpose: Estimate unique job groups using selected job attributes.

SELECT
    COUNT(*) AS total_records,
    COUNT(DISTINCT
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
    ) AS unique_job_groups
FROM Market;

-- Q04: Analyze repeated job combinations
-- Purpose: Count repeated groups and extra records based on selected job attributes.

SELECT
    COUNT(*) AS total_job_groups,
    SUM(CASE WHEN record_count > 1 THEN 1 ELSE 0 END)
        AS repeated_groups,
    SUM(record_count - 1) AS extra_records
FROM (
    SELECT
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate,
        COUNT(*) AS record_count
    FROM Market
    GROUP BY
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
) AS job_groups;

-- Q05: Check matching job record pairs
-- Purpose: Count pairs of records matching selected job attributes.

SELECT COUNT(*) AS exact_duplicate_pairs FROM Market m1 JOIN Market m2 ON m1.ID < m2.ID AND m1.`Job_Title` <=> m2.`Job_Title` AND m1.`Salary_Estimate` <=> m2.`Salary_Estimate` AND m1.`FIELD4` <=> m2.`FIELD4` AND m1.`Rating` <=> m2.`Rating` AND m1.`Company_Name` <=> m2.`Company_Name` AND m1.`Location` <=> m2.`Location` AND m1.`Headquarters` <=> m2.`Headquarters` AND m1.`Size` <=> m2.`Size` AND m1.`Founded` <=> m2.`Founded` AND m1.`Type_of_ownership` <=> m2.`Type_of_ownership` AND m1.`Industry` <=> m2.`Industry` AND m1.`Sector` <=> m2.`Sector` AND m1.`Revenue` <=> m2.`Revenue` AND m1.`Competitors` <=> m2.`Competitors` AND m1.`Hourly` <=> m2.`Hourly` AND m1.`Employer_provided` <=> m2.`Employer_provided` AND m1.`Lower_Salary` <=> m2.`Lower_Salary` AND m1.`Upper_Salary` <=> m2.`Upper_Salary` AND m1.`Avg_SalaryK` <=> m2.`Avg_SalaryK` AND m1.`company_txt` <=> m2.`company_txt` AND m1.`Job_Location` <=> m2.`Job_Location` AND m1.`Age` <=> m2.`Age` AND m1.`Python` <=> m2.`Python` AND m1.`spark` <=> m2.`spark` AND m1.`aws` <=> m2.`aws` AND m1.`excel` <=> m2.`excel` AND m1.`sql_` <=> m2.`sql_` AND m1.`sas` <=> m2.`sas` AND m1.`keras` <=> m2.`keras` AND m1.`pytorch` <=> m2.`pytorch` AND m1.`scikit` <=> m2.`scikit` AND m1.`tensor` <=> m2.`tensor` AND m1.`hadoop` <=> m2.`hadoop` AND m1.`tableau` <=> m2.`tableau` AND m1.`bi` <=> m2.`bi` AND m1.`flink` <=> m2.`flink` AND m1.`mongo` <=> m2.`mongo` AND m1.`google_an` <=> m2.`google_an` AND m1.`job_title_sim` <=> m2.`job_title_sim` AND m1.`seniority_by_title` <=> m2.`seniority_by_title` AND m1.`Degree` <=> m2.`Degree`;

-- Q06: Count extra records in repeated job groups
-- Purpose: Identify records that repeat the same company, job title, location and salary estimate.

SELECT
    COUNT(*) AS total_records,
    SUM(
        CASE
            WHEN EXISTS (
                SELECT 1
                FROM Market AS m2
                WHERE m2.ID < m1.ID
                  AND m2.company_txt <=> m1.company_txt
                  AND m2.Job_Title <=> m1.Job_Title
                  AND m2.Job_Location <=> m1.Job_Location
                  AND m2.Salary_Estimate <=> m1.Salary_Estimate
            )
            THEN 1
            ELSE 0
        END
    ) AS extra_records_4_columns
FROM Market AS m1;

-- Q07: Check unknown values (-1)
-- Purpose: Identify placeholder values in important columns.

SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN Age = -1 THEN 1 ELSE 0 END) AS unknown_age,
    SUM(CASE WHEN Rating = -1 THEN 1 ELSE 0 END) AS unknown_rating,
    SUM(CASE WHEN Size = '-1' THEN 1 ELSE 0 END) AS unknown_size,
    SUM(CASE WHEN Revenue = '-1' THEN 1 ELSE 0 END) AS unknown_revenue,
    SUM(CASE WHEN Industry = '-1' THEN 1 ELSE 0 END) AS unknown_industry
FROM Market;

-- Q08: Check NULL and blank values
-- Purpose: Identify missing data in important columns.

SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN Age IS NULL THEN 1 ELSE 0 END) AS null_age,
    SUM(CASE WHEN Rating IS NULL THEN 1 ELSE 0 END) AS null_rating,
    SUM(CASE WHEN Size IS NULL OR TRIM(Size) = '' THEN 1 ELSE 0 END) AS missing_size,
    SUM(CASE WHEN Revenue IS NULL OR TRIM(Revenue) = '' THEN 1 ELSE 0 END) AS missing_revenue,
    SUM(CASE WHEN Industry IS NULL OR TRIM(Industry) = '' THEN 1 ELSE 0 END) AS missing_industry
FROM Market;


SELECT
    COUNT(*) AS total_records,
    SUM(
        CASE
            WHEN Salary_Estimate IS NULL
              OR TRIM(Salary_Estimate) = ''
              OR TRIM(Salary_Estimate) = '-1'
            THEN 1 ELSE 0
        END
    ) AS missing_salary_estimate,
    SUM(
        CASE
            WHEN Avg_SalaryK IS NULL
              OR Avg_SalaryK < 0
            THEN 1 ELSE 0
        END
    ) AS invalid_avg_salary,
    MIN(Avg_SalaryK) AS min_avg_salary,
    MAX(Avg_SalaryK) AS max_avg_salary,
    ROUND(AVG(Avg_SalaryK), 2) AS overall_avg_salary
FROM Market;

SELECT
    CASE
        WHEN Avg_SalaryK < 50 THEN 'Below $50K'
        WHEN Avg_SalaryK < 100 THEN '$50K-$99K'
        WHEN Avg_SalaryK < 150 THEN '$100K-$149K'
        WHEN Avg_SalaryK < 200 THEN '$150K-$199K'
        ELSE '$200K and Above'
    END AS salary_range,
    COUNT(*) AS job_records
FROM Market
WHERE Avg_SalaryK IS NOT NULL
  AND Avg_SalaryK >= 0
GROUP BY
    CASE
        WHEN Avg_SalaryK < 50 THEN 'Below $50K'
        WHEN Avg_SalaryK < 100 THEN '$50K-$99K'
        WHEN Avg_SalaryK < 150 THEN '$100K-$149K'
        WHEN Avg_SalaryK < 200 THEN '$150K-$199K'
        ELSE '$200K and Above'
    END
ORDER BY MIN(Avg_SalaryK);

SELECT
    CASE
        WHEN Avg_SalaryK < 50 THEN 'Below $50K'
        WHEN Avg_SalaryK < 100 THEN '$50K-$99K'
        WHEN Avg_SalaryK < 150 THEN '$100K-$149K'
        WHEN Avg_SalaryK < 200 THEN '$150K-$199K'
        ELSE '$200K and Above'
    END AS salary_range,
    COUNT(*) AS unique_job_groups
FROM (
    SELECT
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate,
        AVG(Avg_SalaryK) AS Avg_SalaryK
    FROM Market
    GROUP BY
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
) AS jobs
GROUP BY salary_range
ORDER BY MIN(Avg_SalaryK);

SELECT
    Job_Title,
    COUNT(*) AS unique_job_groups
FROM (
    SELECT
        Job_Title,
        company_txt,
        Job_Location,
        Salary_Estimate
    FROM Market
    GROUP BY
        Job_Title,
        company_txt,
        Job_Location,
        Salary_Estimate
) AS unique_jobs
GROUP BY Job_Title
ORDER BY unique_job_groups DESC, Job_Title
LIMIT 10;

SELECT
    company_txt AS company_name,
    COUNT(*) AS unique_job_groups
FROM (
    SELECT
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
    FROM Market
    GROUP BY
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
) AS unique_jobs
GROUP BY company_txt
ORDER BY unique_job_groups DESC, company_name
LIMIT 10;

SELECT
    Job_Location,
    COUNT(*) AS total_records
FROM Market
GROUP BY Job_Location
ORDER BY total_records DESC
LIMIT 20;


SELECT
    Job_Location AS State,
    COUNT(*) AS unique_job_groups
FROM (
    SELECT DISTINCT
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
    FROM Market
) AS unique_jobs
GROUP BY Job_Location
ORDER BY unique_job_groups DESC, State
LIMIT 10;


SELECT
    Job_Location AS State,
    COUNT(*) AS unique_job_groups,
    ROUND(AVG(Avg_SalaryK), 2) AS avg_salary_usd_k,
    ROUND(MIN(Avg_SalaryK), 2) AS min_salary_usd_k,
    ROUND(MAX(Avg_SalaryK), 2) AS max_salary_usd_k
FROM (
    SELECT
        Job_Location,
        company_txt,
        Job_Title,
        Salary_Estimate,
        AVG(Avg_SalaryK) AS Avg_SalaryK
    FROM Market
    WHERE Avg_SalaryK IS NOT NULL
      AND Avg_SalaryK >= 0
    GROUP BY
        Job_Location,
        company_txt,
        Job_Title,
        Salary_Estimate
) AS unique_jobs
GROUP BY Job_Location
HAVING COUNT(*) >= 5
ORDER BY avg_salary_usd_k DESC, State
LIMIT 10;


SELECT
    Industry,
    COUNT(*) AS unique_job_groups
FROM (
    SELECT
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate,
        MAX(Industry) AS Industry
    FROM Market
    GROUP BY
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
) AS unique_jobs
WHERE Industry IS NOT NULL
  AND TRIM(Industry) NOT IN ('', '-1')
GROUP BY Industry
ORDER BY unique_job_groups DESC, Industry
LIMIT 10;


SELECT
    Industry,
    COUNT(*) AS unique_job_groups,
    ROUND(AVG(Avg_SalaryK), 2) AS avg_salary_usd_k,
    ROUND(MIN(Avg_SalaryK), 2) AS min_salary_usd_k,
    ROUND(MAX(Avg_SalaryK), 2) AS max_salary_usd_k
FROM (
    SELECT
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate,
        MAX(Industry) AS Industry,
        AVG(Avg_SalaryK) AS Avg_SalaryK
    FROM Market
    GROUP BY
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
) AS unique_jobs
WHERE Industry IS NOT NULL
  AND TRIM(Industry) NOT IN ('', '-1')
  AND Avg_SalaryK >= 0
GROUP BY Industry
HAVING COUNT(*) >= 5
ORDER BY avg_salary_usd_k DESC, Industry
LIMIT 10;


SHOW COLUMNS FROM Market;


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = DATABASE()
  AND TABLE_NAME = 'Market'
  AND (
      LOWER(COLUMN_NAME) LIKE '%python%'
      OR LOWER(COLUMN_NAME) LIKE '%sql%'
      OR LOWER(COLUMN_NAME) LIKE '%excel%'
      OR LOWER(COLUMN_NAME) LIKE '%tableau%'
      OR LOWER(COLUMN_NAME) LIKE '%power%'
      OR LOWER(COLUMN_NAME) LIKE '%description%'
      OR LOWER(COLUMN_NAME) LIKE '%skill%'
  )
ORDER BY ORDINAL_POSITION;


SELECT
    Python,
    excel,
    sql_,
    tableau,
    COUNT(*) AS total_records
FROM Market
GROUP BY
    Python,
    excel,
    sql_,
    tableau
ORDER BY total_records DESC;


WITH unique_jobs AS (
    SELECT
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate,
        MAX(CASE WHEN Python = 1 THEN 1 ELSE 0 END) AS Python,
        MAX(CASE WHEN sql_ = 1 THEN 1 ELSE 0 END) AS sql_,
        MAX(CASE WHEN excel = 1 THEN 1 ELSE 0 END) AS excel,
        MAX(CASE WHEN tableau = 1 THEN 1 ELSE 0 END) AS tableau
    FROM Market
    GROUP BY
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
)
SELECT
    COUNT(*) AS total_unique_job_groups,
    SUM(Python) AS python_jobs,
    ROUND(100.0 * AVG(Python), 2) AS python_pct,
    SUM(sql_) AS sql_jobs,
    ROUND(100.0 * AVG(sql_), 2) AS sql_pct,
    SUM(excel) AS excel_jobs,
    ROUND(100.0 * AVG(excel), 2) AS excel_pct,
    SUM(tableau) AS tableau_jobs,
    ROUND(100.0 * AVG(tableau), 2) AS tableau_pct
FROM unique_jobs;










