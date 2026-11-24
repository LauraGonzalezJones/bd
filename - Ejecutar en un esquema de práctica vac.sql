- Ejecutar en un esquema de práctica vacío.
CREATE TABLE clientes (
 id_cliente NUMBER(4) CONSTRAINT pk_clientes PRIMARY KEY,
 nombre VARCHAR2(80 CHAR) NOT NULL,
 ciudad VARCHAR2(40 CHAR) NOT NULL,
 categoria VARCHAR2(15 CHAR) NOT NULL
);
CREATE TABLE pedidos (
 id_pedido NUMBER(5) CONSTRAINT pk_pedidos PRIMARY KEY,
 id_cliente NUMBER(4) NOT NULL,
 fecha_pedido DATE NOT NULL,
 estado VARCHAR2(15 CHAR) NOT NULL,
 total NUMBER(10,2) NOT NULL,
 CONSTRAINT fk_pedidos_clientes FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
 CONSTRAINT ck_pedidos_total CHECK (total > 0)
);
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
COMMIT;


Obtener el nombre y la ciudad de cada cliente, junto con la cantidad total de pedidos registrados a su nombre. Incluir
también a los clientes sin pedidos.


SELECT c.nombre, c.ciudad, COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.ciudad




--Ejercicio 02
Mostrar el identificador de cada pedido, el nombre del cliente, su estado y el importe total, únicamente para pedidos
de clientes de Santiago.--

SELECT p.id_pedido, c.nombre, p.estado, p.total
FROM pedidos p  
LEFT JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE c.ciudad = 'Santiago' 

EJERCICIO 03
Listar todos los pedidos con su identificador, fecha, total y monto acumulado de pagos recibidos. Los pedidos sin
pagos deben aparecer con monto pagado igual a cero.

SELECT p.id_pedido, p.fecha_pedido, p.total, NVL(SUM(pg.monto), 0) AS monto_pagado
FROM pedidos p
LEFT JOIN pagos pg ON p.id_pedido = pg.id_pedido
GROUP BY p.id_pedido, p.fecha_pedido, p.total   


--EJERCICIO 04
Identificar los clientes que todavía--
-- no han realizado pedidos. Mostrar su nombre, ciudad y categoría. --
SELECT c.nombre, c.ciudad, c.categoria
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente

WHERE p.id_pedido IS NULL   






EJERCICIO 05 
--Ejercicio 05
----Mostrar el nombre de cada cliente que tenga al menos dos pedidos, junto con la cantidad de pedidos y la suma de sus
----importes.--
SELECT c.nombre, COUNT(p.id_pedido) AS cantidad_pedidos, SUM(p.total) AS suma_importes
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING COUNT(p.id_pedido) >= 2
   
importes.
Ejercicio 06
Obtener los clientes cuyo valor total de pedidos sea superior a 180000. Mostrar nombre y 
total acumulado de pedidos.
select c.nombre, SUM(p.total) AS total_acumulado
from clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente 
GROUP BY c.id_cliente, c.nombre
HAVING SUM(p.total) > 180000

Ejercicio 07
Mostrar los pedidos que registran más de un pago. Incluir el identificador del pedido, el nombre del cliente, la
cantidad de pagos y el monto pagado.
SELECT p.id_pedido, c.nombre, COUNT(pg.id_pago) AS cantidad_pagos, SUM(pg.monto) AS monto_pagado
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN pagos pg ON p.id_pedido = pg.id_pedido
GROUP BY p.id_pedido, c.nombre


Ejercicio 08
Obtener la cantidad de pedidos y el valor promedio de sus importes para cada estado. Presentar los estados con un
valor promedio superior a 60000.
SELECT p.estado, COUNT(p.id_pedido) AS cantidad_pedidos, AVG(p.total) AS promedio_importes
FROM pedidos p
GROUP BY p.estado
HAVING AVG(p.total) > 60000



Ejercicio 09
Mostrar el nombre, categoría y monto total de pagos realizados para cada cliente. Incluir también a los clientes sin
pagos, con un total de cero.


SELECT c.nombre, c.categoria, NVL(SUM(pg.monto), 0) AS total_pagos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
LEFT JOIN pagos pg ON p.id_pedido = pg.id_pedido
GROUP BY c.id_cliente, c.nombre, c.categoria

