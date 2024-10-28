-- Objective (1) --

--  number of vehicles stolen each year --
select count(vehicle_id) as 'Number_of_vehicle',
year(date_stolen) as 'Year'
from stolen_vehicles
group by year(date_stolen)
order by year(date_stolen)

----------------------------------------------

--  number of vehicles stolen each month --
select count(vehicle_id) as 'Number_of_vehicle',
month(date_stolen) as 'Month'
from stolen_vehicles
group by month(date_stolen)
order by month(date_stolen)

----------------------------------------------

--  number of vehicles stolen each week --
SELECT COUNT(vehicle_id) AS 'Number_of_vehicle',
IF(WEEK(date_stolen) = 0, 1, WEEK(date_stolen)) AS 'Week'
FROM stolen_vehicles
GROUP BY IF(WEEK(date_stolen) = 0, 1, WEEK(date_stolen))
ORDER BY IF(WEEK(date_stolen) = 0, 1, WEEK(date_stolen))

----------------------------------------------

--  number of vehicles stolen each name day --
SELECT 
COUNT(vehicle_id) AS 'Total_Vehicles',
SUM(CASE WHEN WEEKDAY(date_stolen) = 0 THEN 1 ELSE 0 END) AS 'Monday',
SUM(CASE WHEN WEEKDAY(date_stolen) = 1 THEN 1 ELSE 0 END) AS 'Tuesday',
SUM(CASE WHEN WEEKDAY(date_stolen) = 2 THEN 1 ELSE 0 END) AS 'Wednesday',
SUM(CASE WHEN WEEKDAY(date_stolen) = 3 THEN 1 ELSE 0 END) AS 'Thursday',
SUM(CASE WHEN WEEKDAY(date_stolen) = 4 THEN 1 ELSE 0 END) AS 'Friday',
SUM(CASE WHEN WEEKDAY(date_stolen) = 5 THEN 1 ELSE 0 END) AS 'Saturday',
SUM(CASE WHEN WEEKDAY(date_stolen) = 6 THEN 1 ELSE 0 END) AS 'Sunday'

FROM stolen_vehicles

ORDER BY MONTH(date_stolen);

----------------------------------------------


