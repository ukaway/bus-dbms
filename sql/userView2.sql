--  =================================================
--	File:       userView2.sql
--  Purpose:    Create database User View 2
--  Author:     Yuna Ukawa
--  Date:       May 8, 2023
--  =================================================

USE cityconnect;
SELECT h.date_time AS 'DATETIME',
       (SELECT station_name FROM stations WHERE h.enter_station_id = station_id) AS 'ENTER',
       (SELECT station_name FROM stations WHERE h.exit_station_id = station_id) AS 'EXIT',
       h.charges AS 'FARE'
FROM customer_history h
WHERE h.customer_id = 350001
      AND h.enter_station_id IS NOT NULL
ORDER BY h.date_time;
