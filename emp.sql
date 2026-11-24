-- Si ya tienes las tablas con sus datos, empieza en el ejercicio 01. 

-- Si comienzas desde cero, ejecuta primero la preparación. 

 

-- Ejecutar una sola vez en un esquema de práctica vacío. 

-- Crea la tabla clientes. 

CREATE TABLE clientes ( 

    id_cliente NUMBER(4) CONSTRAINT pk_clientes PRIMARY KEY, 

    nombre VARCHAR2(80 CHAR) NOT NULL, 

    ciudad VARCHAR2(40 CHAR) NOT NULL, 

    categoria VARCHAR2(15 CHAR) NOT NULL 

); 

-- Crea la tabla pedidos. 

CREATE TABLE pedidos ( 

    id_pedido NUMBER(5) CONSTRAINT pk_pedidos PRIMARY KEY, 

    id_cliente NUMBER(4) NOT NULL, 

    fecha_pedido DATE NOT NULL, 

    estado VARCHAR2(15 CHAR) NOT NULL, 

    total NUMBER(10,2) NOT NULL, 

    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente), 

    CONSTRAINT ck_pedidos_total CHECK (total > 0) 

); 

-- Crea la tabla pagos. 

CREATE TABLE pagos ( 

    id_pago NUMBER(5) CONSTRAINT pk_pagos PRIMARY KEY, 

    id_pedido NUMBER(5) NOT NULL, 

    fecha_pago DATE NOT NULL, 

    medio_pago VARCHAR2(20 CHAR) NOT NULL, 

    monto NUMBER(10,2) NOT NULL, 

    CONSTRAINT fk_pagos_pedidos FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido), 

    CONSTRAINT ck_pagos_monto CHECK (monto > 0) 

); 

 

INSERT INTO clientes VALUES (1,'Ana Torres','Santiago','ORO'); 

INSERT INTO clientes VALUES (2,'Bruno Díaz','Valparaíso','PLATA'); 

INSERT INTO clientes VALUES (3,'Camila Rojas','Santiago','ORO'); 

INSERT INTO clientes VALUES (4,'Diego Pérez','Concepción','BRONCE'); 

INSERT INTO clientes VALUES (5,'Elena Muñoz','La Serena','PLATA'); 

INSERT INTO clientes VALUES (6,'Felipe Soto','Santiago','BRONCE'); 

INSERT INTO clientes VALUES (7,'Gabriela Ruiz','Temuco','ORO'); 

INSERT INTO clientes VALUES (8,'Héctor Silva','Valparaíso','PLATA'); 

INSERT INTO clientes VALUES (9,'Isabel Vega','Antofagasta','BRONCE'); 

 

 

INSERT INTO clientes VALUES (10,'Javier Castro','Santiago','PLATA'); 

 

INSERT INTO pedidos VALUES (101,1,DATE '2026-01-05','ENTREGADO',120000); 

INSERT INTO pedidos VALUES (102,1,DATE '2026-02-12','ENTREGADO',80000); 

INSERT INTO pedidos VALUES (103,1,DATE '2026-03-18','PENDIENTE',50000); 

INSERT INTO pedidos VALUES (104,2,DATE '2026-01-14','ENTREGADO',90000); 

INSERT INTO pedidos VALUES (105,2,DATE '2026-04-03','CANCELADO',60000); 

INSERT INTO pedidos VALUES (106,3,DATE '2026-02-10','ENTREGADO',150000); 

INSERT INTO pedidos VALUES (107,3,DATE '2026-05-25','ENTREGADO',110000); 

INSERT INTO pedidos VALUES (108,4,DATE '2026-03-02','PENDIENTE',45000); 

INSERT INTO pedidos VALUES (109,5,DATE '2026-02-22','ENTREGADO',70000); 

INSERT INTO pedidos VALUES (110,5,DATE '2026-06-09','ENTREGADO',130000); 

INSERT INTO pedidos VALUES (111,6,DATE '2026-04-17','PENDIENTE',40000); 