Ejercicio 10
Identificar los clientes cuyo total de pedidos supera el promedio del total de pedidos por cliente, considerando
únicamente clientes que hayan realizado al menos un pedido.
SELECT c.nombre, SUM(p.total) AS total_pedidos
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING SUM(p.total) > (SELECT AVG(total_pedidos) FROM (SELECT SUM(total) AS total_pedidos FROM pedidos GROUP BY id_cliente))
Ejercicio 12
Indicar los clientes que hayan realizado al menos un pedido que no registre
SELECT c.nombre, COUNT(p.id_pedido) AS cantidad_pedidos_sin_pago
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
LEFT JOIN pagos pg ON p.id_pedido = pg.id_pedido
WHERE pg.id_pago IS NULL

jercicio 13
Mostrar por ciudad la cantidad de clientes distintos, la cantidad de pedidos distintos y el monto total facturado por
pedidos. Incluir las ciudades donde no existen pedidos.

SELECT c.ciudad, COUNT(DISTINCT c.id_cliente) AS cantidad_clientes, COUNT(DISTINCT p.id_pedido) AS cantidad_pedidos, NVL(SUM(p.total), 0) AS monto_total_facturado
FROM clientes c 
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.ciudad   


Ejercicio 14
Mostrar para cada medio de pago la cantidad de pagos, el importe total recaudado y el importe promedio por pago.
Incluir solo medios con recaudación superior a 200000.
SELECT pg.medio_pago, COUNT(pg.id_pago) AS cantidad_pagos, SUM(pg.monto) AS total_recaudado, AVG(pg.monto) AS promedio_pago
FROM pagos pg   
WHERE SUM(pg.monto) > 200000
GROUP BY pg.medio_pago

Ejercicio 15
Obtener los clientes que tengan pedidos en más de un estado diferente. Mostrar nombre y cantidad de estados
distintos registrados.
SELECT c.nombre, COUNT(DISTINCT p.estado) AS cantidad_estados
FROM clientes c 
JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre



Ejercicio 16
Listar todos los clientes y la cantidad de pedidos ENTREGADO que tiene cada uno, incluyendo a quienes no registren
pedidos de ese estado.
SELECT c.nombre, COUNT(p.id_pedido) AS cantidad_pedidos_entregado
FROM clientes c     
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente AND p.estado = 'ENTREGADO'
GROUP BY c.id_cliente, c.nombre





Ejercicio 17
Identificar las categorías de clientes cuyo importe acumulado de pedidos sea mayor que el importe acumulado de
pedidos de la categoría BRONCE.

SELECT c.categoria, SUM(p.total) AS total_acumulado
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.categoria    





Ejercicio 18
Mostrar los clientes cuyo total de pagos recibidos sea superior al promedio del total de pagos por cliente,
considerando solo clientes que hayan recibido algún pago.
SELECT c.nombre, SUM(pg.monto) AS total_pagos
FROM clientes c 
JOIN pedidos p ON c.id_cliente = p.id_cliente
JOIN pagos pg ON p.id_pedido = pg.id_pedido
GROUP BY c.id_cliente, c.nombre
HAVING SUM(pg.monto) > (SELECT AVG(total_pagos) FROM (SELECT SUM(pg.monto) AS total_pagos FROM clientes c JOIN pedidos p ON c.id_cliente = p.id_cliente JOIN pagos pg ON p.id_pedido = pg.id_pedido GROUP BY c.id_cliente))


Ejercicio 19
Encontrar los pedidos que todavía tienen saldo pendiente de pago, incluyendo los que no registran pagos. Mostrar
cliente, pedido, total, monto pagado y saldo.
SELECT c.nombre, p.id_pedido, p.total, NVL(SUM(pg.monto), 0) AS monto_pagado, p.total - NVL(SUM(pg.monto), 0) AS saldo
FROM clientes c 
JOIN pedidos p ON c.id_cliente = p.id_cliente
LEFT JOIN pagos pg ON p.id_pedido = pg.id_pedido
GROUP BY c.nombre, p.id_pedido, p.total





Ejercicio 20
Mostrar los clientes que hayan efectuado por lo menos dos pedidos ENTREGADO y cuyo importe acumulado de esos
pedidos supere los 150000. Incluir nombre, cantidad de pedidos y total acumulado.
 SELECT c.nombre, COUNT(p.id_pedido) AS cantidad_pedidos_entregado, SUM(p.total) AS total_acumulado
FROM clientes c
JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.estado = 'ENTREGADO'
GROUP BY c.id_cliente, c.nombre
HAVING COUNT(p.id_pedido) >= 2 AND SUM(p.total) > 150000
