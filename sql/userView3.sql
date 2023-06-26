--  =================================================
--	File:       userView3.sql
--  Purpose:    Create database User View 3
--  Author:     Yuna Ukawa
--  Date:       May 8, 2023
--  =================================================

USE cityconnect;
SELECT h.date_time AS 'DATETIME',
       h.charges AS 'CHARGES',
       h.credits AS 'CREDITS',
	   h.balance AS 'BALANCE'
FROM customer_history h
WHERE h.customer_id = 350001
ORDER BY h.date_time;