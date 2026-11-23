-- Project: Job Market Analysis
-- File: 03_Remaining_Analysis.sql
-- Purpose: Remaining analysis for education and employer insights
-- Safety: SELECT-only queries; original Market table is not modified.
-- Note: Job groups are approximated using company, title, location and salary estimate.

-- Q01: Job openings by education requirement
-- Degree values should be interpreted using the actual data dictionary.
SELECT
    Degree,
    COUNT(*) AS unique_job_groups,
    ROUND(AVG(Avg_SalaryK), 2) AS avg_salary_usd_k
FROM (
    SELECT
        company_txt, Job_Title, Job_Location, Salary_Estimate,
        MAX(Degree) AS Degree,
        AVG(CASE WHEN Avg_SalaryK >= 0 THEN Avg_SalaryK END) AS Avg_SalaryK
    FROM Market
    GROUP BY company_txt, Job_Title, Job_Location, Salary_Estimate
) AS jobs
GROUP BY Degree
ORDER BY unique_job_groups DESC;

-- Q02: Top hiring companies with average salary
SELECT
    company_txt AS company_name,
    COUNT(*) AS unique_job_groups,
    ROUND(AVG(Avg_SalaryK), 2) AS avg_salary_usd_k
FROM (
    SELECT
        company_txt, Job_Title, Job_Location, Salary_Estimate,
        AVG(CASE WHEN Avg_SalaryK >= 0 THEN Avg_SalaryK END) AS Avg_SalaryK
    FROM Market
    GROUP BY company_txt, Job_Title, Job_Location, Salary_Estimate
) AS jobs
WHERE company_txt IS NOT NULL AND TRIM(company_txt) NOT IN ('', '-1')
GROUP BY company_txt
ORDER BY unique_job_groups DESC, company_name
LIMIT 10;

-- Q03: Compare job title families (based on title text)
SELECT
    CASE
        WHEN Job_Title LIKE '%Data Analyst%' THEN 'Data Analyst'
        WHEN Job_Title LIKE '%Data Scientist%' THEN 'Data Scientist'
        WHEN Job_Title LIKE '%Data Engineer%' THEN 'Data Engineer'
        ELSE 'Other'
    END AS job_family,
    COUNT(*) AS unique_job_groups,
    ROUND(AVG(Avg_SalaryK), 2) AS avg_salary_usd_k
FROM (
    SELECT
        company_txt, Job_Title, Job_Location, Salary_Estimate,
        AVG(CASE WHEN Avg_SalaryK >= 0 THEN Avg_SalaryK END) AS Avg_SalaryK
    FROM Market
    GROUP BY company_txt, Job_Title, Job_Location, Salary_Estimate
) AS jobs
GROUP BY job_family
ORDER BY unique_job_groups DESC;
