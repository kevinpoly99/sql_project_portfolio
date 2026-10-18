/* Looking for skills attached to Business Analyst postions
- Location for Canada and Remote Anywhere
- Specific skills required demanded by companies
*/

WITH top_paying_jobs AS (
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
)

SELECT 
    top_paying_jobs.*,
    skills_dim.skills
FROM 
    top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY    
    salary_year_avg DESC