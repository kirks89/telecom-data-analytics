CREATE TABLE IF NOT EXISTS bronze.load_audit (
    load_id       INT AUTO_INCREMENT PRIMARY KEY,
    source_file   VARCHAR(255) NOT NULL,
    target_table  VARCHAR(100) NOT NULL,
    rows_loaded   INT          NOT NULL,
    load_ts       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP
);