INSERT INTO pedidos VALUES (112,7,DATE '2026-01-30','ENTREGADO',200000); 

INSERT INTO pedidos VALUES (113,7,DATE '2026-06-11','ENTREGADO',95000); 

INSERT INTO pedidos VALUES (114,8,DATE '2026-05-08','ENTREGADO',75000); 

INSERT INTO pedidos VALUES (115,8,DATE '2026-07-01','PENDIENTE',55000); 

INSERT INTO pedidos VALUES (116,2,DATE '2026-06-23','ENTREGADO',140000); 

INSERT INTO pedidos VALUES (117,3,DATE '2026-07-15','PENDIENTE',35000); 

INSERT INTO pedidos VALUES (118,5,DATE '2026-07-20','ENTREGADO',65000); 

 

INSERT INTO pagos VALUES (1001,101,DATE '2026-01-06','TARJETA',70000); 

INSERT INTO pagos VALUES (1002,101,DATE '2026-01-08','TRANSFERENCIA',50000); 

INSERT INTO pagos VALUES (1003,102,DATE '2026-02-13','TARJETA',80000); 

INSERT INTO pagos VALUES (1004,104,DATE '2026-01-15','EFECTIVO',90000); 

INSERT INTO pagos VALUES (1005,106,DATE '2026-02-11','TRANSFERENCIA',100000); 

INSERT INTO pagos VALUES (1006,106,DATE '2026-02-15','TARJETA',50000); 

INSERT INTO pagos VALUES (1007,107,DATE '2026-05-26','TARJETA',110000); 

INSERT INTO pagos VALUES (1008,109,DATE '2026-02-23','EFECTIVO',70000); 

INSERT INTO pagos VALUES (1009,110,DATE '2026-06-10','TRANSFERENCIA',80000); 

INSERT INTO pagos VALUES (1010,110,DATE '2026-06-12','TRANSFERENCIA',50000); 

INSERT INTO pagos VALUES (1011,112,DATE '2026-01-31','TARJETA',120000); 

INSERT INTO pagos VALUES (1012,112,DATE '2026-02-02','TRANSFERENCIA',80000); 

INSERT INTO pagos VALUES (1013,113,DATE '2026-06-12','TARJETA',95000); 

INSERT INTO pagos VALUES (1014,114,DATE '2026-05-09','EFECTIVO',75000); 

INSERT INTO pagos VALUES (1015,116,DATE '2026-06-24','TARJETA',100000); 

INSERT INTO pagos VALUES (1016,116,DATE '2026-06-25','EFECTIVO',40000); 

INSERT INTO pagos VALUES (1017,118,DATE '2026-07-21','TARJETA',65000); 

-- Guarda los registros de práctica. 

COMMIT; 

-- Ejercicio 01 

-- Obtener el nombre y la ciudad de cada cliente, junto con la cantidad total de 

-- pedidos registrados a su nombre. Incluir también a los clientes sin pedidos. 

-- Parte de clientes y conserva a todos con LEFT JOIN. COUNT(p.id_pedido) devuelve 

-- cero si no hay un pedido asociado. 

SELECT c.nombre, c.ciudad, COUNT(p.id_pedido) AS pedidos 

FROM clientes c 

LEFT JOIN pedidos p ON p.id_cliente = c.id_cliente 

GROUP BY c.id_cliente, c.nombre, c.ciudad; 

-- Ejercicio 02 

-- Mostrar el identificador de cada pedido, el nombre del cliente, su estado y el 

-- importe total, únicamente para pedidos de clientes de Santiago. 

-- Une cada pedido con el cliente que lo realizó. Filtra por la ciudad del cliente y 

-- muestra solo sus pedidos. 

SELECT p.id_pedido, c.nombre, p.estado, p.total 

FROM clientes c 

JOIN pedidos p ON p.id_cliente = c.id_cliente 

WHERE c.ciudad = 'Santiago'; 

-- Ejercicio 03 

-- Listar todos los pedidos con su identificador, fecha, total y monto acumulado de 

