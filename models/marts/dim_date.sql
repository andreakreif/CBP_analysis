WITH days AS (
    SELECT DATEADD(day, ROW_NUMBER() OVER (ORDER BY SEQ4()) - 1,
                   DATE '1900-01-01') AS d
    FROM TABLE(GENERATOR(ROWCOUNT => 60000))
)
SELECT
    TO_NUMBER(TO_CHAR(d, 'YYYYMMDD'))                       AS date_key,
    d                                                       AS full_date,
    YEAR(d)                                                 AS year_num,
    QUARTER(d)                                              AS quarter_num,
    YEAR(d) || '-Q' || QUARTER(d)                           AS quarter_label,
    MONTH(d)                                                AS month_num,
    TO_CHAR(d, 'MMMM')                                      AS month_name,
    TO_CHAR(d, 'YYYY-MM')                                   AS year_month,
    DAY(d)                                                  AS day_of_month,
    DAYOFYEAR(d)                                            AS day_of_year,
    DAYOFWEEKISO(d)                                         AS day_of_week_iso,
    DECODE(DAYOFWEEKISO(d), 1,'Monday', 2,'Tuesday', 3,'Wednesday',
           4,'Thursday', 5,'Friday', 6,'Saturday', 7,'Sunday') AS day_name,
    WEEKISO(d)                                              AS iso_week_num,
    YEAROFWEEKISO(d)                                        AS iso_year_num,
    DAYOFWEEKISO(d) IN (6, 7)                               AS is_weekend,
    DATE_TRUNC('month', d)                                  AS month_start_date,
    LAST_DAY(d, 'month')                                    AS month_end_date,
    DATE_TRUNC('year', d)                                   AS year_start_date,
    LAST_DAY(d, 'year')                                     AS year_end_date
FROM days
WHERE d <= DATE '2050-12-31'
UNION ALL
-- Sentinel rows
SELECT 99991231, DATE '9999-12-31', 9999, 4, '9999-Q4', 12, 'December', '9999-12',
  31, 365, 5, 'Friday', 52, 9999, FALSE,
  DATE '9999-12-01', DATE '9999-12-31', DATE '9999-01-01', DATE '9999-12-31'
UNION ALL
 SELECT-1, DATE '1899-12-31', NULL, NULL, 'Unknown', NULL, 'Unknown', 'Unknown',
  NULL, NULL, NULL, 'Unknown', NULL, NULL, NULL, NULL, NULL, NULL, NULL