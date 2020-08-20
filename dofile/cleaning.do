********************************************************************************
****   Project: Economic Tracker Data Cleaning (Latest Update: 08/13/2020)
****   Producer: Wooserk Park & Rahul Pathak
****   Steps: 1. Cleaning all the sets of data
****   
****   Note1: Data from: https://tracktherecovery.org/  
********************************************************************************

global master = "C:\Users\User\Documents\GitHub\EconomicTracker"
global datainput = "C:\Users\User\Documents\GitHub\EconomicTracker\data"
global dataoutput = "C:\Users\User\Documents\GitHub\EconomicTracker\output"

********************************************************************************
**** Step 1. Cleaning all the sets of data (Producing Weekly Data Sets)
********************************************************************************

**** 1.1. Weekly Data ****

**** 1.1.1. Affinity Data ******************************************************
	import delimited "$datainput\Affinity - City - Weekly.csv", clear
		gen statefips = .
		gen national = .
		order year month day_endofweek cityid statefips national
	save "$dataoutput\Affinity - City - Weekly.dta", replace
	** Affinity by City **
	import delimited "$datainput\Affinity - State - Weekly.csv", clear
		gen cityid = .
		gen national = .
		order year month day_endofweek cityid statefips national
	save "$dataoutput\Affinity - State - Weekly.dta", replace
	** Affinity by State **
	import delimited "$datainput\Affinity - National - Weekly.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day_endofweek cityid statefips national
	save "$dataoutput\Affinity - National - Weekly.dta", replace
	** Affinity by National **
	
	** Appending **
	use "$dataoutput\Affinity - City - Weekly.dta", clear
		append using "$dataoutput\Affinity - State - Weekly.dta"
		append using "$dataoutput\Affinity - National - Weekly.dta"
		replace spend_all = spend_all * 100
		replace spend_acf = spend_acf * 100
		replace spend_aer = spend_aer * 100
		replace spend_apg = spend_apg * 100
		replace spend_grf = spend_grf * 100
		replace spend_hcs = spend_hcs * 100
		replace spend_tws = spend_tws * 100
	save "$dataoutput\Affinity_combined.dta", replace
********************************************************************************

**** 1.1.2. Burning Glass Data *************************************************
	import delimited "$datainput\Burning Glass - City - Weekly.csv", clear
		gen statefips = .
		gen national = .
		order year month day_endofweek cityid statefips national
	save "$dataoutput\Burning Glass - City - Weekly.dta", replace
	** Burning Glass by City (Job Postings) **
	import delimited "$datainput\Burning Glass - State - Weekly.csv", clear
		gen cityid = .
		gen national = .
		order year month day_endofweek cityid statefips national
	save "$dataoutput\Burning Glass - State - Weekly.dta", replace
	** Burning Glass by State (Job Postings) **
	import delimited "$datainput\Burning Glass - National - Weekly.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day_endofweek cityid statefips national
	save "$dataoutput\Burning Glass - National - Weekly.dta", replace
	** Burning Glass by National (Job Postings) **
	
	** Appending **
	use "$dataoutput\Burning Glass - City - Weekly.dta", clear
		append using "$dataoutput\Burning Glass - State - Weekly.dta"
		append using "$dataoutput\Burning Glass - National - Weekly.dta"
		replace bg_posts = bg_posts * 100   
		replace bg_posts_ss30 = bg_posts_ss30 * 100
		replace bg_posts_ss55 = bg_posts_ss55 * 100
		replace bg_posts_ss60 = bg_posts_ss60 * 100
		replace bg_posts_ss65 = bg_posts_ss65 * 100
		replace bg_posts_ss70 = bg_posts_ss70 * 100
		replace bg_posts_jz1 = bg_posts_jz1 * 100
		replace bg_posts_jz2 = bg_posts_jz2 * 100             
		replace bg_posts_jz3 = bg_posts_jz3 * 100
		replace bg_posts_jz4 = bg_posts_jz4 * 100
		replace bg_posts_jz5 = bg_posts_jz5 * 100
		replace bg_posts_jzgrp12 = bg_posts_jzgrp12 * 100
		replace bg_posts_jzgrp345 = bg_posts_jzgrp345 * 100
	save "$dataoutput\Burning_Glass_combined.dta", replace
********************************************************************************
	
