-- =============================================
-- Layer:   Bronze
-- File:    02_create_raw_tables.sql
-- Purpose: Raw tables, one per source, all columns VARCHAR
--          (data stored exactly as received).
--          Both counter files (main + late) load into
--          kpi_counters_hourly; source_file and load_ts
--          tell them apart.
-- =============================================


CREATE TABLE IF NOT EXISTS bronze.site_inventory (
	site_id          VARCHAR(50),
    site_name        VARCHAR(255),
    region           VARCHAR(100),
    district         VARCHAR(100),
    area_type        VARCHAR(50),
    technology       VARCHAR(50),
    vendor           VARCHAR(100),
    latitude         VARCHAR(50),
    longitude        VARCHAR(50),
    commission_date  VARCHAR(50),
    -- load metadata
    load_ts  DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    source_file      VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS bronze.kpi_counters_hourly (
    ts_hour             VARCHAR(50),
    site_id             VARCHAR(50),
    call_attempts       VARCHAR(50),
    call_setup_success  VARCHAR(50),
    call_drops          VARCHAR(50),
    ho_attempts         VARCHAR(50),
    ho_success          VARCHAR(50),
    traffic_erl         VARCHAR(50),
    data_volume_gb      VARCHAR(50),
    prb_util_pct        VARCHAR(50),
    avail_seconds       VARCHAR(50),
    -- load metadata
    load_ts  DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    source_file         VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS bronze.alarms_log (
    alarm_id     VARCHAR(50),
    site_id      VARCHAR(50),
    raised_ts    VARCHAR(50),
    cleared_ts   VARCHAR(50),
    alarm_code   VARCHAR(50),
    alarm_text   VARCHAR(255),
    severity     VARCHAR(50),
    -- load metadata
    load_ts  DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    source_file  VARCHAR(255) NOT NULL
);

CREATE TABLE IF NOT EXISTS bronze.incidents (
    ticket_id    VARCHAR(50),
    site_id      VARCHAR(50),
    opened_ts    VARCHAR(50),
    closed_ts    VARCHAR(50),
    category     VARCHAR(100),
    root_cause   VARCHAR(255),
    priority     VARCHAR(50),
    -- load metadata
    load_ts  DATETIME(6)  NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    source_file  VARCHAR(255) NOT NULL
);