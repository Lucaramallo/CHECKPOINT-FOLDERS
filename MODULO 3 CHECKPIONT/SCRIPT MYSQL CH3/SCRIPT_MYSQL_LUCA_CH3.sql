/*USE henry_m3;

-- true false

SELECT Fecha, COUNT(*) 
FROM venta 
GROUP BY Fecha
HAVING COUNT(*) > 10;*/


/*
8) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = Venta - Gasto) ¿Cuál es la sucursal con mayor ganancia neta en 2020?

 *
9) Del total de clientes que realizaron compras en 2020 ¿Qué porcentaje lo hizo sólo en una única sucursal?

 *
10) Del total de clientes que realizaron compras en 2020 ¿Qué porcentaje no había realizado compras en 2019?

 *
11) Del total de clientes que realizaron compras en 2019 ¿Qué porcentaje lo hizo sólo en una única sucursal?

 *
12) A partir de los datos de las Ventas, Compras y Gastos de los años 2020 y 2019, si comparamos mes a mes (junio 2020-junio 2019) *
¿Cuál fue el mes cuya diferencia entre ingresos y egresos es mayor? [Ventas (Precio * Cantidad) - Compras (Precio * Cantidad) – Gastos]. Respuesta ejemplo 1-Enero
13) Del total de clientes que realizaron compras en 2019 ¿Qué porcentaje lo hizo también en 2020?

 *
14) La ganancia neta por producto es las ventas menos las compras (Ganancia = Venta - Compra) ¿Cuál es el tipo de producto con mayor ganancia neta en 2020?

 *
15) ¿Cuál es el código de empleado del empleado que mayor comisión obtuvo en diciembre del año 2020?

 *
16) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = Venta - Gasto) ¿Cuál es la sucursal con mayor ganancia neta en 2020 en la provincia de Córdoba si además quitamos los pagos por comisiones?

 *


*/

USE henry_checkpoint_m3;

-- 8) La ganancia neta por sucursal
-- es las ventas menos los gastos (Ganancia = Venta - Gasto)
-- ¿Cuál es la sucursal con mayor ganancia neta en 2020?

SELECT * FROM venta limit 10;



-- ventas up x sucursal ord de mejor a mayor para el 2020
SELECT v.IdSucursal, 
		YEAR(v.Fecha_Entrega) as año_venta, 
        SUM((v.Precio * v.Cantidad)) AS venta_en_el_año,
        sum(g.Monto) as gasto,
        (SUM((v.Precio * v.Cantidad)) - sum(g.Monto)) as ganancia_neta
FROM venta v join gasto g on (v.IdSucursal = g.IdSucursal)
WHERE YEAR(v.Fecha_Entrega) = 2020 
GROUP BY v.IdSucursal, year(v.Fecha_Entrega)
HAVING SUM((v.Precio * v.Cantidad)) > 0
ORDER BY ganancia_neta DESC
LIMIT 10;


/* calculos extras:
-- ahora la parte de gasto

SELECT year(g.Fecha),
		
FROM gasto g
GROUP BY IdSucursal, year(Fecha)
limit 10;
*/





-- 9) Del total de clientes que realizaron compras en 2020 
-- ¿Qué porcentaje lo hizo sólo en una única sucursal?

/* 
-- cientes diferentes que compraron el 2020
Select @cant_client_2020 :=(
SELECT count(distinct IdCliente) as cantidad_clientes
from venta v 
where year(v.Fecha) = 2020);

-- cant clientes que lo hizo solo en una uniaca sucursal...:
select @respuesta2 :=(
select count(*) 
		from(
		select Distinct IdCliente
		from venta 
		where year(Fecha) = 2020
		group by IdCliente
		having count(distinct IdSucursal) = 1
) respuesta2);


select @respuesta2 / @cant_client_2020 * 100 ; -- me quiero mataaa me daba bien!
*/

-- 9) Del total de clientes que realizaron compras en 2020 
-- ¿Qué porcentaje lo hizo sólo en una única sucursal?

-- cientes diferentes que compraron el 2020
Select @cant_client_2020 :=(
SELECT count(distinct IdCliente) as cantidad_clientes
from venta v 
where year(v.Fecha) = 2020);

-- cant clientes que lo hizo solo en una uniaca sucursal...:
select @respuesta2 :=(
select count(*) 
		from(
		select Distinct IdCliente
		from venta 
		where year(Fecha) = 2020
		group by IdCliente
		having count(distinct IdSucursal) = 1
) respuesta2);

select @respuesta2 / @cant_client_2020 * 100 ; -- me quiero mataaa me daba bien!




-- 10) Del total de clientes que realizaron compras en 2020 
-- ¿Qué porcentaje no había realizado compras en 2019?

-- cant total de clientes 2020:
select  @cant_client_2020;



-- clientes que compraron el 2020
select distinct v.IdCliente,
		year(v.Fecha)
from venta v
where year(v.Fecha) = 2020 and not exists (
								-- clientes que compraron el 2019
								select distinct v.IdCliente,
										year(v.Fecha)
								from venta v
								where year(v.Fecha) = 2019);



