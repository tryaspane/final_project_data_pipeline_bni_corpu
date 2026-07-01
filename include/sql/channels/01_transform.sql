-- Transform: stg_channels → dim_channels
-- Cast tipe data, tambah derived columns, deduplikasi

TRUNCATE TABLE dim_channels;

INSERT INTO dim_channels (
    channel_id,
    channel_code,
    channel_name,
    channel_category,
    is_digital,
    description
)
SELECT DISTINCT ON (channel_id)
    channel_id,
    channel_code,
    channel_name,
    channel_category,
    is_digital,
    description
FROM stg_channels
WHERE channel_id IS NOT NULL
ORDER BY channel_id;
