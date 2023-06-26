--  =================================================
--	File:       userView4.sql
--  Purpose:    Create database User View 4
--  Author:     Yuna Ukawa
--  Date:       May 8, 2023
--  =================================================

USE cityconnect;
SELECT t.bus_id AS 'BUS ID',
       r.route_name AS 'ROUTE',
       t.est AS 'EST',
       t.meadow_park AS 'MEADOW',
       t.central_terminal AS 'CENTRAL',
       t.downtown_square AS 'DOWNTOWN',
       t.lake_view AS 'LAKE',
       t.river_reach AS 'RIVER',
       t.west_bridge AS 'WEST'
FROM timetable t, routes r
WHERE t.driver_id = 350001
      AND t.route_id = r.route_id
ORDER BY timetable_id;