**** 1.1.3. UI Claim Data *************************************************
	import delimited "$datainput\UI Claims - City - Weekly.csv", clear
		gen statefips = .
		gen national = .
		order year month day_endofweek cityid statefips national
		save "$dataoutput\UI Claims - City - Weekly.dta", replace
	** Unemployment Claim by City **
	import delimited "$datainput\UI Claims - State - Weekly.csv", clear
		gen cityid = .
		gen national = .
		order year month day_endofweek cityid statefips national
	save "$dataoutput\UI Claims - State - Weekly.dta", replace
	** Unemployment Claim by State **
	import delimited "$datainput\UI Claims - National - Weekly.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day_endofweek cityid statefips national
	save "$dataoutput\UI Claims - National - Weekly.dta", replace
	** Unemployment Claim by National **

	** Appending **
	use "$dataoutput\UI Claims - City - Weekly.dta", clear
		append using "$dataoutput\UI Claims - State - Weekly.dta"
		append using "$dataoutput\UI Claims - National - Weekly.dta"
	save "$dataoutput\UI_Claims_combined.dta", replace
********************************************************************************

**** 1.1.4. Zearn *************************************************
	import delimited "$datainput\Zearn - City - Weekly.csv", clear
		gen statefips = .
		gen national = .
		order year month day_endofweek cityid statefips national
		save "$dataoutput\Zearn - City - Weekly.dta", replace
	** Unemployment Claim by City **
	import delimited "$datainput\Zearn - State - Weekly.csv", clear
		gen cityid = .
		gen national = .
		order year month day_endofweek cityid statefips national
	save "$dataoutput\Zearn - State - Weekly.dta", replace
	** Unemployment Claim by State **
	import delimited "$datainput\Zearn - National - Weekly.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day_endofweek cityid statefips national
	save "$dataoutput\Zearn - National - Weekly.dta", replace
	** Unemployment Claim by National **

	** Appending **
	use "$dataoutput\Zearn - City - Weekly.dta", clear
		append using "$dataoutput\Zearn - State - Weekly.dta"
		append using "$dataoutput\Zearn - National - Weekly.dta"
		
		replace engagement = engagement * 100           
		replace badges = badges * 100
		replace engagement_inchigh = engagement_inchigh * 100
		replace badges_inchigh = badges_inchigh * 100
		replace engagement_inclow = engagement_inclow * 100
		replace badges_inclow = badges_inclow * 100
		replace engagement_incmiddle = engagement_incmiddle * 100
		replace badges_incmiddle = badges_incmiddle * 100    
		
	save "$dataoutput\Zearn_combined.dta", replace
********************************************************************************

