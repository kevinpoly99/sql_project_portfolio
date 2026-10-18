/* Top skills in demand for Business Analyst
- Location is anywhere
- Titles under Business Analyst
- Top 10 In-Demand Skills
*/

Select 
    skills,
    job_title,
    count (skills_job_dim.job_id) AS skill_demand
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short LIKE 'Business Analyst'
GROUP BY    
    skills,
    job_title
ORDER BY
    skill_demand DESC
LIMIT 10