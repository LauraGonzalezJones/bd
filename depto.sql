-- Si ya tienes las tablas con sus datos, empieza en el ejercicio 01. 

-- Si comienzas desde cero, ejecuta primero la preparación. 

 

-- Ejecutar una sola vez en un esquema de práctica vacío. 

-- Crea la tabla departamento. 

CREATE TABLE departamento ( 

   id_departamento NUMBER(3) PRIMARY KEY, 

   nombre VARCHAR2(60) NOT NULL, 

   ciudad VARCHAR2(60) NOT NULL 

); 

 

-- Crea la tabla empleado. 

CREATE TABLE empleado ( 

   id_empleado NUMBER(4) PRIMARY KEY, 

   nombre VARCHAR2(60) NOT NULL, 

   apellido VARCHAR2(60) NOT NULL, 

   cargo VARCHAR2(60) NOT NULL, 

   sueldo NUMBER(12) NOT NULL, 

   fecha_contrato DATE NOT NULL, 

   id_departamento NUMBER(3) NOT NULL 

     REFERENCES departamento(id_departamento) 

); 

 

-- Crea la tabla proyecto. 

CREATE TABLE proyecto ( 

   id_proyecto NUMBER(4) PRIMARY KEY, 

   nombre VARCHAR2(80) NOT NULL, 

   presupuesto NUMBER(14) NOT NULL, 

   estado VARCHAR2(25) NOT NULL, 

   id_departamento NUMBER(3) NOT NULL 

     REFERENCES departamento(id_departamento) 

); 

 

 

 

INSERT INTO departamento VALUES (10,'Tecnología','Santiago'); 

INSERT INTO departamento VALUES (20,'Finanzas','Valparaíso'); 

INSERT INTO departamento VALUES (30,'Operaciones','Concepción'); 

INSERT INTO departamento VALUES (40,'Marketing','Santiago'); 

INSERT INTO departamento VALUES (50,'Calidad','Temuco'); 

INSERT INTO departamento VALUES (60,'Innovación','La Serena'); 

INSERT INTO empleado VALUES (1,'Ana','Pérez','Analista',1400000,DATE '2022-03-10',10); 

INSERT INTO empleado VALUES (2,'Luis','Rojas','Desarrollador',1800000,DATE '2021-07-01',10); 

INSERT INTO empleado VALUES (3,'Carla','Muñoz','Jefe de área',2200000,DATE '2020-01-15',10); 

INSERT INTO empleado VALUES (4,'Pedro','Díaz','Contador',1300000,DATE '2023-05-20',20); 

INSERT INTO empleado VALUES (5,'Sofía','Vega','Analista',1600000,DATE '2022-11-03',20); 

 

INSERT INTO empleado VALUES (6,'Jorge','Soto','Supervisor',1500000,DATE '2019-04-12',30); 

INSERT INTO empleado VALUES (7,'Elena','Castro','Operador',950000,DATE '2024-06-07',30); 

INSERT INTO empleado VALUES (8,'Mario','Lagos','Operador',1050000,DATE '2025-02-01',30); 

INSERT INTO empleado VALUES (9,'Paula','Silva','Diseñadora',1250000,DATE '2023-09-18',40); 

INSERT INTO empleado VALUES (10,'Diego','Fuentes','Analista',1450000,DATE '2024-01-08',40); 

INSERT INTO empleado VALUES (11,'Rosa','Navarro','Gestora',1200000,DATE '2022-08-22',60); 

INSERT INTO empleado VALUES (12,'Tomás','Herrera','Ingeniero',1750000,DATE '2021-12-06',60); 

INSERT INTO proyecto VALUES (101,'Migración ERP',30000000,'EN EJECUCION',10); 

INSERT INTO proyecto VALUES (102,'Portal interno',12000000,'FINALIZADO',10); 

INSERT INTO proyecto VALUES (103,'Automatización QA',18000000,'PLANIFICADO',10); 

INSERT INTO proyecto VALUES (104,'Control de gastos',14000000,'EN EJECUCION',20); 

INSERT INTO proyecto VALUES (105,'Inventario digital',22000000,'FINALIZADO',30); 

