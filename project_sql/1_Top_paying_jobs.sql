/* Top paying Business Analyst roles
- No nulls
- Including company Name
- Top Salary
- Available in Canada including remote
*/

SELECT 
    job_id,
    job_title,
    salary_year_avg,
    job_country,
    job_location,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title LIKE '%Business%Analyst%' AND
    job_location IN ('Canada', 'Anywhere') AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 20
