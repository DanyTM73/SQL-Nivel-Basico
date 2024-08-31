-- PARTE 1 - CASE: SINTAXIS BÁSICA
-- =================================================

-- Seleccionar columnas con select
SELECT col1, col2, ...
   -- Y ahora usar sentencias CASE
   CASE
      WHEN [condicion_1]
         THEN [haga_esto]
      WHEN [condicion_2]
         THEN [haga_esto]
      ELSE [haga_esto]
   -- Terminar el CASE y almacenar el resultado en "nueva_columna"
   END AS nueva_columna
-- Y por último especificar la tabla
FROM nombre_tabla;

/* Ejemplo básico: seleccionar tabla "ordenes_items" y crear
   la columna categórica "cat_precio" asignando estas categorías:
   - precio_bajo: si "precio" <= 100
   - precio_medio: si "precio" > 100 y <= 1000
   - precio_alto: si "precio" > 1000
*/

SELECT orden_id, precio,
   CASE 
   WHEN precio <= 100
      THEN 'precio_bajo'
   WHEN precio > 100 AND precio <=1000
      THEN 'precio_medio'
   ELSE 'precio_alto'
   END AS cat_precio
FROM ordenes_items;

/* Repetir lo anterior pero organizando por precios de forma descendente*/
SELECT orden_id, precio,
   CASE 
   WHEN precio <= 100
      THEN 'precio_bajo'
   WHEN precio > 100 AND precio <=1000
      THEN 'precio_medio'
   ELSE 'precio_alto'
   END AS cat_precio
FROM ordenes_items ORDER BY precio DESC;

-- PARTE 2a - CASE: CODIFICACIÓN BINARIA
-- =================================================

-- Explorar categorías de productos en la tabla "productos"
SELECT DISTINCT producto_categoria FROM productos;

/* Crear la columna "nueva_categoria" con estas dos categorías:
   - cat_entretenimiento si la categoría del producto es cualquiera de estas:
     'livros_importados', 'livros_tecnicos', 'dvds_blu_ray', 'livros_interesse_geral',
     'musica', 'consoles_games', 'pc_gamer','cds_dvds_musicais'
   - cat_otros si la categoría es diferente de cualquiera de las anteriores
*/

SELECT producto_id, producto_categoria,
   CASE
   WHEN producto_categoria IN ('livros_importados', 'livros_tecnicos', 'dvds_blu_ray',
                               'livros_interesse_geral', 'musica', 'consoles_games', 
                               'pc_gamer','cds_dvds_musicais')
      THEN 'cat_entretenimiento'
   ELSE 'cat_otros'
   END AS nueva_categoria
FROM productos ORDER BY nueva_categoria;

/* Hacer algo similar a lo anterior, pero en lugar de crear categorías "cat_entretenimiento"
   y "cat_otros" crear las categorías 1 (para entretenimiento) y 0 (para otros)
*/   

SELECT producto_id, producto_categoria,
   CASE
   WHEN producto_categoria IN ('livros_importados', 'livros_tecnicos', 'dvds_blu_ray',
                               'livros_interesse_geral', 'musica', 'consoles_games', 
                               'pc_gamer','cds_dvds_musicais')
      THEN 1
      ELSE 0
   END AS nueva_categoria
FROM productos ORDER BY producto_id;

-- PARTE 2b - CASE: CODIFICACIÓN MÚLTIPLES CATEGORÍAS
-- =================================================

/* Algo similar al ejemplo anterior pero con tres categorías:
   - cat_entretenimiento: 'livros_importados', 'livros_tecnicos', 'dvds_blu_ray',
                        'livros_interesse_geral', 'musica', 'consoles_games', 
                        'pc_gamer','cds_dvds_musicais'
   - cat_hogar: 'eletrodomesticos', 'cama_mesa_banho', 'la_cuisine', 'moveis_quarto', 
             'moveis_sala', 'moveis_decoracao', 'portateis_cozinha_e_preparadores_de_alimentos'
   - cat_otros: resto */

SELECT producto_id, producto_categoria,
   CASE
   WHEN producto_categoria IN ('livros_importados', 'livros_tecnicos', 'dvds_blu_ray',
                               'livros_interesse_geral', 'musica', 'consoles_games', 
                               'pc_gamer','cds_dvds_musicais')
      THEN 'cat_entretenimiento'
   WHEN producto_categoria IN ('eletrodomesticos', 'cama_mesa_banho', 'la_cuisine', 
                               'moveis_quarto', 'moveis_sala', 'moveis_decoracao',
                               'portateis_cozinha_e_preparadores_de_alimentos')
      THEN 'cat_hogar'
   ELSE 'cat_otros'
   END AS nueva_categoria
FROM productos ORDER BY producto_id;

/* El mismo ejemplo anterior pero usando codificación one-hot:
   - cat_entretenimiento: 1, 0, 0
   - cat_hogar; 0, 1, 0
   - cat_otros: 0, 0, 1 */

SELECT producto_id, producto_categoria,
   -- Primer CASE, primera columna
   CASE
   WHEN producto_categoria IN ('livros_importados', 'livros_tecnicos', 'dvds_blu_ray',
                               'livros_interesse_geral', 'musica', 'consoles_games', 
                               'pc_gamer','cds_dvds_musicais')
      THEN 1
      ELSE 0
   END AS cat_entretenimiento,

   -- Segundo CASE, segunda columna
   CASE
   WHEN producto_categoria IN ('eletrodomesticos', 'cama_mesa_banho', 'la_cuisine', 
                               'moveis_quarto', 'moveis_sala', 'moveis_decoracao',
                               'portateis_cozinha_e_preparadores_de_alimentos')
      THEN 1
      ELSE 0
   END AS cat_hogar,

   -- Tercer CASE, tercera columna
   CASE
   WHEN producto_categoria NOT IN ('livros_importados', 'livros_tecnicos', 'dvds_blu_ray',
                               'livros_interesse_geral', 'musica', 'consoles_games', 
                               'pc_gamer','cds_dvds_musicais')
        AND producto_categoria NOT IN ('eletrodomesticos', 'cama_mesa_banho', 'la_cuisine', 
                               'moveis_quarto', 'moveis_sala', 'moveis_decoracao',
                               'portateis_cozinha_e_preparadores_de_alimentos')
      THEN 1
      ELSE 0
   END AS cat_otros

FROM productos ORDER BY producto_id;