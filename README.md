# Proyecto-Bases-de-Datos
El proyecto busca analizar las estadísticas sobre educación en Estados Unidos

Es posible acceder a los datos originales mediante:
https://collegescorecard.ed.gov/data/
Y https://catalog.data.gov/dataset/college-scorecard

Los datos tratan acerca de varias instituciones en Estados Unidos, y pueden ser utilizados para compararlas.
El organismo que la emite es el Departamento de Educación de Estados Unidos.
La obtención de los datos es ayudar a elegir de manera informada a qué universidad entrar.
Se alojan en un xlsx y un zip en la fuente original. Yo los descargué a mi computadora y de ahí obtuve los datos.
Sus actualizaciones no tienen calendario fijo, sin embargo segun el registro de cambios a la página del departamento, suelen cambiar 3 o 4 veces por año.
El diccionario tiene varios datos, pero los más importantes son:
CONTROL - Dice si la institución es pública, privada con o sin fines de lucro
COSTT4_A - Costo promedio de asistencia anual (incluye colegiatura, vivienda, etc)
GRAD_DEBT_MDN - Mide la mediana de la deuda de los egresados
MEAN_EARN_WNE_P10 - La mediana del ingreso de los egresados 10 años después de salir
De estos, las últimas tres son cuantitativas mientras que el control es cualitativa (categórica, hay tres categorías)
No hay columnas de texto libre, pero sí hay textuales, como puede ser la de CONTROL.
Trabajaremos sobre un estado estático, pero la variable MEAN_EARN_WNE_P10 está relacionado al tiempo pues mide el ingreso en 10 años
El objetivo principal de este análisis es entender estas cuatro variables y las relaciones entre ellas. 
No veo muchos dilemas éticos en el procesamiento de estos datos, pues el gobierno de Estados Unidos está publicando estos datos de manera deliberada para que podamos entenderlos y analizarlos. Creo, por el contrario, que al hacer esto estamos utilizando esos datos para aquello por lo que fueron puestos ahí en un principio.

se usan cuatro scripts. El script 01_crear_staging.sql crea el esquema staging y la tabla institucion_raw, donde se guardan las 11 columnas del proyecto como texto. El script cargar_staging.py lee del CSV las columnas UNITID, INSTNM, CITY, STABBR, ST_FIPS, T4APPROVALDATE, CONTROL, CONTROL_PEPS, COSTT4_A, GRAD_DEBT_MDN y MD_EARN_WNE_P10, y las carga en esa tabla. El script 03_limpiar_staging.sql crea la tabla staging.institucion, convierte los valores PS y NA en nulos, asigna los tipos de dato correctos y define UNITID como llave primaria. Por último, 04_analisis_exploratorio.sql contiene las consultas del análisis exploratorio.

Para cargar los datos, primero se guarda el archivo Most-Recent-Cohorts-Institution.csv en la carpeta data y se instalan las librerías con pip3 install pandas psycopg2-binary. Después se crea la base de datos college_scorecard y se ejecuta en ella el script 01. Luego, desde la terminal, se define la conexión con export DATABASE_URL="postgresql://usuario:contraseña@localhost:5423/college_scorecard" y se ejecuta python3 scripts/cargar_staging.py data/Most-Recent-Cohorts-Institution.csv. Finalmente se ejecutan los scripts 03 y 04 en la misma base.

El análisis exploratorio mostró que UNITID es la única columna con valores únicos (6,272 en 6,272 filas). La fecha de aprobación para ayuda federal (T4APPROVALDATE) va del 1 de enero de 1965 al 18 de noviembre de 2025. El costo anual (COSTT4_A) va de 3,976 a 95,168 dólares, con un promedio de 32,704; la deuda mediana (GRAD_DEBT_MDN) va de 0 a 50,350, con un promedio de 15,408; y el ingreso a 10 años (MD_EARN_WNE_P10) va de 14,374 a 166,642, con un promedio de 48,641.

En cuanto a duplicados, 81 nombres de institución se repiten; el caso más frecuente es Cortiva Institute, que aparece 6 veces. Las columnas STABBR y ST_FIPS son redundantes, ya que tienen una relación uno a uno, y CONTROL_PEPS repite la información de CONTROL. Por tipo de institución, hay 2,047 públicas, 1,900 privadas sin fines de lucro y 2,325 privadas con fines de lucro.

Los valores nulos se concentran en COSTT4_A (3,044), GRAD_DEBT_MDN (1,496), MD_EARN_WNE_P10 (983), T4APPROVALDATE (494) y CONTROL_PEPS (21); el resto de las columnas no tiene nulos. Entre las inconsistencias encontradas, CONTROL y CONTROL_PEPS no coinciden en 70 instituciones, Best Care College reporta una deuda mediana de 0 y Beulah Heights University tiene una deuda mayor que su ingreso anual.