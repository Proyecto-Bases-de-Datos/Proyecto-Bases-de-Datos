SELECT COUNT(*) AS filas,
       COUNT(DISTINCT unitid) AS unitid,
       COUNT(DISTINCT instnm) AS instnm,
       COUNT(DISTINCT city)   AS city,
       COUNT(DISTINCT stabbr) AS stabbr
FROM staging.institucion;

SELECT MIN(t4approvaldate) AS fecha_minima, MAX(t4approvaldate) AS fecha_maxima
FROM staging.institucion;

SELECT MIN(costt4_a)        AS costo_min,   MAX(costt4_a)        AS costo_max,   ROUND(AVG(costt4_a))        AS costo_prom,
       MIN(grad_debt_mdn)   AS deuda_min,   MAX(grad_debt_mdn)   AS deuda_max,   ROUND(AVG(grad_debt_mdn))   AS deuda_prom,
       MIN(md_earn_wne_p10) AS ingreso_min, MAX(md_earn_wne_p10) AS ingreso_max, ROUND(AVG(md_earn_wne_p10)) AS ingreso_prom
FROM staging.institucion;

SELECT instnm, COUNT(*) AS veces
FROM staging.institucion
GROUP BY instnm
HAVING COUNT(*) > 1
ORDER BY veces DESC;

SELECT COUNT(DISTINCT stabbr) AS stabbr, COUNT(DISTINCT st_fips) AS st_fips,
       COUNT(DISTINCT (stabbr, st_fips)) AS combinaciones
FROM staging.institucion;

SELECT control, COUNT(*) AS instituciones
FROM staging.institucion
GROUP BY control
ORDER BY control;

SELECT stabbr, COUNT(*) AS instituciones
FROM staging.institucion
GROUP BY stabbr
ORDER BY instituciones DESC, stabbr;

SELECT COUNT(*) - COUNT(unitid)          AS unitid,
       COUNT(*) - COUNT(instnm)          AS instnm,
       COUNT(*) - COUNT(city)            AS city,
       COUNT(*) - COUNT(stabbr)          AS stabbr,
       COUNT(*) - COUNT(st_fips)         AS st_fips,
       COUNT(*) - COUNT(t4approvaldate)  AS t4approvaldate,
       COUNT(*) - COUNT(control)         AS control,
       COUNT(*) - COUNT(control_peps)    AS control_peps,
       COUNT(*) - COUNT(costt4_a)        AS costt4_a,
       COUNT(*) - COUNT(grad_debt_mdn)   AS grad_debt_mdn,
       COUNT(*) - COUNT(md_earn_wne_p10) AS md_earn_wne_p10
FROM staging.institucion;

SELECT control, control_peps, COUNT(*) AS instituciones
FROM staging.institucion
GROUP BY control, control_peps
ORDER BY control, instituciones DESC;

SELECT instnm, grad_debt_mdn, md_earn_wne_p10
FROM staging.institucion
WHERE grad_debt_mdn <= 0 OR grad_debt_mdn > md_earn_wne_p10;
