-- PARTE 1 - WHERE: FILTRADO BÁSICO
-- =================================================

/* Seleccionar de la tabla producto sólo aquellos que tengan 4 o más fotos 
   (columna “producto_nro_fotos”). Retornar “producto_id”, “producto_categoria”
   y producto_nro_fotos”)*/
SELECT producto_id, producto_categoria, producto_nro_fotos
FROM productos
WHERE producto_nro_fotos >= 4;

/* Seleccionar de la tabla "clientes" sólo aquellos que estén en el
   estado de Sao Paulo (SP). Retornar "cliente_id", "cliente_ciudad"
   y "cliente_estado"*/
SELECT cliente_id, cliente_ciudad, cliente_estado
FROM clientes
WHERE cliente_estado = 'SP';

-- El mismo ejemplo anterior pero mostrar los 5 primeros registros
SELECT cliente_id, cliente_ciudad, cliente_estado
FROM clientes
WHERE cliente_estado = 'SP'
LIMIT 5;

/* Seleccionar de la tabla "ordenes_items" sólo aquellas con un precio
   superior a 100.0. Retornar "orden_id", "producto_id" y "precio"*/
SELECT orden_id, producto_id, precio
FROM ordenes_items
WHERE precio >= 100.0;

-- El mismo ejemplo anterior pero ordenar de manera descendente por precio
SELECT orden_id, producto_id, precio
FROM ordenes_items
WHERE precio >= 100.0
ORDER BY precio DESC;

/* Y el mismo ejemplo anterior pero imprimir en pantalla sólo los 10 primeros
   registros*/
SELECT orden_id, producto_id, precio
FROM ordenes_items
WHERE precio >= 100.0
ORDER BY precio DESC
LIMIT 10;

-- PARTE 2 - WHERE: FILTRADO AVANZADO
-- =================================================

-- 2.1 MÚLTIPLES CONDICIONES + UNA COLUMNA
-- ----------------------

-- Mostrar categorias ÚNICAS de productos
SELECT DISTINCT producto_categoria
FROM productos;

/* Y ahora seleccionar sólo los productos categoría "musica"
   y que contengan 5 fotos o más*. Retornar producto_id, 
   producto_categoria y producto_nro_fotos*/
SELECT   producto_id,
         producto_categoria,
         producto_nro_fotos
FROM productos
WHERE producto_categoria = 'musica'
      AND producto_nro_fotos >=5;

/* Seleccionar sólo los productos que pertenezcan a las categorías
   "musica" o "bebes". Retornar producto_id, producto_categoria y 
   producto_nro_fotos. Organizar además de manera descendente 
   por número de fotos*/
SELECT   producto_id,
         producto_categoria,
         producto_nro_fotos
FROM productos
WHERE producto_categoria = 'musica'
      OR producto_categoria = 'bebes'
ORDER BY producto_nro_fotos DESC;

-- Modificar el OR en la consulta anterior por AND y verificar qué sucede
SELECT   producto_id,
         producto_categoria,
         producto_nro_fotos
FROM productos
WHERE producto_categoria = 'musica'
      AND producto_categoria = 'bebes'
ORDER BY producto_nro_fotos DESC;
-- !Desde luego no se obtiene ningún registro pues no se cumplen las dos condiciones

-- Seleccionar sólo los productos DIFERENTES de "flores"
SELECT   producto_id,
         producto_categoria,
         producto_nro_fotos
FROM productos
WHERE producto_categoria != 'flores';

-- 2.2. MÚLTIPLES CONDICIONES + MÚLTIPLES COLUMNAS
-- ----------------------

-- Mostrar los diferentes estados de una orden
SELECT   DISTINCT orden_estado
FROM ordenes;

-- Mostrar las fechas de compra en orden ascendente
SELECT   orden_compra
FROM ordenes
ORDER BY orden_compra;

/* Y ahora filtrar únicamente las ordenes cuyo estado sea "approved" y
   cuya fecha de compra sea anterior a 2016-10-04 a las 18 horas. Retornar order_id, 
   orden_compra y orden_estado*/
SELECT   orden_id,
         orden_compra,
         orden_estado
FROM ordenes
WHERE orden_estado = 'approved'
      AND orden_compra <= '2016-10-04 18:00:00'
ORDER BY orden_compra;
-- ¡No hay ordenes que cumplan el criterio!

-- Repetir lo anterior pero con estado "delivered"
SELECT   orden_id,
         orden_compra,
         orden_estado
FROM ordenes
WHERE orden_estado = 'delivered'
      AND orden_compra <= '2016-10-04 18:00:00'
ORDER BY orden_compra;

-- PARTE 3 - WHERE: OTRAS FORMAS DE FILTRAR
-- =================================================

-- 3.1. USANDO "BETWEEN"
-- Permite determinar si un valor está dentro de un rango específico
-- ----------------------

/* Extraer ordenes generadas después del 2016-09-30 (0 horas) y antes
   del 2016-10-02 (23:59 horas)*/
SELECT   orden_id,
         orden_compra,
         orden_estado
FROM ordenes
WHERE orden_compra BETWEEN '2016-09-30 00:00:00' and '2016-10-03 23:59:00'
ORDER BY orden_compra;

/* Modificar el "query" anterior para consultar además considerando
   el estado "canceled"*/

SELECT   orden_id,
         orden_compra,
         orden_estado
FROM ordenes
WHERE orden_compra BETWEEN '2016-09-30 00:00:00' and '2016-10-03 23:59:00'
   AND orden_estado = 'canceled'
ORDER BY orden_compra;

-- 3.2. USANDO "IN"
-- Permite determinar si un valor está dentro de un listado específico
-- ----------------------

-- Obtener el listado de diferentes estados en la tabla "clientes"
SELECT DISTINCT cliente_estado
FROM clientes;

-- Y ahora filtrar únicamente los clientes pertenecientes a los estados MG y CE
SELECT   cliente_id,
         cliente_estado
FROM clientes
WHERE cliente_estado IN ('MG', 'CE');

-- 3.3. USANDO "LIKE"
-- Permite consultar strings pero sin necesidad de hacer búsquedas exactas
-- ----------------------

-- Obtener el listado de diferentes ciudades en la tabla "geolocalizacion"
SELECT DISTINCT ciudad
FROM geolocalizacion;

/* Y supongamos que queremos buscar la ciudad "cabeceiras do piaui" pero no
   sabemos escribirla correctamente, así que podemos usar LIKE y probar con
   cabec% o cabec%piau%*/
SELECT ciudad
FROM geolocalizacion
WHERE ciudad LIKE 'cabec%';

-- O también
SELECT ciudad
FROM geolocalizacion
WHERE ciudad LIKE 'cabec%pia%';

-- 3.3. USANDO "ISNULL"
-- Permite verificar si hay datos faltantes (celdas vacías)
-- ----------------------

-- Verificar columnas en la tabla ordenes_reviews
\d ordenes_reviews

/* Seleccionar columnas review_id y review_titulo y mostrar sólo
   los registros donde review_titulo esté vacío*/
SELECT review_id, review_titulo
FROM ordenes_reviews
WHERE review_titulo ISNULL;