-- clientes que compraron el 2019
select distinct v.IdCliente,
		year(v.Fecha)
from venta v
where year(v.Fecha) = 2019
limit 10;



select distinct v.IdCliente from(

-- clientes que compraron el 2020
select distinct v.IdCliente
from venta v
where year(v.Fecha) = 2020)  and Not Exists (-- clientes que compraron el 2019
select distinct v.IdCliente
from venta v
where year(v.Fecha) = 2019
limit 10;);



-- clientes que compraron el 2019
select distinct v.IdCliente
from venta v
where year(v.Fecha) = 2019
limit 10;


-- chat:
select @clientes_2020_sin_compras2019 := (SELECT COUNT(DISTINCT v2020.IdCliente) AS clientes_2020_sin_compras_2019
FROM venta v2020 
WHERE YEAR(v2020.Fecha) = 2020 
AND NOT EXISTS (
    SELECT 1
    FROM venta v2019
    WHERE v2019.IdCliente = v2020.IdCliente
    AND YEAR(v2019.Fecha) = 2019
));


-- 10) Del total de clientes que realizaron compras en 2020 
-- ¿Qué porcentaje no había realizado compras en 2019?

-- cant total de clientes 2020:
select  @clientes_2020_sin_compras2019 / @cant_client_2020 ;
-- gooodd!



-- 11) Del total de clientes que realizaron compras en 2019 
-- ¿Qué porcentaje lo hizo sólo en una única sucursal?

select @clientes_que_compraron_el_2019 :=(
-- clientes que compraron el 2019
select count(distinct v2019.IdCliente) 
from venta v2019
where year(v2019.Fecha) = 2019
)as clientes_que_compraron_el_2019; 

select @clientes_unica_sucursal_2019 := (
select count(*) 
from(
	select distinct v2019.IdCliente 
	from venta v2019
	where year(v2019.Fecha) = 2019
	group by v2019.IdCliente 
	having count(distinct v2019.IdSucursal) = 1
) as clientes_unica_sucursal_2019);

 select (@clientes_unica_sucursal_2019 / @clientes_que_compraron_el_2019) * 100;


/*12) A partir de los datos de las Ventas, 
								   Compras y 
								   Gastos 
 de los años 2020 y 2019,
 si comparamos mes a mes (junio 2020-junio 2019)...
 
¿Cuál fue el mes cuya diferencia entre ingresos y egresos es mayor? 
[Ventas (Precio * Cantidad) - Compras (Precio * Cantidad) – Gastos]. 
Respuesta ejemplo 1-Enero
*/

SELECT @junio_2020 := (
select  
        --  ingreso del periodo (venta - compra - gasto) 
        ((sum(v.Precio * v.Cantidad)) - (sum(c.Precio * c.Cantidad)) - (sum(g.Monto))) as ingreso_del_periodo
from venta v 
join compra c on ((month(v.Fecha_Entrega) = month(c.Fecha)) 
					and (year(v.Fecha_Entrega) = year(c.Fecha)))
join gasto g on ((month(v.Fecha_Entrega) = month(g.Fecha)) 
					and (year(v.Fecha_Entrega) = year(g.Fecha)))
where month(v.Fecha_Entrega) = 06 and year(v.Fecha_Entrega) = 2020 and month(c.Fecha) = 06 and year(c.Fecha)
group by month(v.Fecha_Entrega), year(v.Fecha_Entrega), month(c.Fecha), year(c.Fecha),  month(g.Fecha), year(g.Fecha) );

-- el otro periodo...

SELECT @junio_2019 := (
select  
        --  ingreso del periodo (venta - compra - gasto) 
        ((sum(v.Precio * v.Cantidad)) - (sum(c.Precio * c.Cantidad)) - (sum(g.Monto))) as ingreso_del_periodo
from venta v 
join compra c on ((month(v.Fecha_Entrega) = month(c.Fecha)) 
					and (year(v.Fecha_Entrega) = year(c.Fecha)))
join gasto g on ((month(v.Fecha_Entrega) = month(g.Fecha)) 
					and (year(v.Fecha_Entrega) = year(g.Fecha)))
where month(v.Fecha_Entrega) = 06 and year(v.Fecha_Entrega) = 2019 and month(c.Fecha) = 06 and year(c.Fecha)
group by month(v.Fecha_Entrega), year(v.Fecha_Entrega), month(c.Fecha), year(c.Fecha),  month(g.Fecha), year(g.Fecha) );

select (@junio_2020 - @junio_2019);



/*13) Del total de clientes que realizaron compras en 2019 
¿Qué porcentaje lo hizo también en 2020?*/


select count(distinct v2019.IdCliente) 
from venta v2019
where year(v2019.Fecha) = 2019 and exists(
							select distinct v2019.IdCliente 
							from venta v2019
							where year(v2019.Fecha) = 2019 and EXISTS (
																select distinct v2020.IdCliente 
																from venta v2020
																where year(v2020.Fecha) = 2020));




-- clientes que compraron el 2020
select count(distinct v2020.IdCliente) 
from venta v2020
where year(v2020.Fecha) = 2020;

