********************************************************************************
****   Project: COVID-19 State Paper Mergind Data Sets (Latest Update: 07/05/2020)
****   Producer: Wooserk Park
****   Steps: 1. Merging all data sets (State)
****   		  
****   Appendix 1. Statefips (Opportunity Insights Economic Tracker)
****            2. Spending Data Descriptions (Opportunity Insights Economic Tracker)
****
****   Note1: Data from: https://tracktherecovery.org/  
********************************************************************************

global master = "C:\Users\User\Documents\GitHub\EconomicTracker"
global datainput = "C:\Users\User\Documents\GitHub\EconomicTracker\data"
global dataoutput = "C:\Users\User\Documents\GitHub\EconomicTracker\output"

********************************************************************************
** 1. Merging all data sets (State) - Merging all datasets from EconomicTracker       **
********************************************************************************

** 1.1. Load and save files

import delimited "$datainput\GeoIDs - State.csv", clear
save "$dataoutput\GeoID_pop_state_daily.dta", replace

import delimited "$datainput\Affinity - State - Daily.csv", clear
save "$dataoutput\affinity_state_daily.dta", replace

import delimited "$datainput\Burning Glass - State - Weekly.csv", clear
gen day = day_endofweek
**Temporary use the day_endofweek as a day variable - Need to align it later - 07/05/2020 Wooserk **
save "$dataoutput\burningglsass_state_weekly.dta", replace

import delimited "$datainput\Google Mobility - State - Daily.csv", clear
save "$dataoutput\googlemobility_state_daily.dta", replace

import delimited "$datainput\Low Inc Earnings All Businesses - State - Daily.csv", clear
save "$dataoutput\lowincearning_all_state_daily.dta", replace

import delimited "$datainput\Low Inc Earnings Small Businesses - State - Daily.csv", clear
save "$dataoutput\lowincearning_small_state_daily.dta", replace

import delimited "$datainput\Low Inc Emp All Businesses - State - Daily.csv", clear
save "$dataoutput\lowincemp_all_state_daily.dta", replace

import delimited "$datainput\Low Inc Emp Small Businesses - State - Daily.csv", clear
save "$dataoutput\lowincemp_small_state_daily.dta", replace

import delimited "$datainput\UI Claims - State - Weekly.csv", clear
gen day = day_endofweek
**Temporary use the day_endofweek as a day variable - Need to align it later - 07/05/2020 Wooserk **
save "$dataoutput\UIclaims_state_weekly.dta", replace

import delimited "$datainput\Womply Merchants - State - Daily.csv", clear
save "$dataoutput\Womply_merchants_state_daily.dta", replace

import delimited "$datainput\Womply Revenue - State - Daily.csv", clear
save "$dataoutput\Womply_revenues_state_daily.dta", replace

import delimited "$datainput\Zearn - State - Weekly.csv", clear
gen day = day_endofweek
**Temporary use the day_endofweek as a day variable - Need to align it later - 07/05/2020 Wooserk **
save "$dataoutput\Zearn_state_weekly.dta", replace

import delimited "$datainput\COVID Cases - State - Daily.csv", clear
save "$dataoutput\COVIDcases_state_daily.dta", replace

import delimited "$datainput\COVID Deaths - State - Daily.csv", clear
save "$dataoutput\COVIDdeths_state_daily.dta", replace

import delimited "$datainput\COVID Tests - State - Daily.csv", clear
save "$dataoutput\COVIDtests_state_daily.dta", replace

** Merging **

use "$dataoutput\GeoID_pop_state_daily.dta", clear

merge 1:m statefips using "$dataoutput\affinity_state_daily.dta", nogen
merge 1:1 statefips year month day using "$dataoutput\burningglsass_state_weekly.dta", nogen
merge 1:1 statefips year month day using "$dataoutput\googlemobility_state_daily.dta", nogen
merge 1:1 statefips year month day using "$dataoutput\lowincearning_all_state_daily.dta", nogen
merge 1:1 statefips year month day using "$dataoutput\lowincearning_all_state_daily.dta", nogen
