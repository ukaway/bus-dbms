--  =================================================
--	File:       userView5.sql
--  Purpose:    Create database User View 5
--  Author:     Yuna Ukawa
--  Date:       May 8, 2023
--  =================================================

USE cityconnect;
SELECT s.driver_id AS 'DRIVER ID',
       d.driver_name AS 'DRIVER NAME',
       s.hourly AS 'HOURLY WAGE',
       s.hrs AS 'HOUR WORKED',
       s.hourly * s.hrs AS 'SALARY'
FROM salary s, driver d
WHERE s.yr = 2040
      AND s.mnth = 'APR'
      AND s.driver_id = d.driver_id
ORDER BY s.driver_id;