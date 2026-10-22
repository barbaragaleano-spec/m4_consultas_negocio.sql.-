USE Ventas_Tech_DB;

SELECT*FROM VENTAS;

-- Consulta 1: Resumen ejecutivo mensual

SELECT
 MONTH(fecha_venta) AS mes,
 SUM(cantidad * precio_unitario) AS total_facturado,
 COUNT(*) AS cantidad_pedidos,
 AVG (cantidad * precio_unitario) AS ticket_promedio
 FROM ventas
 GROUP BY MONTH(fecha_venta);

 -- Consulta 2 — Ranking de productos

 SELECT TOP 5
 id_producto,
 SUM(cantidad) AS unidades_vendidas,
 SUM(cantidad * precio_unitario) AS total_facturado
 FROM ventas
 GROUP BY id_producto
 ORDER BY SUM(cantidad * precio_unitario) DESC;

  -- Consulta 3 — Clientes recurrentes 

  SELECT
  id_cliente,
  COUNT(*) AS cantidad_pedidos,
  SUM(cantidad * precio_unitario) AS total_gastado
  FROM ventas
  GROUP BY id_cliente
  HAVING COUNT(*) > 1;

-- Consulta 4 — Meses por encima/por debajo del promedio

WITH facturacion_mensual AS (
 SELECT
 MONTH(fecha_venta) AS mes,
 SUM(cantidad * precio_unitario) AS total_facturado
 FROM ventas
 GROUP BY MONTH(fecha_venta)
)

SELECT
    mes,
    total_facturado,

CASE
WHEN total_facturado > (
SELECT AVG(total_facturado)
FROM facturacion_mensual
) THEN 'Por encima'
ELSE 'Por debajo'
END AS comparacion_promedio
FROM facturacion_mensual
ORDER BY mes;


--Bloque de cierre 

--Hallazgo 1: Productos. El producto id_producto 2 fue el que generó mayor facturación, con un total de $364.00 y 13 unidades vendidas.
--Hallazgo 2: Clientes recurrentes. El cliente id 1 realizó 2 pedidos y gastó un total de $2640.00.
--Hallazgo 3: Facturación mensual. El mes 3 registró un total facturado $6444.00, y quedó por debajo del promedio mensual