INSERT INTO proyecto VALUES (106,'Optimización logística',26000000,'EN EJECUCION',30); 

INSERT INTO proyecto VALUES (107,'Campaña digital',9000000,'PLANIFICADO',40); 

INSERT INTO proyecto VALUES (108,'Plataforma IA',40000000,'PLANIFICADO',60); 

INSERT INTO proyecto VALUES (109,'Piloto de sensores',16000000,'EN EJECUCION',60); 

-- Guarda los registros de práctica. 

COMMIT; 

-- Ejercicio 01 · Dotación por departamento 

-- Informe el nombre y la ciudad de cada departamento que tenga empleados, junto con 

-- su cantidad de trabajadores. Ordene desde la mayor dotación a la menor. 

-- Une cada empleado con su departamento. Cada fila de la unión representa un 

-- trabajador. COUNT(*) cuenta esas filas por área. 

SELECT d.nombre, d.ciudad, COUNT(*) AS trabajadores 

FROM departamento d 

JOIN empleado e ON e.id_departamento = d.id_departamento 

GROUP BY d.id_departamento, d.nombre, d.ciudad 

ORDER BY trabajadores DESC, d.nombre; 

-- Ejercicio 02 · Costo salarial por área 

-- Presente los departamentos con empleados, indicando cantidad de trabajadores, 

-- sueldo mínimo, sueldo máximo y total de sueldos mensuales. Ordene por total de 

-- sueldos descendente. 

-- Agrupa las filas por departamento. MIN y MAX buscan los extremos del grupo y SUM 

-- suma sus sueldos. 

SELECT d.nombre, COUNT(*) AS trabajadores, MIN(e.sueldo) AS minimo, 

       MAX(e.sueldo) AS maximo, SUM(e.sueldo) AS total_sueldos 

FROM departamento d 

JOIN empleado e ON e.id_departamento = d.id_departamento 

GROUP BY d.id_departamento, d.nombre 

ORDER BY total_sueldos DESC, d.nombre; 

-- Ejercicio 03 · Promedio salarial relevante 

-- Muestre solamente los departamentos cuyo sueldo promedio sea superior a $1.450.000. 

-- Incluya promedio redondeado a pesos y cantidad de empleados. 

-- HAVING compara el promedio exacto del grupo con el límite. ROUND redondea 

-- únicamente el resultado que se muestra. 

SELECT d.nombre, ROUND(AVG(e.sueldo)) AS promedio, COUNT(*) AS empleados 

FROM departamento d 

JOIN empleado e ON e.id_departamento = d.id_departamento 

GROUP BY d.id_departamento, d.nombre 

HAVING AVG(e.sueldo) > 1450000; 

-- Ejercicio 04 · Presupuesto por departamento 

-- Entregue el nombre de cada departamento con proyectos, su número de proyectos y la 

-- suma de los presupuestos. Ordene por inversión descendente. 

-- Une departamentos y proyectos. COUNT cuenta proyectos y SUM suma sus presupuestos 

-- dentro de cada área. 

SELECT d.nombre, COUNT(*) AS proyectos, SUM(p.presupuesto) AS inversion 

FROM departamento d 

JOIN proyecto p ON p.id_departamento = d.id_departamento 

GROUP BY d.id_departamento, d.nombre 

ORDER BY inversion DESC, d.nombre; 

-- Ejercicio 05 · Áreas con varios proyectos 

-- Identifique los departamentos con al menos dos proyectos. Muestre nombre, cantidad 

-- de proyectos y presupuesto máximo individual. 

-- HAVING conserva los grupos con dos proyectos o más. MAX toma el mayor presupuesto 

-- individual de cada grupo. 

SELECT d.nombre, COUNT(*) AS proyectos, MAX(p.presupuesto) AS maximo 

FROM departamento d 

JOIN proyecto p ON p.id_departamento = d.id_departamento 

GROUP BY d.id_departamento, d.nombre 

HAVING COUNT(*) >= 2; 

-- Ejercicio 06 · Dotación completa 

-- Presente todos los departamentos, tengan o no trabajadores, y la cantidad de 

-- empleados de cada uno. Ordene por código de departamento. 

-- Parte desde departamento con LEFT JOIN para conservar Calidad. Cuenta la clave del 