*** Note: Since this part (data cleaning), I need to make other sets of data weekly versions 
***		  because Economic Tracker only provides daily data.

	
**** 1.1.5. Google Mobility Data *************************************************
	import delimited "$datainput\Google Mobility - City - Daily.csv", clear
		gen statefips = .
		gen national = .
		order year month day cityid statefips national
		save "$dataoutput\Google Mobility - City - Daily.dta", replace
	** Unemployment Claim by City **
	import delimited "$datainput\Google Mobility - State - Daily.csv", clear
		gen cityid = .
		gen national = .
		order year month day cityid statefips national
	save "$dataoutput\Google Mobility - State - Daily.dta", replace
	** Unemployment Claim by State **
	import delimited "$datainput\Google Mobility - National - Daily.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day cityid statefips national
	save "$dataoutput\Google Mobility - National - Daily.dta", replace
	** Unemployment Claim by National **

	** Appending **
	use "$dataoutput\Google Mobility - City - Daily.dta", clear
		append using "$dataoutput\Google Mobility - State - Daily.dta"
		append using "$dataoutput\Google Mobility - National - Daily.dta"
	
		gen edate1 = mdy(month, day, year)
		format edate1 %td
		tsset edate1 cityid // Need to FIX this part later - Wooserk as of Aug 13, 2020
		
		generate ma_gps_retail_and_recreation = (F3.gps_retail_and_recreation+F2.gps_retail_and_recreation+F1.gps_retail_and_recreation +gps_retail_and_recreation+L1.gps_retail_and_recreation+L2.gps_retail_and_recreation+L3.gps_retail_and_recreation)/7 * 100  
		generate ma_gps_grocery_and_pharmacy = (F3.gps_grocery_and_pharmacy+F2.gps_grocery_and_pharmacy+F1.gps_grocery_and_pharmacy +gps_grocery_and_pharmacy+L1.gps_grocery_and_pharmacy+L2.gps_grocery_and_pharmacy+L3.gps_grocery_and_pharmacy)/7 * 100       
		generate ma_gps_parks = (F3.gps_parks+F2.gps_parks+F1.gps_parks +gps_parks+L1.gps_parks+L2.gps_parks+L3.gps_parks)/7 * 100 
		generate ma_gps_transit_stations = (F3.gps_transit_stations+F2.gps_transit_stations+F1.gps_transit_stations +gps_transit_stations+L1.gps_transit_stations+L2.gps_transit_stations+L3.gps_transit_stations)/7 * 100
		generate ma_gps_workplaces = (F3.gps_workplaces+F2.gps_workplaces+F1.gps_workplaces +gps_workplaces+L1.gps_workplaces+L2.gps_workplaces+L3.gps_workplaces)/7 * 100
		generate ma_gps_residential = (F3.gps_residential+F2.gps_residential+F1.gps_residential +gps_residential+L1.gps_residential+L2.gps_residential+L3.gps_residential)/7 * 100
		generate ma_gps_away_from_home = (F3.gps_away_from_home+F2.gps_away_from_home+F1.gps_away_from_home +gps_away_from_home+L1.gps_away_from_home+L2.gps_away_from_home+L3.gps_away_from_home)/7 * 100
		drop if ma_gps_retail_and_recreation == .
		** moving average **
		
		gen int day_of_week = dow(edate1)
		gen int saturday_close = edate1 + 6 - day_of_week if day_of_week <= 6
		replace saturday_close = edate1 + 13 - day_of_week if day_of_week > 6
		format saturday_close %td
		keep if edate1 == saturday_close
		rename day day_endofweek
		drop day_of_week saturday_close gps_retail_and_recreation gps_grocery_and_pharmacy gps_parks gps_transit_stations gps_workplaces gps_residential gps_away_from_home edate1
		** weekly average ** 
				
	save "$dataoutput\Google_Mobility_combined.dta", replace
********************************************************************************

**** 1.1.6. Low Inc Earnings All Businesses ************************************
	import delimited "$datainput\Low Inc Earnings All Businesses - City - Daily.csv", clear
		gen statefips = .
		gen national = .
		order year month day cityid statefips national
		save "$dataoutput\Low Inc Earnings All Businesses - City - Daily.dta", replace
	** Unemployment Claim by City **
	import delimited "$datainput\Low Inc Earnings All Businesses - State - Daily.csv", clear
		gen cityid = .
		gen national = .
		order year month day cityid statefips national
	save "$dataoutput\Low Inc Earnings All Businesses - State - Daily.dta", replace
	** Unemployment Claim by State **
	import delimited "$datainput\Low Inc Earnings All Businesses - National - Daily.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day cityid statefips national
	save "$dataoutput\Low Inc Earnings All Businesses - National - Daily.dta", replace
	** Unemployment Claim by National **

	** Appending **
	use "$dataoutput\Low Inc Earnings All Businesses - City - Daily.dta", clear
		append using "$dataoutput\Low Inc Earnings All Businesses - State - Daily.dta"
		append using "$dataoutput\Low Inc Earnings All Businesses - National - Daily.dta"
	
		gen edate1 = mdy(month, day, year)
		format edate1 %td
		tsset edate1 cityid
		
		generate ma_pay_all = (F3.pay+F2.pay+F1.pay +pay+L1.pay+L2.pay+L3.pay)/7 * 100  
		generate ma_pay31_33_all = (F3.pay31_33+F2.pay31_33+F1.pay31_33 +pay31_33+L1.pay31_33+L2.pay31_33+L3.pay31_33)/7 * 100       
		generate ma_pay44_45_all = (F3.pay44_45+F2.pay44_45+F1.pay44_45 +pay44_45+L1.pay44_45+L2.pay44_45+L3.pay44_45)/7 * 100 
		generate ma_pay48_49_all = (F3.pay48_49+F2.pay48_49+F1.pay48_49 +pay48_49+L1.pay48_49+L2.pay48_49+L3.pay48_49)/7 * 100
		generate ma_pay62_all = (F3.pay62+F2.pay62+F1.pay62 +pay62+L1.pay62+L2.pay62+L3.pay62)/7 * 100
		generate ma_pay72_all = (F3.pay72+F2.pay72+F1.pay72 +pay72+L1.pay72+L2.pay72+L3.pay72)/7 * 100
		generate ma_pay_inclow_all = (F3.pay_inclow+F2.pay_inclow+F1.pay_inclow +pay_inclow+L1.pay_inclow+L2.pay_inclow+L3.pay_inclow)/7 * 100
		generate ma_pay_incmiddle_all = (F3.pay_incmiddle+F2.pay_incmiddle+F1.pay_incmiddle +pay_incmiddle+L1.pay_incmiddle+L2.pay_incmiddle+L3.pay_incmiddle)/7 * 100
		generate ma_pay_inchigh_all = (F3.pay_inchigh+F2.pay_inchigh+F1.pay_inchigh +pay_inchigh+L1.pay_inchigh+L2.pay_inchigh+L3.pay_inchigh)/7 * 100
		drop if ma_pay_all == .
		** moving average **
		
		gen int day_of_week = dow(edate1)
		gen int saturday_close = edate1 + 6 - day_of_week if day_of_week <= 6
		replace saturday_close = edate1 + 13 - day_of_week if day_of_week > 6 
		format saturday_close %td
		keep if edate1 == saturday_close
		rename day day_endofweek
		drop day_of_week saturday_close edate1 pay pay31_33 pay44_45 pay48_49 pay62 pay72 pay_inclow pay_incmiddle pay_inchigh
		** weekly average ** 
				
	save "$dataoutput\Low_Inc_Earnings_All_Businesses_combined.dta", replace
