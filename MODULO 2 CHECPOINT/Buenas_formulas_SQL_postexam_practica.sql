USE checkpoint_m2;
SELECT *
FROM venta;

SELECT v.IdProducto,sum(v.Precio * v.Cantidad) AS vent, 
	Concepto AS concept,
	prod.Tipo AS tipo,
    chanel.IdCanal as canal,
	chanel.Canal as canal_name
FROM venta v
INNER JOIN producto prod ON (V.IdProducto = prod.IdProducto)
INNER JOIN canal_venta chanel ON (v.IdCanal = chanel.IdCanal)
GROUP BY prod.IdProducto, chanel.IdCanal, canal_name
ORDER BY vent DESC
LIMIT 10;


SELECT *,
	round(sum(v.Precio * v.Cantidad)) AS venta
FROM venta v
INNER JOIN producto prod ON (v.IdProducto = prod.IdProducto)
INNER JOIN canal_venta chanel ON (v.IdCanal = chanel.IdCanal)
GROUP BY prod.IdProducto, v.IdVenta
ORDER BY sum(v.Precio * v.Cantidad) DESC
LIMIT 0, 10000;