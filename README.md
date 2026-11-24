# Telecom Network Analytics Platform

> **All data in this repository is synthetic.** It describes a fictional Portuguese mobile operator.

An end-to-end **Medallion data platform** (Bronze → Silver → Gold) built on raw, messy network counters,
the way an OSS export really looks. KPIs are calculated in SQL from counters, never stored pre-computed.

**Business question:** the operator wants a call drop rate (CDR) below 2%. Where, when and why is it failing?

## Architecture
CSV sources → Bronze (raw, MariaDB) → Silver (clean, data quality, KPI views) → Python (health score, anomalies)
→ Gold (star schema) → Power BI + Splunk, orchestrated with Azure Data Factory.

## Stack
MariaDB 11.8.10 · DBeaver · Python (pandas, numpy) · Power BI Desktop · Splunk Enterprise · Azure Data Factory · Git/GitHub

## Repository structure
| Folder | Content |
|---|---|
| `data/raw/` | Input files (CSVs not committed - see `README_DATA.md`) |
| `sql/01_bronze/` | Databases, raw tables, loads, load audit |
| `sql/02_silver/` | Cleaning, deduplication, `dq_rejects`, KPI views |
| `sql/03_analysis/` | Analysis exercises and findings |
| `sql/04_gold/` | Star schema |
| `python/` | Data generator and enrichment (health score, anomalies) |
| `powerbi/` | Report and theme |
| `splunk/` | SPL searches, dashboards, alerts |
| `docs/` | Data dictionary, diagrams, decisions |

## Status
- [x] Week 1 - Raw data received
- [ ] Week 2 - Bronze layer
- [ ] Week 3 - Silver: cleaning and KPI views
- [ ] Week 4 - Silver: analysis and findings
- [ ] Week 5 - Python enrichment
- [ ] Week 6 - Gold + Power BI
- [ ] Week 7 - Splunk
- [ ] Week 8 - Azure orchestration and polish
