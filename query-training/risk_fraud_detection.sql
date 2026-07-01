-- Transaksi dengan Nominal Tidak Wajar (>3x rata-rata transaksi)
WITH customer_avg AS (
    SELECT
        customer_id,
        AVG(amount) AS avg_amount
    FROM fact_transactions
    GROUP BY customer_id
)
SELECT
    t.transaction_id,
    t.transaction_code,
    c.customer_code,
    c.full_name,
    ch.channel_name,
    t.transaction_at,
    t.amount,
    ca.avg_amount,
    ROUND(
        t.amount / NULLIF(ca.avg_amount,0),
        2
    ) AS kelipatan_rata_rata

FROM fact_transactions t
JOIN customer_avg ca
    ON t.customer_id = ca.customer_id
JOIN dim_customers c
    ON t.customer_id = c.customer_id
JOIN dim_channels ch
    ON t.channel_id = ch.channel_id
WHERE t.amount > (ca.avg_amount * 3)
ORDER BY t.amount DESC;

