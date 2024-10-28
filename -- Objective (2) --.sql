-- Objective (2) --

-- Number of stolen vehicles for each type --
SELECT COUNT(vehicle_type) AS 'Total_Vehicles',
vehicle_type
from stolen_vehicles
group by vehicle_type
ORDER BY  COUNT(vehicle_type) DESC

----------------------------------------------

-- types that are most often and least often stolen --
SELECT vehicle_type, Total_Vehicles
FROM ( SELECT 
vehicle_type,
COUNT(vehicle_type) AS Total_Vehicles,
RANK() OVER (ORDER BY COUNT(vehicle_type) DESC) AS rank_desc,
RANK() OVER (ORDER BY COUNT(vehicle_type) ASC) AS rank_asc
FROM stolen_vehicles
WHERE vehicle_type IS NOT NULL
GROUP BY vehicle_type
) AS ranked_counts
WHERE rank_desc = 1 OR rank_asc = 1;

----------------------------------------------

-- For each vehicle type, find the average age of the cars that are stolen --
SELECT vehicle_type,
ROUND(AVG( 2024 - model_year),2) AS 'Age'
FROM stolen_vehicles
WHERE vehicle_type IS NOT NULL
GROUP BY vehicle_type
ORDER BY ROUND(AVG( 2024 - model_year),2)

 ----------------------------------------------
 
 -- For each vehicle type, find the percent of vehicles stolen that are luxury versus standard--
SELECT S.vehicle_type,
SUM(CASE WHEN M.make_type = 'Luxury' THEN 1 ELSE 0 END) AS Luxury_Count,
SUM(CASE WHEN M.make_type = 'Standard' THEN 1 ELSE 0 END) AS Standard_Count,
ROUND((SUM(CASE WHEN M.make_type = 'Luxury' THEN 1 ELSE 0 END) * 100.0) / COUNT(vehicle_type), 2) AS Luxury_Percentage,
ROUND((SUM(CASE WHEN M.make_type = 'Standard' THEN 1 ELSE 0 END) * 100.0) / COUNT(vehicle_type), 2) AS Standard_Percentage
 
 FROM stolen_vehicles S
 JOIN make_details M
 ON S.make_id = M.make_id
WHERE vehicle_type IS NOT NULL
GROUP BY vehicle_type

----------------------------------------------
select distiNct color  FROM stolen_vehicles S 

----------------------------------------------

-- Create a table where the rows represent the top 10 vehicle types,
-- the columns represent the top 7 vehicle colors (plus 1 column for all other colors) and
-- the values are the number of vehicles stolen --
WITH TopVehicleTypes AS (
SELECT vehicle_type
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY COUNT(*) DESC
LIMIT 10
)

SELECT 
v.vehicle_type,
SUM(CASE WHEN v.color = 'Red' THEN 1 ELSE 0 END) AS Red,
SUM(CASE WHEN v.color = 'Blue' THEN 1 ELSE 0 END) AS Blue,
SUM(CASE WHEN v.color = 'Black' THEN 1 ELSE 0 END) AS Black,
SUM(CASE WHEN v.color = 'White' THEN 1 ELSE 0 END) AS White,
SUM(CASE WHEN v.color = 'Gray' THEN 1 ELSE 0 END) AS Gray,
SUM(CASE WHEN v.color = 'Silver' THEN 1 ELSE 0 END) AS Silver,
SUM(CASE WHEN v.color = 'Green' THEN 1 ELSE 0 END) AS Green,
SUM(CASE WHEN v.color NOT IN ('Red', 'Blue', 'Black', 'White', 'Gray', 'Silver', 'Green') THEN 1 ELSE 0 END) AS Other_Colors
FROM stolen_vehicles v
JOIN TopVehicleTypes t ON v.vehicle_type = t.vehicle_type
GROUP BY v.vehicle_type
ORDER BY COUNT(*) DESC

