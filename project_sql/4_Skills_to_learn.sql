/* The most optimal skills to learn for a Business Analyst
- Focusing on skills
- Focusing on Salary
*/

WITH optimal_skills AS (
Select 
    skills_dim.skill_id,
    skills,
    count (skills_job_dim.job_id) AS skill_demand
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short LIKE 'Business Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY    
    skills,
    skills_dim.skill_id
), average_salary AS (
SELECT
   skills_dim.skill_id,
    skills,
    ROUND(AVG(salary_year_avg), 2) AS avg_salary
FROM    
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Business Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY    
    skills,
    skills_dim.skill_id

)

SELECT
    optimal_skills.skills,
    skill_demand,
    avg_salary
FROM
    optimal_skills
INNER JOIN
    average_salary ON optimal_skills.skill_id = average_salary.skill_id
ORDER BY
    skill_demand DESC