********************************************************************************

**** 1.1.7. Low Inc Earnings Small Businesses **********************************
	import delimited "$datainput\Low Inc Earnings Small Businesses - City - Daily.csv", clear
		gen statefips = .
		gen national = .
		order year month day cityid statefips national
		save "$dataoutput\Low Inc Earnings Small Businesses - City - Daily.dta", replace
	** Unemployment Claim by City **
	import delimited "$datainput\Low Inc Earnings Small Businesses - State - Daily.csv", clear
		gen cityid = .
		gen national = .
		order year month day cityid statefips national
	save "$dataoutput\Low Inc Earnings Small Businesses - State - Daily.dta", replace
	** Unemployment Claim by State **
	import delimited "$datainput\Low Inc Earnings Small Businesses - National - Daily.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day cityid statefips national
	save "$dataoutput\Low Inc Earnings Small Businesses - National - Daily.dta", replace
	** Unemployment Claim by National **

	** Appending **
	use "$dataoutput\Low Inc Earnings Small Businesses - City - Daily.dta", clear
		append using "$dataoutput\Low Inc Earnings Small Businesses - State - Daily.dta"
		append using "$dataoutput\Low Inc Earnings Small Businesses - National - Daily.dta"
	
		gen edate1 = mdy(month, day, year)
		format edate1 %td
		tsset edate1 cityid
		
		generate ma_pay_small = (F3.pay+F2.pay+F1.pay +pay+L1.pay+L2.pay+L3.pay)/7 * 100  
		generate ma_pay31_33_small = (F3.pay31_33+F2.pay31_33+F1.pay31_33 +pay31_33+L1.pay31_33+L2.pay31_33+L3.pay31_33)/7 * 100       
		generate ma_pay44_45_small = (F3.pay44_45+F2.pay44_45+F1.pay44_45 +pay44_45+L1.pay44_45+L2.pay44_45+L3.pay44_45)/7 * 100 
		generate ma_pay48_49_small = (F3.pay48_49+F2.pay48_49+F1.pay48_49 +pay48_49+L1.pay48_49+L2.pay48_49+L3.pay48_49)/7 * 100
		generate ma_pay62_small = (F3.pay62+F2.pay62+F1.pay62 +pay62+L1.pay62+L2.pay62+L3.pay62)/7 * 100
		generate ma_pay72_small = (F3.pay72+F2.pay72+F1.pay72 +pay72+L1.pay72+L2.pay72+L3.pay72)/7 * 100
		generate ma_pay_inclow_small = (F3.pay_inclow+F2.pay_inclow+F1.pay_inclow +pay_inclow+L1.pay_inclow+L2.pay_inclow+L3.pay_inclow)/7 * 100
		generate ma_pay_incmiddle_small = (F3.pay_incmiddle+F2.pay_incmiddle+F1.pay_incmiddle +pay_incmiddle+L1.pay_incmiddle+L2.pay_incmiddle+L3.pay_incmiddle)/7 * 100
		generate ma_pay_inchigh_small = (F3.pay_inchigh+F2.pay_inchigh+F1.pay_inchigh +pay_inchigh+L1.pay_inchigh+L2.pay_inchigh+L3.pay_inchigh)/7 * 100
		drop if ma_pay_small == .
		** moving average **
		
		gen int day_of_week = dow(edate1)
		gen int saturday_close = edate1 + 6 - day_of_week if day_of_week <= 6
		replace saturday_close = edate1 + 13 - day_of_week if day_of_week > 6 
		format saturday_close %td
		keep if edate1 == saturday_close
		rename day day_endofweek
		drop day_of_week saturday_close edate1 pay pay31_33 pay44_45 pay48_49 pay62 pay72 pay_inclow pay_incmiddle pay_inchigh
		** weekly average ** 
				
	save "$dataoutput\Low_Inc_Earnings_Small_Businesses_combined.dta", replace
