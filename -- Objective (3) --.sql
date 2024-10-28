-- Objective (3) --

-- number of vehicles that were stolen in each region --
SELECT L.region,
COUNT(S.vehicle_id) AS 'NumberOfVehicle'
FROM locations L

JOIN stolen_vehicles S
ON L.location_id = S.location_id
group by  L.region

----------------------------------------------

-- Combine the previous output with the population and density statistics for each region --
SELECT L.region,
L.population,
L.density,
COUNT(S.vehicle_id) AS 'NumberOfVehicle'
FROM locations L

JOIN stolen_vehicles S
ON L.location_id = S.location_id
group by  L.region, L.population, L.density


----------------------------------------------

-- Do the types of vehicles stolen in the three most dense regions differ from the three least dense regions? --
SELECT L.region,
L.population,
L.density,
S.vehicle_type,
COUNT(S.vehicle_id) AS 'NumberOfVehicle'
FROM locations L

JOIN stolen_vehicles S
ON L.location_id = S.location_id

WHERE S.vehicle_type IS NOT NULL
group by  L.region, L.population, L.density, S.vehicle_type
ORDER BY L.density

----------------------------------------------
SELECT L.region,
L.density,
COUNT(S.vehicle_id) AS 'NumberOfVehicle'
FROM locations L

JOIN stolen_vehicles S
ON L.location_id = S.location_id
group by  L.region, L.density
ORDER BY L.density
