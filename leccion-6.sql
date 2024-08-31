-- PARTE 1 - SELECT: FUNCIONAMIENTO BÁSICO
-- =================================================

-- Mostrar todo el contenido de la tabla "ordenes"
SELECT * 
FROM public.ordenes;

-- Mostrar sólo las 10 primeras filas de la tabla "ordenes"
SELECT * 
FROM ordenes
LIMIT 10;

/* Seleccionar únicamente las columnas "cliente_id", "orden_estado"
   y "orden_entregada_cliente" de la tabla "ordenes"*/
SELECT cliente_id, orden_estado, orden_entregada_cliente 
FROM ordenes;

-- Igual al caso anterior pero mostrar únicamente las 10 primeras filas
SELECT cliente_id, orden_estado, orden_entregada_cliente 
FROM ordenes 
LIMIT 10;

-- PARTE 2 - SELECT + ORDER BY (ORDENAR LOS RESULTADOS)
-- =================================================

/* Consultar “ordenes_pagos” extrayendo únicamente el id de la orden y el monto
  (pago_valor) pero mostrar los resultados ordenados de mayor pago a menor*/

SELECT  orden_id, 
        pago_valor
FROM    ordenes_pagos
ORDER BY pago_valor;

-- El mismo ejemplo anterior pero en orden descendente
SELECT  orden_id,
        pago_valor
FROM ordenes_pagos
ORDER BY pago_valor DESC;

/* Consultar la tabla clientes, extraer únicamente cliente_id y cliente_ciudad
   y ordenar de manera ascendente (A-Z) por ciudad*/
SELECT  cliente_id, 
        cliente_ciudad
FROM clientes
ORDER BY cliente_ciudad;

/* Consultar la tabla ordenes y extraer la fecha de compra (orden_compra) así 
   como el id (orden_id) y ordenar de la fecha más reciente a la más antigua*/
SELECT  orden_id,
        orden_compra
FROM ordenes
ORDER BY orden_compra DESC;

-- PARTE 3 - SELECT + Y ALGUNAS OPERACIONES BÁSICAS
-- =================================================

-- 3.1 CONTEO
-- ----------------------

-- Determinar cuántos registros (filas) se tienen en total en "ordenes"
SELECT COUNT(*)
FROM ordenes;

-- Contar cuántas ciudades tenemos en "clientes"
SELECT COUNT(cliente_ciudad)
FROM clientes;

-- Contar cuántas DIFERENTES ciudades tenemos en clientes
SELECT COUNT(DISTINCT cliente_ciudad)
FROM clientes;

-- 3.2 SUMA DE COLUMNAS
-- ----------------------

/* De la tabla “ordenes_items” extraer las columnas orden_id, precio y 
   valor_envio y calcular el precio total (la suma de precio y valor_envio)*/
SELECT  orden_id, 
        precio, 
        valor_envio, 
        precio+valor_envio
FROM ordenes_items;

/* En el caso anterior la columna resultante no tiene un nombre. Repetir
   la consulta pero ahora llamar a la columna "precio_total"*/
SELECT  orden_id,
        precio, 
        valor_envio,
        precio+valor_envio AS precio_total
FROM ordenes_items;

-- 3.3 REDONDEO
-- ----------------------

-- Repetir el ejemplo anterior pero redondear el precio a 1 decimal
SELECT  orden_id, 
        precio, 
        valor_envio, 
        ROUND((precio+valor_envio), 1) AS precio_total
FROM ordenes_items;

/* Al ejecutar lo anterior aparece un error debido a que "precio" y "valor_envio"
   son de tipo "real" y ROUND acepta datos tipo "numeric". Corregir usando casting*/
SELECT  orden_id, 
        precio, 
        valor_envio, 
        ROUND((precio+valor_envio::)numeric, 1) AS precio_total
FROM ordenes_items;

-- 3.4 CONCATENAR STRINGS
-- ----------------------

/* Crear una consulta que tome de la tabla clientes cliente_id, cliente_ciudad
   y cliente_estado y genere a la salida una nueva columna “cliente_ciud_est”
   que sea el resultado de combinar la ciudad y el estado*/
SELECT  cliente_id,
        cliente_ciudad,
        cliente_estado,
        CONCAT(cliente_ciudad, “-”, cliente_estado) AS cliente_ciud_est
FROM clientes;

/* Lo anterior arroja un error porque estamos usando comillas dobles y en
   postgres se deben usar comillas simples. Corregir*/
SELECT  cliente_id,
        cliente_ciudad,
        cliente_estado,
        CONCAT(cliente_ciudad, '-', cliente_estado) AS cliente_ciud_est
FROM clientes;

/* Repetir el ejemplo anterior pero ahora la columna resultante debe contener
   caracteres en mayúscula*/
SELECT  cliente_id,
        cliente_ciudad,
        cliente_estado,
        UPPER(CONCAT(cliente_ciudad, '-', cliente_estado)) AS cliente_ciud_est
FROM clientes;