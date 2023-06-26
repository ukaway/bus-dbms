--  =================================================
--	File:       userView6.sql
--  Purpose:    Create database User View 6
--  Author:     Yuna Ukawa
--  Date:       May 8, 2023
--  =================================================

USE cityconnect;
SELECT f.bus_id AS 'BUS ID',
       b.make AS 'MAKE',
       b.model AS 'MODEL',
       b.yr AS 'YEAR',
       MAX(f.maintenance) AS 'LAST MAINTENANCE'
FROM bus b, fleet_management f
WHERE f.bus_id = b.bus_id
GROUP BY f.bus_id, b.make, b.model, b.yr
ORDER BY f.bus_id;