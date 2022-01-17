SELECT		
	sa.id AS "SAID",	
	sa.appointmentnumber AS "App Number",	
	CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime) "SA Sch ST",	
	wt.name AS "WT",	
	sa.status "Status",	
	sa.toplevelterritoryname__c AS "Territory",	
	sa.postalcode "Postal",	
	wo.number_of_forced_reschedules__c AS "Forced Rsch",	
	wo.number_of_member_reschedules__c AS "Member Rsch"	
		
FROM		
	SD_Salesforce2_Fieldservice.serviceappointment sa	
		
	INNER JOIN	
		SD_Salesforce2_Fieldservice.worktype wt  ON wt.id = sa.worktypeid
	INNER JOIN	
		SD_Salesforce2.workorder wo ON wo.id = sa.parentrecordid
	INNER JOIN	
		sd_salesforce2_fieldservice.serviceterritory st ON sa.serviceterritoryid = st.id
	INNER JOIN 	
		sd_salesforce2_fieldservice.operatinghours oh ON st.operatinghoursid = oh.id
WHERE		
		CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime) >= (timestamp '2021-06-29')
		-- CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime) >= (timestamp '2021-01-28') -- Cranberry
		-- CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime) >= (timestamp '2021-02-11') --Hazelwood
	AND	
		CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime) < (timestamp '2021-06-30')
		-- CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime) < (timestamp '2021-01-29') -- Cranberry
		-- CONVERT_TIMEZONE('UTC', oh.timezone,sa.schedstarttime) < (timestamp '2021-02-12') --Hazelwood
	AND	
		sa.status = 'Reschedule'
	AND	
		sa.toplevelterritoryname__c like '%Waukegan%'
		--sa.toplevelterritoryname__c LIKE '%Cranberry%'
		--sa.toplevelterritoryname__c LIKE '%Hazelwood%'
		
	--AND	
		--wt.name like '%Delivery%'
