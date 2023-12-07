USE checkpoint_m2;



SELECT *
FROM canal_venta
LIMIT 10;


SELECT *
FROM producto;

SELECT *
FROM venta;

-- id producto buscado:

SELECT *
FROM producto
where Concepto = 'EPSON COPYFAX 2000'
limit 10;



-- 7) ¿Cuál es el canal de venta con menor venta total registradas? 
-- (venta = precio * cantidad) *


SELECT IdCanal,sum(Precio) as P,sum(Cantidad) as Q,(sum(Precio)*sum(Cantidad)) as P_x_Q
FROM venta
GROUP BY IdCanal
ORDER BY P_x_Q asc;




-- 8) ¿Cuál fue el mes con la mayor venta de la sucursal 13 para el año 2015? 
-- (venta = precio * cantidad) *

-- Pista para agrupar por mes podes usar
-- el DATE_FORMAT( date,'%Y%m') --> YYYYMM 
-- o  DATE_FORMAT( date,'%m') --> MM


SELECT (date_format( Fecha ,'%Y')) AS año,(date_format( Fecha ,'%m')) AS mes  ,sum(Precio) as P,sum(Cantidad) as Q,(sum(Precio)*sum(Cantidad)) as P_x_Q 
FROM venta
WHERE YEAR(Fecha) = 2015 AND  IdSucursal = 13 
GROUP BY Fecha
ORDER BY P_x_Q desc, año desc, mes desc
Limit 1;


-- 9) Se define el tiempo de entrega como el tiempo en días transcurrido
-- entre que se realiza la compra y se efectua la entrega. 
-- Para analizar mejoras en el servicio, 
-- la dirección desea saber cuál es el año con el promedio más alto de este tiempo de entrega.

-- (Fecha = Fecha de venta; Fecha_Entrega = Fecha de entrega)

-- Pista: acordate de las funciones de agregacion AVG/SUM/MIN/MAX


SELECT 
  (date_format( Fecha ,'%Y')) AS año,
  AVG(TIMESTAMPDIFF(DAY,date_format( Fecha ,'%Y%m%d'),date_format( Fecha_Entrega ,'%Y%m%d'))) AS prom_demoras_en_dias
FROM 
  venta
GROUP BY 
  año 
ORDER BY año DESC;


-- 10) La dirección desea saber qué tipo de producto tiene la mayor venta total en 2020
-- (Tabla 'producto', campo Tipo = Tipo de producto) *

-- Pista: acordate de las funciones de agregacion AVG/SUM/MIN/MAX


SELECT 
  producto.IdProducto,
  producto.Concepto,
  producto.Tipo,
  (date_format( venta.Fecha ,'%Y')) AS año, 
  SUM(venta.Precio) as P,
  SUM(venta.Cantidad) as Q,
  (SUM(venta.Precio)*SUM(venta.Cantidad)) as P_x_Q
FROM 
  venta
INNER JOIN producto
ON venta.IdProducto = producto.IdProducto
GROUP BY 
  producto.IdProducto,
  (date_format( venta.Fecha ,'%Y'))
ORDER BY 
  date_format( venta.Fecha ,'%Y') DESC, P_x_Q DESC;

SELECT *
FROM producto;



-- 11) ¿Cuál es el año y mes con la mayor cantidad de productos vendidos? *
-- Informar la respuesta con 4 digitos para el año y 2 para el mes
-- #### Por ejemplo 201506 seria Junio 2015
-- #### Pista para agrupar por mes podes usar el   DATE_FORMAT( date,'%Y%m') --> YYYYMM o  DATE_FORMAT( date,'%m') --> MM 

SELECT (date_format( venta.Fecha ,'%Y%m')) AS añomes ,sum(Precio) as P,sum(Cantidad) as Q,(sum(Precio)*sum(Cantidad)) as P_x_Q
FROM venta
GROUP BY Fecha
ORDER BY P_x_Q asc;

-- 12) ¿Cuántos productos tienen la palabra DVD en alguna parte de su nombre/concepto? *

SELECT count(IDProducto) as cantidad
FROM producto
WHERE Concepto LIKE'%DVD%';


-- 13) ¿Cual de estos tipos de producto tiene la menor diferencia de precio
-- entre sus mínimos y máximos? *

SELECT (max(Precio)-min(Precio)) AS dif_$,Tipo
FROM producto
GROUP BY Tipo
ORDER BY dif_$
LIMIT 1;


-- 14) Teniendo en cuenta que Fecha es la fecha de compra y
-- Fecha_Entrega es la fecha en que se entregó el producto,
-- ¿Cuántas ventas NO se entregaron el mismo mes en que fueron compradas? *

SELECT *
FROM venta;

SELECT count(IdVenta) AS cantidad_de_ventas
FROM venta
WHERE DATE_FORMAT(Fecha_Entrega,'%Y%m') - (DATE_FORMAT(Fecha,'%Y%m'))  > 1 ;


-- 15) ¿Cuál es el Id del empleado 
-- que mayor cantidad de productos vendió en toda la historia de las ventas? *

SELECT *
FROM venta;

SELECT COUNT(*) AS cant_prod_vend,
IdEmpleado AS ID
FROM venta
GROUP BY ID
ORDER BY cant_prod_vend DESC;
















