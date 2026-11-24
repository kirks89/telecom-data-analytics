# Raw data delivery - fictional Portuguese mobile operator

> **SYNTHETIC DATA.** Generated for a portfolio project. No real operator, network or customer data.

Handover note from the "network operations" team, as you would receive it on day one.
Nobody has checked these files. Assume nothing: profile everything before you trust it.

| File | Source system | What it is |
|---|---|---|
| `site_inventory.csv` | Planning database | One row per radio site (4G/5G), Portugal mainland |
| `kpi_counters_hourly.csv` | OSS performance export | Raw hourly counters per site, 01/08/2026 - 29/10/2026 |
| `kpi_counters_hourly_late.csv` | OSS re-export tool | Counter rows delivered two days late by a different export tool |
| `alarms_log.csv` | Fault management system | Alarm events (raised / cleared) |
| `incidents.csv` | Ticketing tool | Incident tickets opened by the NOC |

Notes from the operations team (as written, not verified):
- "OSS timestamps are in Portugal local time, we think."
- "Counters are raw. KPIs are not in the export, you have to calculate them."
- "Alarm codes are vendor-neutral; the text column explains them."
- "The late file came from another tool, the format might be a bit different."

Counter definitions (per site, per hour):

| Column | Meaning |
|---|---|
| `call_attempts` | Voice call setup attempts (VoLTE/VoNR, simplified as "calls") |
| `call_setup_success` | Successfully established calls |
| `call_drops` | Established calls released abnormally |
| `ho_attempts` / `ho_success` | Outgoing handover attempts / successes |
| `traffic_erl` | Carried voice traffic (Erlang) |
| `data_volume_gb` | Data volume (DL+UL), GB |
| `prb_util_pct` | Average PRB (radio resource) utilisation in the hour, % |
| `avail_seconds` | Seconds in the hour the cell was available (max 3600) |
