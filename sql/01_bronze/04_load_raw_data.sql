-- =============================================
-- Layer:   Bronze
-- File:    04_load_raw_data.sql
-- Purpose: Load raw CSV files into Bronze tables, as received.
--          Each load is logged in bronze.load_audit.
-- Requires: local_infile=ON (server) and
--           allowLoadLocalInfile=true (DBeaver driver)
-- Idempotent: data tables are truncated before loading;
--             load_audit is never truncated (load history).
-- =============================================

-- ===== site_inventory =====
TRUNCATE TABLE bronze.site_inventory;

LOAD DATA LOCAL INFILE 'C:/Projects/telecom-data-analytics/data/raw/site_inventory.csv'
INTO TABLE bronze.site_inventory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(site_id, site_name, region, district, area_type, technology,
 vendor, latitude, longitude, commission_date)
SET source_file = 'site_inventory.csv';

INSERT INTO bronze.load_audit (source_file, target_table, rows_loaded)
SELECT 'site_inventory.csv', 'bronze.site_inventory', COUNT(*)
FROM bronze.site_inventory
WHERE source_file = 'site_inventory.csv';

-- ===== kpi_counters_hourly: main export (separator ,) =====
-- Truncate ONCE: both counter files load into this table.
TRUNCATE TABLE bronze.kpi_counters_hourly;

LOAD DATA LOCAL INFILE 'C:/Projects/telecom-data-analytics/data/raw/kpi_counters_hourly.csv'
INTO TABLE bronze.kpi_counters_hourly
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ts_hour, site_id, call_attempts, call_setup_success, call_drops,
 ho_attempts, ho_success, traffic_erl, data_volume_gb,
 prb_util_pct, avail_seconds)
SET source_file = 'kpi_counters_hourly.csv';

INSERT INTO bronze.load_audit (source_file, target_table, rows_loaded)
SELECT 'kpi_counters_hourly.csv', 'bronze.kpi_counters_hourly', COUNT(*)
FROM bronze.kpi_counters_hourly
WHERE source_file = 'kpi_counters_hourly.csv';

-- ===== kpi_counters_hourly: late re-export (separator ;) =====
-- Loaded after the main export, so its load_ts is later.
-- Silver keeps the most recent version of each site + hour.
LOAD DATA LOCAL INFILE 'C:/Projects/telecom-data-analytics/data/raw/kpi_counters_hourly_late.csv'
INTO TABLE bronze.kpi_counters_hourly
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ts_hour, site_id, call_attempts, call_setup_success, call_drops,
 ho_attempts, ho_success, traffic_erl, data_volume_gb,
 prb_util_pct, avail_seconds)
SET source_file = 'kpi_counters_hourly_late.csv';

INSERT INTO bronze.load_audit (source_file, target_table, rows_loaded)
SELECT 'kpi_counters_hourly_late.csv', 'bronze.kpi_counters_hourly', COUNT(*)
FROM bronze.kpi_counters_hourly
WHERE source_file = 'kpi_counters_hourly_late.csv';

-- ===== alarms_log =====
TRUNCATE TABLE bronze.alarms_log;

LOAD DATA LOCAL INFILE 'C:/Projects/telecom-data-analytics/data/raw/alarms_log.csv'
INTO TABLE bronze.alarms_log
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(alarm_id, site_id, raised_ts, cleared_ts, alarm_code, alarm_text, severity)
SET source_file = 'alarms_log.csv';

INSERT INTO bronze.load_audit (source_file, target_table, rows_loaded)
SELECT 'alarms_log.csv', 'bronze.alarms_log', COUNT(*)
FROM bronze.alarms_log
WHERE source_file = 'alarms_log.csv';

-- ===== incidents =====
TRUNCATE TABLE bronze.incidents;

LOAD DATA LOCAL INFILE 'C:/Projects/telecom-data-analytics/data/raw/incidents.csv'
INTO TABLE bronze.incidents
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ticket_id, site_id, opened_ts, closed_ts, category, root_cause, priority)
SET source_file = 'incidents.csv';

INSERT INTO bronze.load_audit (source_file, target_table, rows_loaded)
SELECT 'incidents.csv', 'bronze.incidents', COUNT(*)
FROM bronze.incidents
WHERE source_file = 'incidents.csv';