-- empleado porque COUNT ignora las claves nulas. 

SELECT d.nombre, COUNT(e.id_empleado) AS empleados 

FROM departamento d 

LEFT JOIN empleado e ON e.id_departamento = d.id_departamento 

GROUP BY d.id_departamento, d.nombre 

ORDER BY d.id_departamento; 

-- Ejercicio 07 · Cobertura de proyectos 

-- Muestre todos los departamentos, su número de proyectos y su presupuesto total. En 

-- las áreas sin proyectos, indique cero para ambas cifras. 

-- COUNT devuelve cero cuando falta la clave del proyecto. SUM devuelve NULL cuando no 

-- hay presupuestos y NVL lo convierte en cero. 

SELECT d.nombre, COUNT(p.id_proyecto) AS proyectos, 

       NVL(SUM(p.presupuesto), 0) AS presupuesto 

FROM departamento d 

LEFT JOIN proyecto p ON p.id_departamento = d.id_departamento 

GROUP BY d.id_departamento, d.nombre; 

-- Ejercicio 08 · Detalle de personal por área 

-- Liste todos los departamentos junto con el código, nombre, apellido y sueldo de 

-- cada trabajador, cuando exista. Deben mostrarse igualmente los departamentos sin 

-- personal. 

-- Cada empleado ocupa su propia fila. LEFT JOIN agrega también una fila para Calidad, 

-- con los datos del empleado vacíos. 

SELECT d.nombre AS departamento, e.id_empleado, e.nombre, e.apellido, e.sueldo 

FROM departamento d 

LEFT JOIN empleado e ON e.id_departamento = d.id_departamento 

ORDER BY d.id_departamento, e.id_empleado; 

-- Ejercicio 09 · Áreas sin proyectos 

-- Identifique los departamentos que no tengan proyectos registrados. Muestre código, 

-- nombre y ciudad. 

-- Para cada departamento, la subconsulta busca un proyecto suyo. NOT EXISTS conserva 

-- el departamento si la búsqueda queda vacía. 

SELECT d.id_departamento, d.nombre, d.ciudad 

FROM departamento d 

WHERE NOT EXISTS ( 

    SELECT 1 FROM proyecto p 

    WHERE p.id_departamento = d.id_departamento 

); 

-- Ejercicio 10 · Sueldos sobre el promedio general 

-- Muestre código, nombre, apellido, sueldo y departamento de los empleados que ganan 

-- más que el promedio salarial general, ordenados de mayor a menor sueldo. 

-- La subconsulta obtiene un único promedio de toda la tabla empleado. WHERE compara 

-- el sueldo individual con ese valor. 

SELECT e.id_empleado, e.nombre, e.apellido, e.sueldo, d.nombre AS departamento 

FROM departamento d 

JOIN empleado e ON e.id_departamento = d.id_departamento 

WHERE e.sueldo > (SELECT AVG(sueldo) FROM empleado) 

ORDER BY e.sueldo DESC, e.id_empleado; 

-- Ejercicio 11 · Proyectos sobre el promedio general 

-- Muestre código, nombre, presupuesto y departamento de los proyectos cuyo 

-- presupuesto sea superior al presupuesto promedio general. 

-- Calcula una referencia común con todos los presupuestos. Compara cada proyecto con 

-- ese mismo promedio. 

SELECT p.id_proyecto, p.nombre, p.presupuesto, d.nombre AS departamento 

FROM departamento d 

JOIN proyecto p ON p.id_departamento = d.id_departamento 

WHERE p.presupuesto > (SELECT AVG(presupuesto) FROM proyecto); 

-- Ejercicio 12 · Dotación superior a la media 

-- Informe los departamentos cuya cantidad de empleados exceda el promedio de 

-- empleados por departamento, considerando también los departamentos sin personal. 

-- Muestre nombre y dotación. 

-- WITH prepara una fila por departamento, incluido Calidad con cero. La media es 12 / 

-- 6 = 2. El filtro exige superar 2. 

WITH dotacion AS ( 

    SELECT d.id_departamento, d.nombre, COUNT(e.id_empleado) AS cantidad 

    FROM departamento d 

    LEFT JOIN empleado e ON e.id_departamento = d.id_departamento 

    GROUP BY d.id_departamento, d.nombre 

) 