********************************************************************************

**** 1.1.8. Low Inc Emp All Businesses  ****************************************
	import delimited "$datainput\Low Inc Emp All Businesses - City - Daily.csv", clear
		gen statefips = .
		gen national = .
		order year month day cityid statefips national
		save "$dataoutput\Low Inc Emp All Businesses - City - Daily.dta", replace
	** Unemployment Claim by City **
	import delimited "$datainput\Low Inc Emp All Businesses - State - Daily.csv", clear
		gen cityid = .
		gen national = .
		order year month day cityid statefips national
	save "$dataoutput\Low Inc Emp All Businesses - State - Daily.dta", replace
	** Unemployment Claim by State **
	import delimited "$datainput\Low Inc Emp All Businesses - National - Daily.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day cityid statefips national
	save "$dataoutput\Low Inc Emp All Businesses - National - Daily.dta", replace
	** Unemployment Claim by National **

	** Appending **
	use "$dataoutput\Low Inc Emp All Businesses - City - Daily.dta", clear
		append using "$dataoutput\Low Inc Emp All Businesses - State - Daily.dta"
		append using "$dataoutput\Low Inc Emp All Businesses - National - Daily.dta"
	
		gen edate1 = mdy(month, day, year)
		format edate1 %td
		tsset edate1 cityid
		
		generate ma_emp_all = (F3.emp+F2.emp+F1.emp +emp+L1.emp+L2.emp+L3.emp)/7 * 100  
		generate ma_emp31_33_all = (F3.emp31_33+F2.emp31_33+F1.emp31_33 +emp31_33+L1.emp31_33+L2.emp31_33+L3.emp31_33)/7 * 100       
		generate ma_emp44_45_all = (F3.emp44_45+F2.emp44_45+F1.emp44_45 +emp44_45+L1.emp44_45+L2.emp44_45+L3.emp44_45)/7 * 100 
		generate ma_emp48_49_all = (F3.emp48_49+F2.emp48_49+F1.emp48_49 +emp48_49+L1.emp48_49+L2.emp48_49+L3.emp48_49)/7 * 100
		generate ma_emp62_all = (F3.emp62+F2.emp62+F1.emp62 +emp62+L1.emp62+L2.emp62+L3.emp62)/7 * 100
		generate ma_emp72_all = (F3.emp72+F2.emp72+F1.emp72 +emp72+L1.emp72+L2.emp72+L3.emp72)/7 * 100
		generate ma_emp_inclow_all = (F3.emp_inclow+F2.emp_inclow+F1.emp_inclow +emp_inclow+L1.emp_inclow+L2.emp_inclow+L3.emp_inclow)/7 * 100
		generate ma_emp_incmiddle_all = (F3.emp_incmiddle+F2.emp_incmiddle+F1.emp_incmiddle +emp_incmiddle+L1.emp_incmiddle+L2.emp_incmiddle+L3.emp_incmiddle)/7 * 100
		generate ma_emp_inchigh_all = (F3.emp_inchigh+F2.emp_inchigh+F1.emp_inchigh +emp_inchigh+L1.emp_inchigh+L2.emp_inchigh+L3.emp_inchigh)/7 * 100
		drop if ma_emp_all == .
		** moving average **
		
		gen int day_of_week = dow(edate1)
		gen int saturday_close = edate1 + 6 - day_of_week if day_of_week <= 6
		replace saturday_close = edate1 + 13 - day_of_week if day_of_week > 6  
		format saturday_close %td
		keep if edate1 == saturday_close
		rename day day_endofweek
		drop day_of_week saturday_close edate1 emp emp31_33 emp44_45 emp48_49 emp62 emp72 emp_inclow emp_incmiddle emp_inchigh
		** weekly average ** 
				
	save "$dataoutput\Low_Inc_Emp_All_Businesses_combined.dta", replace
