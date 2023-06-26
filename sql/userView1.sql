--  =================================================
--	File:       userView1.sql
--  Purpose:    Create database User View 1
--  Author:     Yuna Ukawa
--  Date:       May 8, 2023
--  =================================================

USE cityconnect;
SELECT t.central_terminal AS 'DEPARTURE TIME',
       (SELECT stop_num FROM stops WHERE route_id = t.route_id AND station_id = 3) AS 'STOP NUMBER',
       (SELECT station_name FROM stations s JOIN routes r ON r.dest_id = s.station_id WHERE r.route_id = t.route_id) AS 'DESTINATION',
       (SELECT route_name FROM routes WHERE route_id = t.route_id) AS 'ROUTE'
FROM timetable t
WHERE t.central_terminal > '08:00'
ORDER BY t.central_terminal
OFFSET 0 ROWS
FETCH NEXT 5 ROWS ONLY;