-- pagos recibidos. Los pedidos sin pagos deben aparecer con monto pagado igual a 

-- cero. 

-- Parte desde pedidos para conservar los impagos. Suma los abonos de cada pedido y 

-- reemplaza por cero un total nulo. 

SELECT p.id_pedido, p.fecha_pedido, p.total, NVL(SUM(a.monto), 0) AS pagado 

FROM pedidos p 

LEFT JOIN pagos a ON a.id_pedido = p.id_pedido 

GROUP BY p.id_pedido, p.fecha_pedido, p.total; 

-- Ejercicio 04 

-- Identificar los clientes que todavía no han realizado pedidos. Mostrar su nombre, 

-- ciudad y categoría. 

-- Para cada cliente, busca una fila con su código en pedidos. Si la búsqueda queda 

-- vacía, NOT EXISTS devuelve verdadero. 

SELECT c.nombre, c.ciudad, c.categoria 

FROM clientes c 

WHERE NOT EXISTS ( 

    SELECT 1 FROM pedidos p WHERE p.id_cliente = c.id_cliente 

); 

-- Ejercicio 05 

-- Mostrar el nombre de cada cliente que tenga al menos dos pedidos, junto con la 

-- cantidad de pedidos y la suma de sus importes. 

-- Agrupa los pedidos de cada cliente. COUNT cuenta sus pedidos, SUM acumula los 

-- importes y HAVING exige al menos dos. 

SELECT c.nombre, COUNT(*) AS pedidos, SUM(p.total) AS importe 

FROM clientes c 

JOIN pedidos p ON p.id_cliente = c.id_cliente 

GROUP BY c.id_cliente, c.nombre 

HAVING COUNT(*) >= 2; 

-- Ejercicio 06 

-- Obtener los clientes cuyo valor total de pedidos sea superior a 180000. Mostrar 

-- nombre y total acumulado. 

-- Suma el importe de todos los pedidos por cliente. Aplica el umbral al total del 

-- grupo usando HAVING. 

SELECT c.nombre, SUM(p.total) AS importe 

FROM clientes c 

JOIN pedidos p ON p.id_cliente = c.id_cliente 

GROUP BY c.id_cliente, c.nombre 

HAVING SUM(p.total) > 180000; 

-- Ejercicio 07 

-- Mostrar los pedidos que registran más de un pago. Incluir el identificador del 

-- pedido, el nombre del cliente, la cantidad de pagos y el monto pagado. 

-- Une cada pedido con sus abonos. Agrupa por pedido, cuenta los pagos y conserva los 

-- pedidos con dos pagos o más. 

SELECT p.id_pedido, c.nombre, COUNT(*) AS pagos, SUM(a.monto) AS pagado 

FROM clientes c 

JOIN pedidos p ON p.id_cliente = c.id_cliente 

JOIN pagos a ON a.id_pedido = p.id_pedido 

GROUP BY p.id_pedido, c.nombre 

HAVING COUNT(*) > 1; 

-- Ejercicio 08 

-- Obtener la cantidad de pedidos y el valor promedio de sus importes para cada 

-- estado. Presentar los estados con un valor promedio superior a 60000. 

-- Cada estado forma un grupo. AVG calcula el importe medio de sus pedidos y HAVING 

-- conserva los promedios que superan 60000. 

SELECT estado, COUNT(*) AS pedidos, AVG(total) AS promedio 

FROM pedidos 

GROUP BY estado 

HAVING AVG(total) > 60000; 

-- Ejercicio 09 

-- Mostrar el nombre, categoría y monto total de pagos realizados para cada cliente. 

-- Incluir también a los clientes sin pagos, con un total de cero. 

-- Las dos uniones externas conservan tanto al cliente sin pedidos como al cliente con 

-- pedidos sin pagos. SUM acumula el dinero recibido. 

SELECT c.nombre, c.categoria, NVL(SUM(a.monto), 0) AS pagado 

FROM clientes c 

LEFT JOIN pedidos p ON p.id_cliente = c.id_cliente 