********************************************************************************

**** 1.1.9. Low Inc Emp Small Businesses ***************************************
	import delimited "$datainput\Low Inc Emp Small Businesses - City - Daily.csv", clear
		gen statefips = .
		gen national = .
		order year month day cityid statefips national
		save "$dataoutput\Low Inc Emp Small Businesses - City - Daily.dta", replace
		
	import delimited "$datainput\Low Inc Emp Small Businesses - State - Daily.csv", clear
		gen cityid = .
		gen national = .
		order year month day cityid statefips national
	save "$dataoutput\Low Inc Emp Small Businesses - State - Daily.dta", replace
	
	import delimited "$datainput\Low Inc Emp Small Businesses - National - Daily.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day cityid statefips national
	save "$dataoutput\Low Inc Emp Small Businesses - National - Daily.dta", replace

	** Appending **
	use "$dataoutput\Low Inc Emp Small Businesses - City - Daily.dta", clear
		append using "$dataoutput\Low Inc Emp Small Businesses - State - Daily.dta"
		append using "$dataoutput\Low Inc Emp Small Businesses - National - Daily.dta"
	
		gen edate1 = mdy(month, day, year)
		format edate1 %td
		tsset edate1 cityid
		
		generate ma_emp_small = (F3.emp+F2.emp+F1.emp +emp+L1.emp+L2.emp+L3.emp)/7 * 100  
		generate ma_emp31_33_small = (F3.emp31_33+F2.emp31_33+F1.emp31_33 +emp31_33+L1.emp31_33+L2.emp31_33+L3.emp31_33)/7 * 100       
		generate ma_emp44_45_small = (F3.emp44_45+F2.emp44_45+F1.emp44_45 +emp44_45+L1.emp44_45+L2.emp44_45+L3.emp44_45)/7 * 100 
		generate ma_emp48_49_small = (F3.emp48_49+F2.emp48_49+F1.emp48_49 +emp48_49+L1.emp48_49+L2.emp48_49+L3.emp48_49)/7 * 100
		generate ma_emp62_small = (F3.emp62+F2.emp62+F1.emp62 +emp62+L1.emp62+L2.emp62+L3.emp62)/7 * 100
		generate ma_emp72_small = (F3.emp72+F2.emp72+F1.emp72 +emp72+L1.emp72+L2.emp72+L3.emp72)/7 * 100
		generate ma_emp_inclow_small = (F3.emp_inclow+F2.emp_inclow+F1.emp_inclow +emp_inclow+L1.emp_inclow+L2.emp_inclow+L3.emp_inclow)/7 * 100
		generate ma_emp_incmiddle_small = (F3.emp_incmiddle+F2.emp_incmiddle+F1.emp_incmiddle +emp_incmiddle+L1.emp_incmiddle+L2.emp_incmiddle+L3.emp_incmiddle)/7 * 100
		generate ma_emp_inchigh_small = (F3.emp_inchigh+F2.emp_inchigh+F1.emp_inchigh +emp_inchigh+L1.emp_inchigh+L2.emp_inchigh+L3.emp_inchigh)/7 * 100
		drop if ma_emp_small == .
		** moving average **
		
		gen int day_of_week = dow(edate1)
		gen int saturday_close = edate1 + 6 - day_of_week if day_of_week <= 6
		replace saturday_close = edate1 + 13 - day_of_week if day_of_week > 6  
		format saturday_close %td
		keep if edate1 == saturday_close
		rename day day_endofweek
		drop day_of_week saturday_close edate1 emp emp31_33 emp44_45 emp48_49 emp62 emp72 emp_inclow emp_incmiddle emp_inchigh
		** weekly average ** 
				
	save "$dataoutput\Low_Inc_Emp_Small_Businesses_combined.dta", replace
********************************************************************************

