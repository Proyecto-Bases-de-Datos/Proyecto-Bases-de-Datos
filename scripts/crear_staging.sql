CREATE SCHEMA IF NOT EXISTS staging;

DROP TABLE IF EXISTS staging.institucion_raw CASCADE;

CREATE TABLE staging.institucion_raw (
    unitid          TEXT,
    instnm          TEXT,
    city            TEXT,
    stabbr          TEXT,
    st_fips         TEXT,
    t4approvaldate  TEXT,
    control         TEXT,
    control_peps    TEXT,
    costt4_a        TEXT,
    grad_debt_mdn   TEXT,
    md_earn_wne_p10 TEXT
);
