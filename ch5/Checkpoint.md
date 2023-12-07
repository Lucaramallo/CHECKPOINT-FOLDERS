# Checkpoint - Módulo 5

Cómo responder: <br>
* Cuando se pida una respuesta numérica, redondear al entero más cercano. <br>
   Ejemplo: 1.3421 -> 1 <br>
            1.8888 -> 2 <br>

Formas parte del equipo de Data Analytics de una empresa del sector inmobiliario. En la base de datos "properties.csv" se encuentra información de 25660 propiedades en venta de Argentina y Colombia.
Para cada registro (fila) los siguientes atributos sobre la ubicación de la vivienda:
* país
* provincia_departamento
* ciudad 

Algunas características de la vivienda:
* property_type (Tipo de propiedad) 
* rooms
* bedrooms
* bathrooms
* Surface_total (Superficie total en metros cuadrados)
* price_USD (Valor total en dólares)

## Con base a esta información se pide responder a las siguientes preguntas eligiendo la opción correspondiente:

### 1.	Después de inspeccionar la base de datos, ¿Cuál variable (atributo) no aporta suficiente claridad para este estudio?

1. ciudad<br>
2. property_type<br>
3. price_USD<br>
<br>

### 2.	El equipo directivo quiere conocer si hay alguna correlación entre la cantidad superficie total en metros cuadrados y el precio en dólares. ¿Cuál de las siguientes opciones es la más adecuada?

1. Boxplot<br>
2. Scatter chart<br> 
3. Line Chart<br>
4. Pie Chart<br>
<br>

### 3. A nivel general, ¿en qué Ciudad se encuentra la propiedad con el mayor valor por metro cuadrado?

1. Bogotá D.C<br>
2. Palermo<br>
3. Cali<br>
<br>

### 4. ¿Cuál es el valor por metro cuadrado de la propiedad encontrada en el punto anterior? Aproxime al entero más cercano.

1. 63298<br>
2. 2466<br>
3. 5300<br>
<br>

### 5. El cliente está interesado en conocer cómo varía el valor por metro cuadrado de acuerdo con las diferentes provincias en el caso de Argentina y a los departamentos en el caso de Colombia. Para lograr este objetivo desea crear un top 5 de las provincias con los valores por metro cuadrado más costosos. Se indica una serie de pasos a continuación (de una forma de hacerlo, podrían existir muchas más)

    a. Se realiza un filtro avanzado sobre el objeto visual con el Top N teniendo en cuenta el valor de la columna calculada. 
    b. Se crea una columna calculada utilizando las columnas price_USD y surface_total.
    c. Se crea un diagrama de barras. En el eje X ubicamos el promedio de la columna calculada y en el eje Y, provincia_departamento.
    d. Se realiza un filtro de página, una vez se tiene la visualización para mostrar lo referente a Argentina. 

### ¿Cuál es el orden correcto?

1. b, c, a, d<br> 
2. a, b, c, d<br>
3. b, a, c, d<br>
<br> 

### 6. De acuerdo con el gráfico anterior, ¿Cuál es el Departamento en Colombia que tiene el mayor valor promedio de precio por metro cuadrado?

1. Valle del Cauca<br> 
2. Cundinamarca<br>
3. Bolívar<br>
<br> 

### 7. Supongamos que se quiere crear un modelo relacional y se tiene una Tabla Clientes adicional que contiene datos referentes a las personas que compraron la vivienda, tales como la edad, la profesión, entre otros. La tabla Clientes contiene un campo llamado IdCliente. Si se subiera el archivo, ¿Power BI detecta la relación con la Tabla properties automáticamente?

1. Sí<br>
2. No<br>
<br>

### 8. El equipo directivo considera realizar un modelo en cual se ingresen algunas variables del modelo para una vivienda nueva (que no esté en la base de datos) y determinar el valor en USD del inmueble. Este tipo de estudio es...

1. Descriptivo<br>
2. Dashboard Interactivo<br>
3. Predictivo<br>
4. Prescriptivo<br>
<br>

### 9. Si se agrega un Calendar en PowerQuery para saber la fecha en la cual se está vendiendo el inmueble. ¿Esta fórmula contiene un error? 
### Calendario = CALENDAR(MAX(Ventas[Fecha]),MIN(Ventas[Fecha]))

1. Sí<br>
2. No<br>
<br>

### 10. Y respecto a la siguiente fórmula, ¿posee un error?
### Calendario = CALENDAR(MIN([Fecha]),MAX(Ventas[Fecha]))

1. Sí<br>
2. No<br>
<br>

### 11. ¿Cuál es la cantidad de propiedades que tienen un precio mayor a 100000 USD en Argentina? 

1. 9397<br>
2. 13258<br>
3. 0<br>
<br>

### 12. El equipo de Marketing está interesado en conectarse a una API que contiene un ranking de viviendas para mejorar el modelo que están realizando. ¿Cómo se especifica la consulta a realizar a una API para extraer un determinado conjunto de datos de interés?

1. Se debe solicitar todo el código HTML, y luego implementar un código para extraer los datos de interés.<br>
2. Se debe especificar un diccionario estándar con las variables, fechas y cantidad de datos a extraer.<br>
3. Se debe especificar una lista de las variables a extraer.<br>
4. Se debe consultar la documentación de la API para identificar exactamente cómo plantear la query, ya sea mediante un texto de consulta, o un diccionario de parámetros.<br>
<br>

### 13. Para construir el siguiente gráfico ¿se utilizó la siguiente línea de código?
### sns.histplot(data=df,x='price_USD_m2',hue='pais',ax=ax,kde=True);

<img src='imagenes/histplot.jpg'>

1. Sí<br>
2. No<br>
<br>

### 14. Observe el siguiente gráfico. 

<img src='imagenes/boxplot.jpg'>

### Un colega observa esta visualización y afirma que “Sobre todo en Argentina, el precio_USD_M2 tiende a aumentar con el número de baños” ¿Esto es correcto?

1. Sí<br>
2. No<br>
<br>

### 15. Otro colega afirma: “Dado que la relación es distinta entre países entre precio y superficie total. El país es una variable categórica irrelevante a considerar en un modelo predictivo” ¿Esta afirmación es correcta?

1. Sí<br>
2. No<br>
<br>

### 16. Hay algunos precios que pueden clasificarse como Outiliers, ¿Cuál de las siguientes es una mala opción para detectar mediante una visualización que hay outliers?

1. Boxplot<br>
2. Pairplot<br>
3. Hisplot<br>
4. Pie<br>
<br>

## Compartir con los alumnos:
* properties.csv
