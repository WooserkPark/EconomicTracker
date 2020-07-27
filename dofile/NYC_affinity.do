********************************************************************************
****   Project: COVID-19 NYC Paper Affinity Data (Latest Update: 07/27/2020)
****   Producer: Wooserk Park & Rahul Pathak
****   Steps: 1. New York City Sales Data Cleaning
****   
****   Note1: Data from: https://tracktherecovery.org/  
********************************************************************************

global master = "C:\Users\User\Documents\GitHub\EconomicTracker"
global datainput = "C:\Users\User\Documents\GitHub\EconomicTracker\data"
global dataoutput = "C:\Users\User\Documents\GitHub\EconomicTracker\output"

** NYC data **

import delimited "$datainput\Affinity - City - Daily.csv", clear
keep if cityid == 2

export delimited using "$dataoutput\nyc_only_affinity.csv", replace

tostring year, replace format(%04.0f)
tostring month, replace format(%02.0f)
tostring day, replace format(%02.0f)

gen date = year + month + day
destring date, replace
order date spend_all spend_acf spend_aer spend_apg spend_grf spend_hcs spend_tws

replace spend_all = spend_all * 100
replace spend_acf = spend_acf * 100
replace spend_aer = spend_aer * 100
replace spend_apg = spend_apg * 100
replace spend_grf = spend_grf * 100
replace spend_hcs = spend_hcs * 100
replace spend_tws = spend_tws * 100

label variable spend_all "All merchant category"
label variable spend_acf "Accomodation and food service"
label variable spend_aer "Arts, entertainment, and recreation"
label variable spend_apg "General merchandise stores & apparel and accessories"
label variable spend_grf "Grocery and food store"
label variable spend_hcs "Health care and social assistance"
label variable spend_tws "Transportation and warehousing"

twoway (line spend_all date) (line spend_acf date) (line spend_aer date) (line spend_apg date) (line spend_grf date) (line spend_hcs date) (line spend_tws date), ylabel(-100 "-100%" -50 "-50%" 0 "0%" 50 "50%" 100 "100%", labsize(vsmall) angle(horizontal)) xtitle("") xlabel(20200100 "Jan 2020" 20200200 "Feb 2020" 20200300 "Mar 2020" 20200400 "Apr 2020" 20200500 "May 2020" 20200600 "Jun 2020", labsize(vsmall)) title(Percent Chage in All Consumer Spending in New York City, size(small) margin(medium)) note(Sources: Opportunity Insights and Affinity Solutions, size(vsmall) color(gs9)) legend(size(vsmall) region(lwidth(vvthin)))
graph export "$dataoutput\nyc affinity graph.pdf", as(pdf) replace


***newgraph
clear
import delimited "C:\Users\rpathak\Dropbox (Baruch College)\wooserk&rahul\COVID-19 NYC Finance\03_data_collection\affinity cleaning\nyc_only_affinity.csv", varnames(1) 
gen edate1 = mdy(month, day, year)
format edate1 %td
tsset edate1

replace spend_all = spend_all * 100
replace spend_acf = spend_acf * 100
replace spend_aer = spend_aer * 100
replace spend_apg = spend_apg * 100
replace spend_grf = spend_grf * 100
replace spend_hcs = spend_hcs * 100
replace spend_tws = spend_tws * 100


generate ma_spend_all = (F3.spend_all+F2.spend_all+F1.spend_all +spend_all+L1.spend_all+L2.spend_all+L3.spend_all)/7
generate ma_spend_acf = (F3.spend_acf+F2.spend_acf+F1.spend_acf +spend_acf+L1.spend_acf+L2.spend_acf+L3.spend_acf)/7
generate ma_spend_aer = (F3.spend_aer+F2.spend_aer+F1.spend_aer +spend_aer+L1.spend_aer+L2.spend_aer+L3.spend_aer)/7
generate ma_spend_apg = (F3.spend_apg+F2.spend_apg+F1.spend_apg +spend_apg+L1.spend_apg+L2.spend_apg+L3.spend_apg)/7
generate ma_spend_grf = (F3.spend_grf+F2.spend_grf+F1.spend_grf +spend_grf+L1.spend_grf+L2.spend_grf+L3.spend_grf)/7
generate ma_spend_hcs = (F3.spend_hcs+F2.spend_hcs+F1.spend_hcs +spend_hcs+L1.spend_hcs+L2.spend_hcs+L3.spend_hcs)/7
generate ma_spend_tws = (F3.spend_tws+F2.spend_tws+F1.spend_tws +spend_tws+L1.spend_tws+L2.spend_tws+L3.spend_tws)/7

label variable ma_spend_all "All Merchants"
label variable ma_spend_acf "Accomodation & Food "
label variable ma_spend_aer "Entertainment & Recreation"
label variable ma_spend_apg "Apparel & General Merchandise"
label variable ma_spend_grf "Grocery and food store"
label variable ma_spend_hcs "Healthcare & Social Assistance"
label variable ma_spend_tws "Transportation & Warehousing"

twoway tsline ma_spend_all ma_spend_acf ma_spend_aer ma_spend_apg ma_spend_grf ma_spend_hcs ma_spend_tws, sort scheme(s1color) legend(bmargin(zero) width (160) color(gs0) ) tlabel(01feb2020 15feb2020 01mar2020 15mar2020 1apr2020 15apr2020 1may2020 15may2020 1june2020 15june2020, format(%tdmd) grid glwidth(vthin) glcolor(gs10) glpattern(shortdash)) ylabel(-100(25)100,angle(360) grid glwidth(vthin) glcolor(gs10) glpattern(shortdash)) xtitle("") saving(1, replace) 


