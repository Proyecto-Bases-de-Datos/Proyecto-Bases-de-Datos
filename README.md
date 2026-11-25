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