SELECT nombre, cantidad FROM dotacion 

WHERE cantidad > (SELECT AVG(cantidad) FROM dotacion); 

-- Ejercicio 13 · Inversión superior a la media 

-- Informe los departamentos cuya inversión total en proyectos supere la inversión 

-- promedio por departamento, considerando también a los departamentos sin proyectos. 

-- Muestre nombre y presupuesto total. 

-- Primero suma los presupuestos por área, asignando cero a Calidad. Después promedia 

-- esos seis totales y compara cada área con esa referencia. 

WITH inversion AS ( 

    SELECT d.id_departamento, d.nombre, NVL(SUM(p.presupuesto), 0) AS total 

    FROM departamento d 

    LEFT JOIN proyecto p ON p.id_departamento = d.id_departamento 

    GROUP BY d.id_departamento, d.nombre 

) 

SELECT nombre, total FROM inversion 

WHERE total > (SELECT AVG(total) FROM inversion); 

-- Ejercicio 14 · Máximo sueldo en cada área 

-- Liste los empleados que reciben el sueldo más alto de su propio departamento. 

-- Incluya nombre, apellido, sueldo y nombre del departamento. 

-- e2 representa los empleados del departamento de la fila e. La igualdad con MAX 

-- incluye a todos los empleados empatados en el máximo. 

SELECT e.nombre, e.apellido, e.sueldo, d.nombre AS departamento 

FROM departamento d 

JOIN empleado e ON e.id_departamento = d.id_departamento 

WHERE e.sueldo = ( 

    SELECT MAX(e2.sueldo) FROM empleado e2 

    WHERE e2.id_departamento = e.id_departamento 

); 

-- Ejercicio 15 · Proyectos sobre el promedio de su área 

-- Presente los proyectos cuyo presupuesto sea superior al presupuesto promedio de los 

-- proyectos de su propio departamento. Incluya nombre del proyecto, departamento y 

-- presupuesto. 

-- p2 recorre los proyectos del mismo departamento que p. Un área con un solo proyecto 

-- queda fuera porque su presupuesto coincide con su promedio. 

SELECT p.nombre AS proyecto, d.nombre AS departamento, p.presupuesto 

FROM departamento d 

JOIN proyecto p ON p.id_departamento = d.id_departamento 

WHERE p.presupuesto > ( 

    SELECT AVG(p2.presupuesto) FROM proyecto p2 

    WHERE p2.id_departamento = p.id_departamento 

); 

-- Ejercicio 16 · Cobertura conjunta de personas y proyectos 

-- Por cada departamento, muestre ciudad, cantidad de empleados y cantidad de 

-- proyectos, incluso cuando una o ambas cantidades sean cero. Cada empleado y 

-- proyecto debe contarse una sola vez. 

-- Resume personal y cartera por separado. Así tres empleados y tres proyectos se 

-- cuentan como tres de cada tipo al unir los resúmenes. 

WITH personal AS ( 

    SELECT id_departamento, COUNT(*) AS empleados, SUM(sueldo) AS sueldos 

    FROM empleado 

    GROUP BY id_departamento 

), cartera AS ( 

    SELECT id_departamento, COUNT(*) AS proyectos, SUM(presupuesto) AS inversion 

    FROM proyecto 

    GROUP BY id_departamento 

) 

SELECT d.nombre, d.ciudad, NVL(e.empleados, 0) AS empleados, 

       NVL(p.proyectos, 0) AS proyectos 

FROM departamento d 

LEFT JOIN personal e ON e.id_departamento = d.id_departamento 

LEFT JOIN cartera p ON p.id_departamento = d.id_departamento; 

-- Ejercicio 17 · Departamentos con actividad en ambas áreas 

-- Identifique los departamentos que tengan al menos dos empleados y al menos dos 

-- proyectos. Muestre nombre, cantidad de empleados y cantidad de proyectos. 

-- Usa los dos conteos ya calculados por departamento. AND exige que ambos alcancen el 

-- mínimo de dos. 

