-- Transform: stg_dates → dim_dates
-- Cast tipe data, tambah derived columns, deduplikasi

TRUNCATE TABLE dim_dates;

INSERT INTO dim_dates (
    date_id,
    full_date,
    year,
    quarter,
    month,
    month_name,
    week_of_year,
    day_of_month,
    day_of_week,
    day_name,
    is_weekend,
    is_holiday
)
SELECT DISTINCT ON (date_id)
    date_id,
    full_date,
    year,
    quarter,
    month,
    month_name,
    week_of_year,
    day_of_month,
    day_of_week,
    day_name,
    is_weekend,
    is_holiday
FROM stg_dates
WHERE date_id IS NOT NULL
ORDER BY date_id;
