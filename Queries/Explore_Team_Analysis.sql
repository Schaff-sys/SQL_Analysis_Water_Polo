USE water_polo_stats;

-- 1. Total Number of Matches
SELECT 
    COUNT(*) AS total_partidos
FROM 
    partidos_staging2;

-- 2. Total Number of Players
SELECT 
    COUNT(*) AS total_jugadores
FROM 
    jugadores_staging2;

-- 3. Average Goals per Match
SELECT 
    AVG(goles_equipo_1 + goles_equipo_2) AS promedio_goles_por_partido
FROM 
    partidos_staging2;

-- 4. Average Age of Players
SELECT 
    AVG(edad) AS edad_promedio
FROM 
    jugadores_staging2;

-- 5. Average Goals per Team
SELECT 
    equipo, 
    AVG(goles) AS promedio_goles
FROM (
    -- Home team goals
    SELECT equipo_1 AS equipo, goles_equipo_1 AS goles 
    FROM partidos_staging2
    UNION ALL
    -- Away team goals
    SELECT equipo_2 AS equipo, goles_equipo_2 AS goles 
    FROM partidos_staging2
) AS goles_por_equipo
GROUP BY equipo
ORDER BY promedio_goles DESC;

-- 6. Number of Wins per Team
SELECT 
    equipo, 
    COUNT(*) AS victorias
FROM (
    -- Home team victories
    SELECT equipo_1 AS equipo 
    FROM partidos_staging2 
    WHERE goles_equipo_1 > goles_equipo_2
    UNION ALL
    -- Away team victories
    SELECT equipo_2 AS equipo 
    FROM partidos_staging2 
    WHERE goles_equipo_2 > goles_equipo_1
) AS victorias_por_equipo
GROUP BY equipo
ORDER BY victorias DESC;

-- 7. Top 10 Oldest Players
SELECT 
    nombre, 
    edad, 
    equipo
FROM 
    jugadores_staging2
ORDER BY edad DESC
LIMIT 10;

-- 8. Number of Players per Position
SELECT 
    posicion, 
    COUNT(*) AS cantidad
FROM 
    jugadores_staging2
GROUP BY posicion;

-- 9. Total Goals by Month
SELECT 
    YEAR(fecha) AS año, 
    MONTH(fecha) AS mes, 
    SUM(goles_equipo_1 + goles_equipo_2) AS total_goles
FROM 
    partidos_staging2
GROUP BY año, mes
ORDER BY año, mes;

-- 10. Total Goals by Month (excluding NULL dates)
SELECT 
    YEAR(fecha) AS año, 
    MONTH(fecha) AS mes, 
    SUM(goles_equipo_1 + goles_equipo_2) AS total_goles
FROM 
    partidos_staging2
WHERE 
    fecha IS NOT NULL
GROUP BY año, mes
ORDER BY año, mes;

-- 11. Number of Wins per Team by Year
SELECT 
    YEAR(fecha) AS año, 
    equipo, 
    COUNT(*) AS victorias
FROM (
    -- Home team victories by year
    SELECT fecha, equipo_1 AS equipo 
    FROM partidos_staging2 
    WHERE goles_equipo_1 > goles_equipo_2 AND fecha IS NOT NULL
    UNION ALL
    -- Away team victories by year
    SELECT fecha, equipo_2 AS equipo 
    FROM partidos_staging2 
    WHERE goles_equipo_2 > goles_equipo_1 AND fecha IS NOT NULL
) AS victorias
GROUP BY año, equipo
ORDER BY año, victorias DESC;

-- 12. Maximum Goals per Team
SELECT 
    MAX(Goles) AS Max_Goles, 
    equipo
FROM (
    -- Home team goals
    SELECT equipo_1 AS equipo, Goles_equipo_1 AS Goles 
    FROM partidos_staging2
    UNION ALL
    -- Away team goals
    SELECT equipo_2 AS equipo, Goles_equipo_2 AS Goles 
    FROM partidos_staging2
) AS Teams
GROUP BY equipo
ORDER BY Max_Goles DESC;

-- 13. Monthly Goals with Rolling Total
SELECT 
    DATE_FORMAT(fecha, '%Y-%m') AS Month,
    SUM(goles) AS Monthly_Goals,
    SUM(SUM(goles)) OVER (
        ORDER BY DATE_FORMAT(fecha, '%Y-%m') 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Rolling_Total
FROM (
    -- Home team goals
    SELECT fecha, equipo_1 AS equipo, goles_equipo_1 AS goles 
    FROM partidos_staging2 
    WHERE fecha IS NOT NULL
    UNION ALL
    -- Away team goals
    SELECT fecha, equipo_2 AS equipo, goles_equipo_2 AS goles 
    FROM partidos_staging2 
    WHERE fecha IS NOT NULL
) AS All_Goals
GROUP BY Month
ORDER BY Month;