-- clientes que compraron el 2019
select count(distinct v2019.IdCliente) 
from venta v2019
where year(v2019.Fecha) = 2019 and year(v2020.Fecha); --falla



select @clientes_que_compraron_el_2019 :=(
-- clientes que compraron el 2019
select count(distinct v2019.IdCliente) 
from venta v2019
where year(v2019.Fecha) = 2019 
)as clientes_que_compraron_el_2019; 

select (@clientes_que_compraron_el_2019_y_2020 / @clientes_que_compraron_el_2019) *100;



select count(distinct v2019.IdCliente) 
from venta v2019
where year(v2019.Fecha) = 2019 and EXISTS (
						select distinct v2020.IdCliente 
						from venta v2020
						where year(v2020.Fecha) = 2020);






-- CHAT:
SELECT COUNT(DISTINCT CASE WHEN YEAR(v2019.Fecha) = 2019 THEN v2019.IdCliente END) AS clientes_2019,
       COUNT(DISTINCT CASE WHEN YEAR(v2020.Fecha) = 2020 THEN v2020.IdCliente END) AS clientes_2020,
       COUNT(DISTINCT CASE WHEN YEAR(v2019.Fecha) IN (2019, 2020) THEN v2019.IdCliente END) AS clientes_2019_y_2020,
       (COUNT(DISTINCT CASE WHEN YEAR(v2019.Fecha) IN (2019, 2020) THEN v2019.IdCliente END) / COUNT(DISTINCT CASE WHEN YEAR(v2019.Fecha) = 2019 THEN v2019.IdCliente END) * 100 ) AS porcentaje
FROM venta v2019
INNER JOIN venta v2020 ON v2019.IdCliente = v2020.IdCliente
WHERE YEAR(v2019.Fecha) = 2019;




-- 14) La ganancia neta por producto es las ventas menos las compras 
-- (Ganancia = Venta - Compra)
-- ¿Cuál es el tipo de producto con mayor ganancia neta en 2020?

SELECT * FROM compra LIMIT 10;

SELECT  v.IdProducto, year(v.Fecha),
		(sum((v.precio * v.cantidad)) - sum((c.precio * c.cantidad))) as Ganancia_prod
        FROM venta v join compra c on (v.IdProducto = c.IdProducto)
group by IdProducto
having year(v.Fecha) = 2020
order by  Ganancia_prod desc;


SELECT  v.IdProducto, 
        ((SUM(v.precio * v.cantidad) - SUM(c.precio * c.cantidad)) / SUM((c.precio * c.cantidad))) AS Ganancia_prod
FROM venta v 
JOIN compra c ON (v.IdProducto = c.IdProducto)
WHERE YEAR(v.Fecha) = 2020
GROUP BY v.IdProducto
ORDER BY Ganancia_prod DESC
LIMIT 1;








-- 15) ¿Cuál es el código de empleado del empleado 
-- que mayor comisión obtuvo en diciembre del año 2020?

select v.IdEmpleado,
		sum(v.Precio * v.Cantidad) as ventas_tot_x_empl,
        month(v.Fecha),
        YEAR(v.Fecha)
from venta v 
where month(v.Fecha) = 12 and year(v.Fecha) = 2020
group by v.IdEmpleado, month(v.Fecha), YEAR(v.Fecha)
order by ventas_tot_x_empl desc
limit 10;

-- 16) La ganancia neta por sucursal es las ventas menos los gastos (Ganancia = Venta - Gasto)
--  ¿Cuál es la sucursal con mayor ganancia neta en 2020
--  en la provincia de Córdoba si además quitamos los pagos por comisiones?

SELECT v.IdSucursal, s.Sucursal,
       SUM(v.Precio * v.Cantidad) AS venta,
       SUM(g.Monto) AS gasto,
       SUM(v.Precio * v.Cantidad) - SUM(g.Monto) AS ganancia
FROM venta v
JOIN gasto g ON v.IdSucursal = g.IdSucursal
JOIN sucursal s on v.IdSucursal = s.IdSucursal
WHERE YEAR(v.Fecha) = 2020 and s.sucursal like '%cord%' and g.IdTipoGasto <> 4
GROUP BY v.IdSucursal
order by ganancia desc
limit 10;




-- 14) La ganancia neta por producto es las ventas menos las compras 
-- (Ganancia = Venta - Compra)
-- ¿Cuál es el tipo de producto con mayor ganancia neta en 2020?
--  de nuevo la 14

SELECT p.IdTipoProducto, tp.TipoProducto,
       SUM(v.Precio * v.Cantidad - c.Precio * c.Cantidad) AS ganancia_neta
FROM venta v 
JOIN compra c ON v.IdProducto = c.IdProducto
JOIN producto p ON v.IdProducto = p.IdProducto
join tipo_producto tp on p.IdTipoProducto = tp.IdTipoProducto
WHERE YEAR(v.Fecha_Entrega) = 2020 AND YEAR(c.Fecha) = 2020
GROUP BY p.IdTipoProducto
ORDER BY ganancia_neta DESC
LIMIT 20
;

