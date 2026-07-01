-- Top Nasabah Paling Aktif (Frekuensi & Nilai)
SELECT
    c.customer_id,
    c.customer_code,
    c.full_name,
    c.segment,
    a.account_no,
    a.account_type,
    a.product_name,
    COUNT(t.transaction_id) AS frekuensi_transaksi,
    SUM(t.amount) AS total_nilai_transaksi,
    ROUND(AVG(t.amount), 2) AS rata_rata_transaksi
FROM fact_transactions t
JOIN dim_customers c
    ON t.customer_id = c.customer_id
JOIN dim_accounts a
    ON t.account_id = a.account_id
GROUP BY
    c.customer_id,
    c.customer_code,
    c.full_name,
    c.segment,
    a.account_no,
    a.account_type,
    a.product_name
ORDER BY
    frekuensi_transaksi DESC,
    total_nilai_transaksi DESC;


    -- Distribusi Per Segment
    SELECT
    c.segment,

    COUNT(DISTINCT c.customer_id) AS jumlah_nasabah,
    COUNT(t.transaction_id) AS volume_transaksi,
    SUM(t.amount) AS nilai_transaksi,

    ROUND(
        AVG(t.amount),
        2
    ) AS rata_rata_transaksi

FROM fact_transactions t
JOIN dim_customers c
    ON t.customer_id = c.customer_id

GROUP BY
    c.segment

ORDER BY
    nilai_transaksi DESC;