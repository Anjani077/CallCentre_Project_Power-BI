 Total Calls:
SELECT COUNT(call_id) AS total_calls
FROM call_data;

Answered Calls:
SELECT COUNT(call_id) AS answered_calls
FROM call_data
WHERE answered = 'Y';

Resolved Calls:
SELECT COUNT(call_id) AS resolved_calls
FROM call_data
WHERE resolved = 'Y';

Satisfied Calls:

(Assuming rating ≥ 4 = satisfied)

SELECT COUNT(call_id) AS satisfied_calls
FROM call_data
WHERE satisfaction_rating >= 4;

SINGLE FUNNEL QUERY :

SELECT
    COUNT(call_id) AS total_calls,
    SUM(CASE WHEN answered = 'Y' THEN 1 ELSE 0 END) AS answered_calls,
    SUM(CASE WHEN resolved = 'Y' THEN 1 ELSE 0 END) AS resolved_calls,
    SUM(CASE WHEN satisfaction_rating >= 4 THEN 1 ELSE 0 END) AS satisfied_calls
FROM call_data;




 Funnel Conversion Rates

SELECT
    COUNT(call_id) AS total_calls,
    SUM(CASE WHEN answered = 'Y' THEN 1 ELSE 0 END) * 100.0 / COUNT(call_id) AS answer_rate_pct,
    SUM(CASE WHEN resolved = 'Y' THEN 1 ELSE 0 END) * 100.0 / 
        SUM(CASE WHEN answered = 'Y' THEN 1 ELSE 0 END) AS resolution_rate_pct,
    SUM(CASE WHEN satisfaction_rating >= 4 THEN 1 ELSE 0 END) * 100.0 /
        SUM(CASE WHEN resolved = 'Y' THEN 1 ELSE 0 END) AS satisfaction_rate_pct
FROM call_data;

Funnel by Month :

SELECT
    DATE_FORMAT(call_date, '%Y-%m') AS month,
    COUNT(call_id) AS total_calls,
    SUM(CASE WHEN answered = 'Y' THEN 1 ELSE 0 END) AS answered_calls,
    SUM(CASE WHEN resolved = 'Y' THEN 1 ELSE 0 END) AS resolved_calls
FROM call_data
GROUP BY DATE_FORMAT(call_date, '%Y-%m')
ORDER BY month;