WITH personal AS ( 

    SELECT id_departamento, COUNT(*) AS empleados, SUM(sueldo) AS sueldos 

    FROM empleado 

    GROUP BY id_departamento 

), cartera AS ( 

    SELECT id_departamento, COUNT(*) AS proyectos, SUM(presupuesto) AS inversion 

    FROM proyecto 

    GROUP BY id_departamento 

) 

SELECT d.nombre, e.empleados, p.proyectos 

FROM departamento d 

LEFT JOIN personal e ON e.id_departamento = d.id_departamento 

LEFT JOIN cartera p ON p.id_departamento = d.id_departamento 

WHERE e.empleados >= 2 AND p.proyectos >= 2; 

-- Ejercicio 18 · Proyectos en áreas con alta dotación 

-- Muestre nombre del proyecto, departamento, presupuesto y dotación del departamento 

-- para los proyectos pertenecientes a áreas cuya dotación supere el promedio de 

-- empleados por departamento, incluyendo las áreas sin personal al calcular dicho 

-- promedio. 

-- Calcula la dotación de las seis áreas, selecciona las que superan la media y 

-- muestra cada proyecto asociado a ellas. 

WITH dotacion AS ( 

    SELECT d.id_departamento, d.nombre, COUNT(e.id_empleado) AS cantidad 

    FROM departamento d 

    LEFT JOIN empleado e ON e.id_departamento = d.id_departamento 

    GROUP BY d.id_departamento, d.nombre 

) 

SELECT p.nombre AS proyecto, d.nombre AS departamento, p.presupuesto, d.cantidad 

FROM proyecto p 

JOIN dotacion d ON d.id_departamento = p.id_departamento 

WHERE d.cantidad > (SELECT AVG(cantidad) FROM dotacion); 

-- Ejercicio 19 · Empleados de departamentos con alta inversión 

-- Muestre nombre completo del empleado, departamento, sueldo y presupuesto total de 

-- proyectos de su departamento para las áreas cuya inversión total supere 

-- $45.000.000. Presente cada empleado una sola vez. 

-- La tabla temporal inversion contiene una sola fila por área. Cada empleado se une 

-- una sola vez al presupuesto total de su departamento. 

WITH inversion AS ( 

    SELECT d.id_departamento, d.nombre, NVL(SUM(p.presupuesto), 0) AS total 

    FROM departamento d 

    LEFT JOIN proyecto p ON p.id_departamento = d.id_departamento 

    GROUP BY d.id_departamento, d.nombre 

) 

SELECT e.nombre || ' ' || e.apellido AS empleado, d.nombre AS departamento, 

       e.sueldo, d.total AS presupuesto 

FROM empleado e 

JOIN inversion d ON d.id_departamento = e.id_departamento 

WHERE d.total > 45000000; 

-- Ejercicio 20 · Informe integral por departamento 

-- Elabore un informe de todos los departamentos con ciudad, número de empleados, 

-- total mensual de sueldos, número de proyectos, presupuesto acumulado y diferencia 

-- entre presupuesto y sueldos mensuales. En áreas sin empleados o proyectos, muestre 

-- cero. No duplique los valores al integrar la información. 

-- Calcula sueldos y presupuestos antes de unir. Así cada monto se suma una sola vez. 

-- NVL permite restar incluso en áreas sin actividad. 

WITH personal AS ( 

    SELECT id_departamento, COUNT(*) AS empleados, SUM(sueldo) AS sueldos 

    FROM empleado 

    GROUP BY id_departamento 

), cartera AS ( 

    SELECT id_departamento, COUNT(*) AS proyectos, SUM(presupuesto) AS inversion 

    FROM proyecto 

    GROUP BY id_departamento 

) 

SELECT d.nombre, d.ciudad, NVL(e.empleados, 0) AS empleados, 

       NVL(e.sueldos, 0) AS sueldos, NVL(p.proyectos, 0) AS proyectos, 

       NVL(p.inversion, 0) AS presupuesto, 

       NVL(p.inversion, 0) - NVL(e.sueldos, 0) AS diferencia 

FROM departamento d 

LEFT JOIN personal e ON e.id_departamento = d.id_departamento 

LEFT JOIN cartera p ON p.id_departamento = d.id_departamento 

ORDER BY d.id_departamento;



