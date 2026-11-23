
SELECT
    COUNT(*) AS total_unique_job_groups,
    SUM(Python) AS python_jobs,
    ROUND(AVG(Python) * 100, 2) AS python_pct,
    SUM(sql_) AS sql_jobs,
    ROUND(AVG(sql_) * 100, 2) AS sql_pct,
    SUM(excel) AS excel_jobs,
    ROUND(AVG(excel) * 100, 2) AS excel_pct,
    SUM(tableau) AS tableau_jobs,
    ROUND(AVG(tableau) * 100, 2) AS tableau_pct
FROM (
    SELECT
        MAX(Python) AS Python,
        MAX(sql_) AS sql_,
        MAX(excel) AS excel,
        MAX(tableau) AS tableau
    FROM Market
    GROUP BY
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
) AS unique_jobs;


SELECT
    COUNT(*) AS data_analyst_jobs,
    SUM(Python) AS python_jobs,
    SUM(sql_) AS sql_jobs,
    SUM(excel) AS excel_jobs,
    SUM(tableau) AS tableau_jobs
FROM (
    SELECT
        MAX(Python) AS Python,
        MAX(sql_) AS sql_,
        MAX(excel) AS excel,
        MAX(tableau) AS tableau
    FROM Market
    WHERE Job_Title LIKE '%Data Analyst%'
    GROUP BY
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
) AS analyst_jobs;


SELECT
    Job_Title,
    COUNT(*) AS job_records,
    ROUND(AVG(Avg_SalaryK), 2) AS avg_salary_usd_k,
    ROUND(MIN(Avg_SalaryK), 2) AS min_salary_usd_k,
    ROUND(MAX(Avg_SalaryK), 2) AS max_salary_usd_k
FROM Market
WHERE Job_Title LIKE '%Data Analyst%'
  AND Avg_SalaryK IS NOT NULL
  AND Avg_SalaryK >= 0
GROUP BY Job_Title
ORDER BY avg_salary_usd_k DESC;


SELECT
    seniority,
    COUNT(*) AS unique_job_groups,
    ROUND(AVG(Avg_SalaryK), 2) AS avg_salary_usd_k,
    ROUND(MIN(Avg_SalaryK), 2) AS min_salary_usd_k,
    ROUND(MAX(Avg_SalaryK), 2) AS max_salary_usd_k
FROM (
    SELECT
        CASE
            WHEN Job_Title LIKE '%Senior%'
              OR Job_Title LIKE '%Sr.%'
              OR Job_Title LIKE '%Lead%'
            THEN 'Senior / Lead'
            WHEN Job_Title LIKE '%Junior%'
              OR Job_Title LIKE '%Entry%'
              OR Job_Title LIKE '%Jr.%'
            THEN 'Junior / Entry'
            ELSE 'Other Data Analyst'
        END AS seniority,
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate,
        AVG(Avg_SalaryK) AS Avg_SalaryK
    FROM Market
    WHERE Job_Title LIKE '%Data Analyst%'
      AND Avg_SalaryK IS NOT NULL
      AND Avg_SalaryK >= 0
    GROUP BY
        company_txt,
        Job_Title,
        Job_Location,
        Salary_Estimate
) AS unique_jobs
GROUP BY seniority
ORDER BY avg_salary_usd_k DESC;


SELECT *
FROM Market;