LEFT JOIN pagos a ON a.id_pedido = p.id_pedido 

GROUP BY c.id_cliente, c.nombre, c.categoria; 

-- Ejercicio 10 

-- Identificar los clientes cuyo total de pedidos supera el promedio del total de 

-- pedidos por cliente, considerando únicamente clientes que hayan realizado al menos 

-- un pedido. 

-- Primero calcula el importe total de pedidos de cada cliente con actividad. Después 

-- compara cada total con el promedio de esos totales. 

WITH totales AS ( 

    SELECT c.id_cliente, c.nombre, SUM(p.total) AS importe 

    FROM clientes c 

    JOIN pedidos p ON p.id_cliente = c.id_cliente 

    GROUP BY c.id_cliente, c.nombre 

) 

SELECT nombre, importe 

FROM totales 

WHERE importe > (SELECT AVG(importe) FROM totales); 

-- Ejercicio 11 

-- Obtener los pedidos cuyo importe sea mayor que el promedio de importes de todos los 

-- pedidos. Mostrar el nombre del cliente y los datos del pedido. 

-- La subconsulta calcula el importe promedio de los 18 pedidos. Se compara cada 

-- pedido individual con esa cifra. 

SELECT c.nombre, p.id_pedido, p.id_cliente, p.fecha_pedido, p.estado, p.total 

FROM clientes c 

JOIN pedidos p ON p.id_cliente = c.id_cliente 

WHERE p.total > (SELECT AVG(total) FROM pedidos); 

-- Ejercicio 12 

-- Indicar los clientes que hayan realizado al menos un pedido que no registre ningún 

-- pago. Mostrar cada cliente una sola vez. 

-- La consulta externa recorre una vez cada cliente. EXISTS busca algún pedido suyo 

-- para el que NOT EXISTS confirme que faltan pagos. 

SELECT c.nombre 

FROM clientes c 

WHERE EXISTS ( 

    SELECT 1 FROM pedidos p 

    WHERE p.id_cliente = c.id_cliente 

      AND NOT EXISTS ( 

          SELECT 1 FROM pagos a WHERE a.id_pedido = p.id_pedido 

      ) 

); 

-- Ejercicio 13 

-- Mostrar por ciudad la cantidad de clientes distintos, la cantidad de pedidos 

-- distintos y el monto total facturado por pedidos. Incluir las ciudades donde no 

-- existen pedidos. 

-- Un cliente puede repetirse por cada pedido. DISTINCT permite contarlo una sola vez 

-- por ciudad. Suma el total una vez por pedido. 

SELECT c.ciudad, COUNT(DISTINCT c.id_cliente) AS clientes, 

       COUNT(DISTINCT p.id_pedido) AS pedidos, NVL(SUM(p.total), 0) AS facturado 

FROM clientes c 

LEFT JOIN pedidos p ON p.id_cliente = c.id_cliente 

GROUP BY c.ciudad; 

-- Ejercicio 14 

-- Mostrar para cada medio de pago la cantidad de pagos, el importe total recaudado y 

-- el importe promedio por pago. Incluir solo medios con recaudación superior a 

-- 200000. 

-- Agrupa por medio de pago. Filtra por recaudación total y calcula el promedio a 

-- partir de los pagos individuales de ese medio. 

SELECT medio_pago, COUNT(*) AS pagos, SUM(monto) AS recaudado, 

       AVG(monto) AS promedio 

FROM pagos 

GROUP BY medio_pago 

HAVING SUM(monto) > 200000; 

-- Ejercicio 15 

-- Obtener los clientes que tengan pedidos en más de un estado diferente. Mostrar 

-- nombre y cantidad de estados distintos registrados. 

-- COUNT(DISTINCT p.estado) cuenta una vez cada estado usado por el cliente. Dos 

-- pedidos entregados cuentan como un solo estado. 

SELECT c.nombre, COUNT(DISTINCT p.estado) AS estados 

FROM clientes c 

JOIN pedidos p ON p.id_cliente = c.id_cliente 

