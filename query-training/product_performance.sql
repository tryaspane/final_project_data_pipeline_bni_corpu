SELECT
    d.year,
    d.month,
    d.month_name,
    a.product_name,
    a.account_type,
    COUNT(t.transaction_id) AS volume_transaksi,
    SUM(t.amount) AS nilai_transaksi,
    ROUND(AVG(t.balance_after), 2) AS saldo_rata_rata,
    ROUND(AVG(t.amount), 2) AS rata_rata_nominal_transaksi
FROM fact_transactions t
JOIN dim_accounts a
    ON t.account_id = a.account_id
JOIN dim_dates d
    ON t.transaction_date = d.full_date
GROUP BY
    d.year,
    d.month,
    d.month_name,
    a.product_name,
    a.account_type
ORDER BY
    d.year,
    d.month,
    volume_transaksi DESC;