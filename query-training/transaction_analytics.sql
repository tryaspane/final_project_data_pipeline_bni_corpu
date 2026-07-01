-- Volume & Nilai Transaksi per Channel per Hari
SELECT
    d.full_date,
    c.channel_name,
    COUNT(t.transaction_id) AS volume_transaksi,
    SUM(t.amount) AS nilai_transaksi
FROM fact_transactions t
JOIN dim_channels c
    ON t.channel_id = c.channel_id
JOIN dim_dates d
    ON t.transaction_date = d.full_date
GROUP BY
    d.full_date,
    c.channel_name
ORDER BY
    d.full_date,
    c.channel_name;

-- Trend Volume Transaksi dan Nilai Transaksi antar Channel
SELECT
    d.year,
    d.month_name,
    c.channel_name,
    COUNT(*) AS volume_transaksi,
    SUM(t.amount) AS nilai_transaksi
FROM fact_transactions t
JOIN dim_channels c
    ON t.channel_id = c.channel_id
JOIN dim_dates d
    ON t.transaction_date = d.full_date
GROUP BY
    d.year,
    d.month,
    d.month_name,
    c.channel_name
ORDER BY
    d.year,
    d.month,
    nilai_transaksi DESC;

-- Volume & Nilai Transaksi per Channel per Tahun
    SELECT
    d.year,
    c.channel_name,
    COUNT(*) AS volume_transaksi,
    SUM(t.amount) AS nilai_transaksi
FROM fact_transactions t
JOIN dim_channels c
    ON t.channel_id = c.channel_id
JOIN dim_dates d
    ON t.transaction_date = d.full_date
GROUP BY
    d.year,
    c.channel_name
ORDER BY
    d.year,
    nilai_transaksi DESC;


-- Trend Growth Volume Transaksi Channel perbulan
WITH summary_channel_monthly AS (
    SELECT
        d.year,
        d.month_name,
        c.channel_name,
        COUNT(t.transaction_id) AS volume_transaksi
    FROM fact_transactions t
    JOIN dim_channels c
        ON t.channel_id = c.channel_id
    JOIN dim_dates d
        ON t.transaction_date = d.full_date
    WHERE c.channel_name = 'ATM'
    GROUP BY
        d.year,
        d.month_name,
        c.channel_name
)
SELECT
    year,
    month_name,
    channel_name,
    volume_transaksi,
    LAG(volume_transaksi) OVER (
        PARTITION BY channel_name
        ORDER BY year
    ) AS prev_volume,
    ROUND(
        (
            volume_transaksi -
            LAG(volume_transaksi) OVER (
                PARTITION BY channel_name
                ORDER BY year
            )
        ) * 100.0 /
        NULLIF(
            LAG(volume_transaksi) OVER (
                PARTITION BY channel_name
                ORDER BY year
            ),
            0
        ),
        2
    ) AS volume_growth_pct
FROM summary_channel_monthly
ORDER BY channel_name,year;