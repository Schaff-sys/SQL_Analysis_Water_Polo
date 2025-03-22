-- 1. Crear la base de datos (si no existe)
CREATE DATABASE IF NOT EXISTS water_polo_stats; -- Crea la base de datos solo si no existe
USE water_polo_stats; -- Usa la base de datos recién creada o existente

-- 2. Crear tabla de jugadores (almacena los datos de los jugadores)
CREATE TABLE IF NOT EXISTS jugadores (
    id INT AUTO_INCREMENT PRIMARY KEY,      -- Identificador único de cada jugador
    equipo VARCHAR(100),                    -- Nombre del equipo al que pertenece el jugador
    jugador_id VARCHAR(50),                 -- ID único del jugador (puede ser un código)
    nombre VARCHAR(100),                    -- Nombre del jugador
    edad INT,                               -- Edad del jugador
    posicion VARCHAR(50)                    -- Posición en la que juega el jugador (Ej: portero, defensor, etc.)
); 

-- 3. Crear tabla de partidos (almacena los datos de los partidos)
CREATE TABLE IF NOT EXISTS partidos (
    id INT AUTO_INCREMENT PRIMARY KEY,      -- Identificador único del partido
    partido_id VARCHAR(50),                 -- ID único del partido
    equipo_1 VARCHAR(100),                  -- Nombre del primer equipo que juega
    equipo_2 VARCHAR(100),                  -- Nombre del segundo equipo que juega
    goles_equipo_1 INT,                     -- Goles del primer equipo
    goles_equipo_2 INT,                     -- Goles del segundo equipo
    fecha DATE                              -- Fecha del partido (tipo DATE, se limpiará si es inválida)
);

-- 4. Importar datos de jugadores desde el archivo CSV
-- La ruta del archivo debe ser ajustada según la ubicación en tu sistema
LOAD DATA INFILE 'ruta'
INTO TABLE jugadores
FIELDS TERMINATED BY ','           -- Los campos están separados por comas
ENCLOSED BY '"'                    -- Los valores están entre comillas dobles
LINES TERMINATED BY '\n'           -- Cada fila está separada por una nueva línea
IGNORE 1 ROWS                      -- Ignora la primera fila (cabeceras)
(equipo, jugador_id, nombre, edad, posicion); -- Correspondencia con las columnas del archivo

-- 5. Importar datos de partidos desde el archivo CSV
-- Debido a que algunas fechas pueden ser inválidas, primero importamos los datos a una tabla temporal
CREATE TABLE IF NOT EXISTS partidos_temp (
    id INT AUTO_INCREMENT PRIMARY KEY,      -- Identificador único del partido
    partido_id VARCHAR(50),                 -- ID único del partido
    equipo_1 VARCHAR(100),                  -- Nombre del primer equipo que juega
    equipo_2 VARCHAR(100),                  -- Nombre del segundo equipo que juega
    goles_equipo_1 INT,                     -- Goles del primer equipo
    goles_equipo_2 INT,                     -- Goles del segundo equipo
    fecha VARCHAR(20)                       -- Fecha en formato de texto para manejar fechas inválidas
);

-- Cargar los datos de partidos en la tabla temporal
LOAD DATA INFILE 'ruta'
INTO TABLE partidos_temp
FIELDS TERMINATED BY ','           -- Los campos están separados por comas
ENCLOSED BY '"'                    -- Los valores están entre comillas dobles
LINES TERMINATED BY '\n'           -- Cada fila está separada por una nueva línea
IGNORE 1 ROWS                      -- Ignora la primera fila (cabeceras)
(partido_id, equipo_1, equipo_2, goles_equipo_1, goles_equipo_2, fecha); -- Correspondencia con las columnas del archivo

-- 6. Insertar los datos limpios en la tabla final de partidos
-- Convertimos la fecha a formato DATE, y si no es válida, la dejamos como NULL
INSERT INTO partidos (partido_id, equipo_1, equipo_2, goles_equipo_1, goles_equipo_2, fecha)
SELECT partido_id, equipo_1, equipo_2, goles_equipo_1, goles_equipo_2,
       STR_TO_DATE(fecha, '%Y-%m-%d')   -- Convertir la fecha a tipo DATE
FROM partidos_temp;                   -- Datos provienen de la tabla temporal

-- 7. (Opcional) Verificar los registros con fecha nula (esto puede ser útil para depurar)
SELECT * FROM partidos WHERE fecha IS NULL;

-- 8. Limpiar la tabla temporal (ya no es necesaria después de la carga de los datos)
DROP TABLE partidos_temp;             


