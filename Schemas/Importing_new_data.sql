-- 1. Crear la tabla 'tu_tabla2' (almacena los datos de los jugadores con validación en la edad)
CREATE TABLE IF NOT EXISTS tu_tabla2 (
    equipo VARCHAR(255),        -- Nombre del equipo al que pertenece el jugador
    jugador_id VARCHAR(255),    -- ID único del jugador
    nombre VARCHAR(255),        -- Nombre del jugador
    edad FLOAT,                 -- Edad del jugador (tipo FLOAT para permitir números con decimales)
    posicion VARCHAR(255)       -- Posición del jugador (Ej: portero, defensor, etc.)
    -- Añadir otras columnas necesarias según los requisitos
);

-- 2. Cargar los datos del archivo CSV en la tabla 'tu_tabla2'
LOAD DATA INFILE 'ruta'
INTO TABLE tu_tabla2
CHARACTER SET utf8mb4              -- Usar UTF-8 para asegurar que los caracteres especiales se manejen correctamente
FIELDS TERMINATED BY ','           -- Los campos están separados por comas
ENCLOSED BY '"'                    -- Los valores están entre comillas dobles
LINES TERMINATED BY '\n'           -- Cada fila está separada por una nueva línea
IGNORE 1 ROWS                      -- Ignora la primera fila (cabeceras)
( equipo, jugador_id, nombre, @edad, posicion ) -- Asocia las columnas del CSV con las columnas de la tabla
SET edad = CASE                     -- Condición para validar la edad
    WHEN @edad REGEXP '^[0-9]+(\.[0-9]+)?$' THEN @edad  -- Si la edad es un número válido (entero o con decimales), se guarda
    ELSE NULL                       -- Si no es un número válido, se asigna NULL para evitar problemas en cálculos
END;

-- 3. Actualizar la tabla 'jugadores_staging2' con las edades corregidas desde 'tu_tabla2'
UPDATE jugadores_staging2 e
JOIN tu_tabla2 n ON e.nombre = n.nombre  -- Se hace el JOIN usando el campo 'nombre' (suponiendo que es único)
SET e.edad = n.edad;                      -- Se actualiza el campo 'edad' de la tabla original con la edad corregida

-- 4. Crear la tabla 'tu_tabla3' (se repite el proceso para cargar más datos de jugadores si es necesario)
CREATE TABLE IF NOT EXISTS tu_tabla3 (
    equipo VARCHAR(255),        -- Nombre del equipo al que pertenece el jugador
    jugador_id VARCHAR(255),    -- ID único del jugador
    nombre VARCHAR(255),        -- Nombre del jugador
    edad FLOAT,                 -- Edad del jugador
    posicion VARCHAR(255)       -- Posición del jugador
    -- Añadir otras columnas necesarias según los requisitos
);

-- 5. Cargar los datos nuevamente en 'tu_tabla3' de la misma forma que se hizo antes
LOAD DATA INFILE 'ruta'
INTO TABLE tu_tabla3
CHARACTER SET utf8mb4              -- Usar UTF-8 para asegurar que los caracteres especiales se manejen correctamente
FIELDS TERMINATED BY ','           -- Los campos están separados por comas
ENCLOSED BY '"'                    -- Los valores están entre comillas dobles
LINES TERMINATED BY '\n'           -- Cada fila está separada por una nueva línea
IGNORE 1 ROWS                      -- Ignora la primera fila (cabeceras)
( equipo, jugador_id, nombre, @edad, posicion ) -- Asocia las columnas del CSV con las columnas de la tabla
SET edad = CASE                     -- Condición para validar la edad
    WHEN @edad REGEXP '^[0-9]+(\.[0-9]+)?$' THEN @edad  -- Si la edad es un número válido (entero o con decimales), se guarda
    ELSE NULL                       -- Si no es un número válido, se asigna NULL para evitar problemas en cálculos
END;

-- 6. Actualizar la tabla 'jugadores_staging2' con las edades corregidas desde 'tu_tabla3'
UPDATE jugadores_staging2 e
JOIN tu_tabla3 n ON e.nombre = n.nombre  -- Se hace el JOIN usando el campo 'nombre'
SET e.edad = n.edad;                      -- Se actualiza el campo 'edad' de la tabla original con la edad corregida
