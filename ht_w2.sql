--- q1

select
    z1.Zone as PU_zone,
    z2.Zone as DO_zone,
    avg(tpep_dropoff_datetime - tpep_pickup_datetime) as avg_trip
  from trip_data t 
  join taxi_zone z1
  on t.PULocationID = z1.Location_id
  join taxi_zone z2
  on t.DOLocationID = z2.Location_id
  group by 1,2
  order by 3 desc

;


--- q2

select
    z1.Zone as PU_zone,
    z2.Zone as DO_zone,
    avg(tpep_dropoff_datetime - tpep_pickup_datetime) as avg_trip,
    count(1) as trips
  from trip_data t 
  join taxi_zone z1
  on t.PULocationID = z1.Location_id
  join taxi_zone z2
  on t.DOLocationID = z2.Location_id
  group by 1,2
  order by 3 desc

;


--- q3

WITH t AS (
        SELECT MAX(tpep_pickup_datetime) AS latest_pickup_time
        FROM trip_data
    )
select
    z1.Zone as PU_zone,
    count(1) as trips
  from trip_data t 
  join taxi_zone z1
  on t.PULocationID = z1.Location_id
  join taxi_zone z2
  on t.DOLocationID = z2.Location_id
  where tpep_pickup_datetime >= (select latest_pickup_time - interval '17' hour from t)
  and tpep_pickup_datetime <= (select latest_pickup_time from t)
  group by 1
  order by 2 desc

;