**** 1.1.10. Womply Merchants  *************************************************
	import delimited "$datainput\Womply Merchants - City - Daily.csv", clear
		gen statefips = .
		gen national = .
		order year month day cityid statefips national
		save "$dataoutput\Womply Merchants - City - Daily.dta", replace
		
	import delimited "$datainput\Womply Merchants - State - Daily.csv", clear
		gen cityid = .
		gen national = .
		order year month day cityid statefips national
	save "$dataoutput\Womply Merchants - State - Daily.dta", replace
	
	import delimited "$datainput\Womply Merchants - National - Daily.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day cityid statefips national
	save "$dataoutput\Womply Merchants - National - Daily.dta", replace

	** Appending **
	use "$dataoutput\Womply Merchants - City - Daily.dta", clear
		append using "$dataoutput\Womply Merchants - State - Daily.dta"
		append using "$dataoutput\Womply Merchants - National - Daily.dta"
	
		gen edate1 = mdy(month, day, year)
		format edate1 %td
		tsset edate1 cityid
		
		generate ma_merchants_all = (F3.merchants_all+F2.merchants_all+F1.merchants_all +merchants_all+L1.merchants_all+L2.merchants_all+L3.merchants_all)/7 * 100  
		generate ma_merchants_ss40 = (F3.merchants_ss40+F2.merchants_ss40+F1.merchants_ss40 +merchants_ss40+L1.merchants_ss40+L2.merchants_ss40+L3.merchants_ss40)/7 * 100       
		generate ma_merchants_ss60 = (F3.merchants_ss60+F2.merchants_ss60+F1.merchants_ss60 +merchants_ss60+L1.merchants_ss60+L2.merchants_ss60+L3.merchants_ss60)/7 * 100 
		generate ma_merchants_ss65 = (F3.merchants_ss65+F2.merchants_ss65+F1.merchants_ss65 +merchants_ss65+L1.merchants_ss65+L2.merchants_ss65+L3.merchants_ss65)/7 * 100
		generate ma_merchants_ss70 = (F3.merchants_ss70+F2.merchants_ss70+F1.merchants_ss70 +merchants_ss70+L1.merchants_ss70+L2.merchants_ss70+L3.merchants_ss70)/7 * 100
		generate ma_merchants_inchigh = (F3.merchants_inchigh+F2.merchants_inchigh+F1.merchants_inchigh +merchants_inchigh+L1.merchants_inchigh+L2.merchants_inchigh+L3.merchants_inchigh)/7 * 100
		generate ma_merchants_inclow = (F3.merchants_inclow+F2.merchants_inclow+F1.merchants_inclow +merchants_inclow+L1.merchants_inclow+L2.merchants_inclow+L3.merchants_inclow)/7 * 100
		generate ma_merchants_incmiddle = (F3.merchants_incmiddle+F2.merchants_incmiddle+F1.merchants_incmiddle +merchants_incmiddle+L1.merchants_incmiddle+L2.merchants_incmiddle+L3.merchants_incmiddle)/7 * 100
		drop if ma_merchants_all == . 
		** moving average **
		
		gen int day_of_week = dow(edate1)
		gen int saturday_close = edate1 + 6 - day_of_week if day_of_week <= 6
		replace saturday_close = edate1 + 13 - day_of_week if day_of_week > 6  
		format saturday_close %td 
		keep if edate1 == saturday_close
		rename day day_endofweek
		drop day_of_week saturday_close edate1 merchants_all merchants_ss40 merchants_ss60 merchants_ss65 merchants_ss70 merchants_inchigh merchants_inclow merchants_incmiddle
		** weekly average ** 
				
	save "$dataoutput\Womply_Merchants_combined.dta", replace
********************************************************************************

