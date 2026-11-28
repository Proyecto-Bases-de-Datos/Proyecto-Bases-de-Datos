CREATE OR REPLACE FUNCTION staging.limpiar(valor TEXT) RETURNS TEXT
LANGUAGE sql IMMUTABLE AS $$
    SELECT CASE WHEN valor IS NULL OR btrim(valor) IN ('', 'NA', 'PS') THEN NULL ELSE btrim(valor) END;
$$;

DROP TABLE IF EXISTS staging.institucion CASCADE;

CREATE TABLE staging.institucion AS
SELECT
    staging.limpiar(unitid)::INTEGER                       AS unitid,
    staging.limpiar(instnm)                                AS instnm,
    staging.limpiar(city)                                  AS city,
    upper(staging.limpiar(stabbr))                         AS stabbr,
    staging.limpiar(st_fips)::INTEGER                      AS st_fips,
    to_date(staging.limpiar(t4approvaldate), 'MM/DD/YYYY') AS t4approvaldate,
    staging.limpiar(control)::INTEGER                      AS control,
    staging.limpiar(control_peps)                          AS control_peps,
    staging.limpiar(costt4_a)::INTEGER                     AS costt4_a,
    staging.limpiar(grad_debt_mdn)::NUMERIC(10,2)          AS grad_debt_mdn,
    staging.limpiar(md_earn_wne_p10)::INTEGER              AS md_earn_wne_p10
FROM staging.institucion_raw;

ALTER TABLE staging.institucion ADD PRIMARY KEY (unitid);