GROUP BY c.id_cliente, c.nombre 

HAVING COUNT(DISTINCT p.estado) > 1; 

-- Ejercicio 16 

-- Listar todos los clientes y la cantidad de pedidos ENTREGADO que tiene cada uno, 

-- incluyendo a quienes no registren pedidos de ese estado. 

-- Coloca el filtro ENTREGADO en la condición ON del LEFT JOIN. Así el cliente sigue 

-- apareciendo aunque tenga cero pedidos entregados. 

SELECT c.nombre, COUNT(p.id_pedido) AS entregados 

FROM clientes c 

LEFT JOIN pedidos p ON p.id_cliente = c.id_cliente 

    AND p.estado = 'ENTREGADO' 

GROUP BY c.id_cliente, c.nombre; 

-- Ejercicio 17 

-- Identificar las categorías de clientes cuyo importe acumulado de pedidos sea mayor 

-- que el importe acumulado de pedidos de la categoría BRONCE. 

-- Calcula primero la suma de BRONCE como referencia. HAVING compara la suma de cada 

-- categoría contra esa cifra. 

SELECT c.categoria, SUM(p.total) AS importe 

FROM clientes c 

JOIN pedidos p ON p.id_cliente = c.id_cliente 

GROUP BY c.categoria 

HAVING SUM(p.total) > ( 

    SELECT NVL(SUM(p2.total), 0) 

    FROM clientes c2 

    JOIN pedidos p2 ON p2.id_cliente = c2.id_cliente 

    WHERE c2.categoria = 'BRONCE' 

); 

-- Ejercicio 18 

-- Mostrar los clientes cuyo total de pagos recibidos sea superior al promedio del 

-- total de pagos por cliente, considerando solo clientes que hayan recibido algún 

-- pago. 

-- Une hasta pagos antes de formar los grupos. Solo los clientes con pagos participan 

-- en el promedio de los totales recibidos. 

WITH totales AS ( 

    SELECT c.id_cliente, c.nombre, SUM(a.monto) AS importe 

    FROM clientes c 

    JOIN pedidos p ON p.id_cliente = c.id_cliente 

    JOIN pagos a ON a.id_pedido = p.id_pedido 

    GROUP BY c.id_cliente, c.nombre 

) 

SELECT nombre, importe 

FROM totales 

WHERE importe > (SELECT AVG(importe) FROM totales); 

-- Ejercicio 19 

-- Encontrar los pedidos que todavía tienen saldo pendiente de pago, incluyendo los 

-- que no registran pagos. Mostrar cliente, pedido, total, monto pagado y saldo. 

-- Resta lo pagado al total de cada pedido. La guía pide saldo positivo sin filtro por 

-- estado, de modo que también aparece el pedido cancelado 105. 

SELECT c.nombre, p.id_pedido, p.total, NVL(SUM(a.monto), 0) AS pagado, 

       p.total - NVL(SUM(a.monto), 0) AS saldo 

FROM clientes c 

JOIN pedidos p ON p.id_cliente = c.id_cliente 

LEFT JOIN pagos a ON a.id_pedido = p.id_pedido 

GROUP BY c.nombre, p.id_pedido, p.total 

HAVING p.total > NVL(SUM(a.monto), 0); 

-- Ejercicio 20 

-- Mostrar los clientes que hayan efectuado por lo menos dos pedidos ENTREGADO y cuyo 

-- importe acumulado de esos pedidos supere los 150000. Incluir nombre, cantidad de 

-- pedidos y total acumulado. 

-- WHERE selecciona los pedidos entregados antes de agrupar. HAVING exige a la vez dos 

-- entregas o más y una suma superior a 150000. 

SELECT c.nombre, COUNT(*) AS entregados, SUM(p.total) AS importe 

FROM clientes c 

JOIN pedidos p ON p.id_cliente = c.id_cliente 

WHERE p.estado = 'ENTREGADO' 

GROUP BY c.id_cliente, c.nombre 

HAVING COUNT(*) >= 2 AND SUM(p.total) > 150000;
