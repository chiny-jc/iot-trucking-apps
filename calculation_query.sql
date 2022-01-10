INSERT OVERWRITE TABLE default.driver_riskfactor
  SELECT all_events.driver_id driver_id, all_events.all_events total_events, 
  			CASE 
	  			WHEN abnormal_events.abnormal_events IS NULL THEN 0 
	  			ELSE abnormal_events.abnormal_events 
			END AS abnormal_events, ((
			CASE 
	  			WHEN abnormal_events.abnormal_events IS NULL THEN 0 
	  			ELSE abnormal_events.abnormal_events 
			END)/all_events.all_events) risk_factor,
	  		CASE
		  		WHEN (abnormal_events.abnormal_events/all_events.all_events) > 0.66 THEN 'high'
		  		WHEN (abnormal_events.abnormal_events/all_events.all_events) < 0.33 THEN 'low'
		  		WHEN (abnormal_events.abnormal_events/all_events.all_events) IS NULL THEN 'low'
		  		ELSE 'medium'
	  		END AS risk_level
  FROM (
	SELECT driver_id, sum(event_count) all_events 
	FROM driver_events 
	GROUP BY driver_id) AS all_events
  LEFT JOIN (
	SELECT driver_id, sum(event_count) abnormal_events 
	FROM driver_events 
	WHERE event_type <> 'Normal' 
	GROUP BY driver_id) AS abnormal_events
  ON all_events.driver_id = abnormal_events.driver_id
  ORDER BY 1;