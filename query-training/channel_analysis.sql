SELECT
    c.channel_name,
    c.channel_category,
    COUNT(t.transaction_id) AS volume_transaksi,
    SUM(t.amount) AS nilai_transaksi,
    ROUND(AVG(t.amount),2) AS rata_rata_transaksi
FROM fact_transactions t
JOIN dim_channels c
    ON t.channel_id = c.channel_id
GROUP BY
    c.channel_name,
    c.channel_category,
    c.is_digital
ORDER BY volume_transaksi DESC;