**** 1.1.11. Womply Revenue ****************************************************
	import delimited "$datainput\Womply Revenue - City - Daily.csv", clear
		gen statefips = .
		gen national = .
		order year month day cityid statefips national
		save "$dataoutput\Womply Revenue - City - Daily.dta", replace
		
	import delimited "$datainput\Womply Revenue - State - Daily.csv", clear
		gen cityid = .
		gen national = .
		order year month day cityid statefips national
	save "$dataoutput\Womply Revenue - State - Daily.dta", replace
	
	import delimited "$datainput\Womply Revenue - National - Daily.csv", clear
		gen cityid = .
		gen statefips = .
		gen national = 1
		order year month day cityid statefips national
	save "$dataoutput\Womply Revenue - National - Daily.dta", replace

	** Appending **
	use "$dataoutput\Womply Revenue - City - Daily.dta", clear
		append using "$dataoutput\Womply Revenue - State - Daily.dta"
		append using "$dataoutput\Womply Revenue - National - Daily.dta"
	
		gen edate1 = mdy(month, day, year)
		format edate1 %td
		tsset edate1 cityid
		
		generate ma_revenue_all = (F3.revenue_all+F2.revenue_all+F1.revenue_all +revenue_all+L1.revenue_all+L2.revenue_all+L3.revenue_all)/7 * 100  
		generate ma_revenue_inchigh = (F3.revenue_inchigh+F2.revenue_inchigh+F1.revenue_inchigh +revenue_inchigh+L1.revenue_inchigh+L2.revenue_inchigh+L3.revenue_inchigh)/7 * 100       
		generate ma_revenue_inclow = (F3.revenue_inclow+F2.revenue_inclow+F1.revenue_inclow +revenue_inclow+L1.revenue_inclow+L2.revenue_inclow+L3.revenue_inclow)/7 * 100 
		generate ma_revenue_incmiddle = (F3.revenue_incmiddle+F2.revenue_incmiddle+F1.revenue_incmiddle +revenue_incmiddle+L1.revenue_incmiddle+L2.revenue_incmiddle+L3.revenue_incmiddle)/7 * 100
		generate ma_revenue_ss40 = (F3.revenue_ss40+F2.revenue_ss40+F1.revenue_ss40 +revenue_ss40+L1.revenue_ss40+L2.revenue_ss40+L3.revenue_ss40)/7 * 100
		generate ma_revenue_ss60 = (F3.revenue_ss60+F2.revenue_ss60+F1.revenue_ss60 +revenue_ss60+L1.revenue_ss60+L2.revenue_ss60+L3.revenue_ss60)/7 * 100
		generate ma_revenue_ss65 = (F3.revenue_ss65+F2.revenue_ss65+F1.revenue_ss65 +revenue_ss65+L1.revenue_ss65+L2.revenue_ss65+L3.revenue_ss65)/7 * 100
		generate ma_revenue_ss70 = (F3.revenue_ss70+F2.revenue_ss70+F1.revenue_ss70 +revenue_ss70+L1.revenue_ss70+L2.revenue_ss70+L3.revenue_ss70)/7 * 100
		drop if ma_revenue_all == . 
		** moving average **
		
		gen int day_of_week = dow(edate1)
		gen int saturday_close = edate1 + 6 - day_of_week if day_of_week <= 6
		replace saturday_close = edate1 + 13 - day_of_week if day_of_week > 6  
		format saturday_close %td 
		keep if edate1 == saturday_close
		rename day day_endofweek
		drop day_of_week saturday_close edate1 revenue_all revenue_inchigh revenue_inclow revenue_incmiddle revenue_ss40 revenue_ss60 revenue_ss65 revenue_ss70
		** weekly average ** 
				
	save "$dataoutput\Womply_Revenue_combined.dta", replace
********************************************************************************

********************************************************************************
**** Step 2. Merging sets of data
********************************************************************************

	use "$dataoutput\Affinity_combined.dta", clear
		merge 1:1 year month day cityid statefips national using "$dataoutput\Burning_Glass_combined.dta", nogen
		merge 1:1 year month day cityid statefips national using "$dataoutput\UI_Claims_combined.dta", nogen
		merge 1:1 year month day cityid statefips national using "$dataoutput\Zearn_combined.dta", nogen
		merge 1:1 year month day cityid statefips national using "$dataoutput\Google_Mobility_combined.dta", nogen
		merge 1:1 year month day cityid statefips national using "$dataoutput\Low_Inc_Earnings_All_Businesses_combined.dta", nogen
		merge 1:1 year month day cityid statefips national using "$dataoutput\Low_Inc_Earnings_Small_Businesses_combined.dta", nogen
		merge 1:1 year month day cityid statefips national using "$dataoutput\Low_Inc_Emp_All_Businesses_combined.dta", nogen
		merge 1:1 year month day cityid statefips national using "$dataoutput\Low_Inc_Emp_Small_Businesses_combined.dta", nogen
		merge 1:1 year month day cityid statefips national using "$dataoutput\Womply_Merchants_combined.dta", nogen
		merge 1:1 year month day cityid statefips national using "$dataoutput\Womply_Revenue_combined.dta", nogen
	save "$dataoutput\economic_tracker_all_combined.dta", replace
