-- Ranking Cabang per Region
SELECT
    b.region,
    b.branch_id,
    b.branch_code,
    b.branch_name,
    b.city,
    COUNT(t.transaction_id) AS jumlah_transaksi,
    SUM(t.amount) AS total_nilai_transaksi,
    RANK() OVER (
        PARTITION BY b.region
        ORDER BY COUNT(t.transaction_id) DESC
    ) AS rank_volume,

    RANK() OVER (
        PARTITION BY b.region
        ORDER BY SUM(t.amount) DESC
    ) AS rank_nilai
FROM fact_transactions t
JOIN dim_branches b
    ON t.branch_id = b.branch_id
GROUP BY
    b.region,
    b.branch_id,
    b.branch_code,
    b.branch_name,
    b.city
ORDER BY
    b.region,
    rank_volume;