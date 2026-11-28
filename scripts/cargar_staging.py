import io
import os
import sys

import pandas as pd
import psycopg2

COLUMNAS = [
    "UNITID", "INSTNM", "CITY", "STABBR", "ST_FIPS", "T4APPROVALDATE",
    "CONTROL", "CONTROL_PEPS", "COSTT4_A", "GRAD_DEBT_MDN", "MD_EARN_WNE_P10",
]

ruta_csv = sys.argv[1] if len(sys.argv) > 1 else "data/Most-Recent-Cohorts-Institution.csv"
dsn = os.environ.get("DATABASE_URL", "postgresql://localhost:5432/college_scorecard")

df = pd.read_csv(ruta_csv, usecols=COLUMNAS, dtype=str, keep_default_na=False)[COLUMNAS]

buffer = io.StringIO()
df.to_csv(buffer, index=False, header=False)
buffer.seek(0)

with psycopg2.connect(dsn) as conn, conn.cursor() as cur:
    cur.execute("TRUNCATE staging.institucion_raw;")
    cur.copy_expert(
        f"COPY staging.institucion_raw ({', '.join(c.lower() for c in COLUMNAS)}) FROM STDIN WITH (FORMAT csv)",
        buffer,
    )
    cur.execute("SELECT COUNT(*) FROM staging.institucion_raw;")
    print(f"Cargadas {cur.fetchone()[0]:,} filas")
