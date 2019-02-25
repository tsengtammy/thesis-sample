
* This do file: IV specifications for P&S and Boustan
* Author: Tammy Tseng
* Date: 2/22/2019

clear all
set more off

local path "/Users/tsengtammy/Dropbox/3 TT/4. Thesis"
cd "`path'"


*--------- TABLE 1: P&S -- IV ---------*

eststo clear	
	
	** 1. 1981 data, 80 instrument
	
		import delimited using "`path'/build/data/output/enrollment_IV_SD_80base.csv", clear
		
		gen lhs = white_tt1 / total_tt1
		gen rhs = asian_tt1 / total_tt1
		gen inst = hat_asian_tt1 / total_tt1
		
		la var rhs "Share Delta Asian"
		la var inst "Predicted Share Delta Asian"
		
		
		// first stage
		eststo: reghdfe rhs inst [aweight=total], absorb(year cdcode) vce(cluster cdcode) 
		estadd local obs   	= string(e(N),"%9.0fc")
		//estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
		
		// iv
		eststo: reghdfe lhs (rhs = inst) [aweight=total], absorb(year cdcode) vce(cluster cdcode) 
		estadd local obs   	= string(e(N),"%9.0fc")
		estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
	
	** 2. 1994 data, 90 instrument
	
		import delimited using "`path'/build/data/output/enrollment_IV_SD_90base.csv", clear
		drop if year < 1994
		
		gen lhs = white_tt1 / total_tt1
		gen rhs = asian_tt1 / total_tt1
		gen inst = hat_asian_tt1 / total_tt1
		
		la var rhs "Share Delta Asian"
		la var inst "Predicted Share Delta Asian"
		
		// first stage
		eststo: reghdfe rhs inst [aweight=total], absorb(year cdcode) vce(cluster cdcode) 
		estadd local obs   	= string(e(N),"%9.0fc")
		//estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
		
		// iv
		eststo: reghdfe lhs (rhs = inst) [aweight=total], absorb(year cdcode) vce(cluster cdcode) 
		estadd local obs   	= string(e(N),"%9.0fc")
		estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
	
	** 3. 1994 data, 80 instrument
	
		import delimited using "`path'/build/data/output/enrollment_IV_SD_80base.csv", clear
		drop if year < 1994
		
		gen lhs = white_tt1 / total_tt1
		gen rhs = asian_tt1 / total_tt1
		gen inst = hat_asian_tt1 / total_tt1
		
		la var rhs "Share Delta Asian"
		la var inst "Predicted Share Delta Asian"
		
		// first stage
		eststo: reghdfe rhs inst [aweight=total], absorb(year cdcode) vce(cluster cdcode) 
		estadd local obs   	= string(e(N),"%9.0fc")
		//estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
		
		// iv
		eststo: reghdfe lhs (rhs = inst) [aweight=total], absorb(year cdcode) vce(cluster cdcode) 
		estadd local obs   	= string(e(N),"%9.0fc")
		estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
	
	
// Est out
	
	#d;
	esttab *
		using "`path'/analysis/output/PS_IV.tex",
		replace se wrap noobs constant
		nomtitles booktabs fragment nonumber nodep
		scalars("obs N"  "year_FE Year FE" "region_FE District FE" "weight District Size Weights" "wid Weak identification" "adjusted_r2 Adjusted R2" )  
		star(* .10 ** .05 *** .01);
	#d cr
	
	
	
*--------- TABLE 2: Boustan -- IV ---------*


eststo clear	
	
	** 1. 1981 data, 80 instrument
	
		import delimited using "`path'/build/data/output/enrollment_IV_SD_80base.csv", clear
		
		// first stage
		eststo: reghdfe asian hat_asian_tt1 county_population [aweight=total], absorb(year cdcode) vce(cluster cdcode) 
		estadd local obs   	= string(e(N),"%9.0fc")
		//estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
		
		// iv
		eststo: reghdfe white county_population (asian = hat_asian_tt1) [aweight=total], absorb(year cdcode) vce(cluster cdcode)
		estadd local obs   	= string(e(N),"%9.0fc")
		estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
	
	** 2. 1994 data, 90 instrument
	
		import delimited using "`path'/build/data/output/enrollment_IV_SD_90base.csv", clear
		drop if year < 1994
		
		// first stage
		eststo: reghdfe asian hat_asian_tt1 county_population [aweight=total], absorb(year cdcode) vce(cluster cdcode) 
		estadd local obs   	= string(e(N),"%9.0fc")
		//estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
		
		// iv
		eststo: reghdfe white county_population (asian = hat_asian_tt1) [aweight=total], absorb(year cdcode) vce(cluster cdcode)
		estadd local obs   	= string(e(N),"%9.0fc")
		estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
	
	** 3. 1994 data, 80 instrument
	
		import delimited using "`path'/build/data/output/enrollment_IV_SD_80base.csv", clear
		drop if year < 1994
		
		// first stage
		eststo: reghdfe asian hat_asian_tt1 county_population [aweight=total], absorb(year cdcode) vce(cluster cdcode)
		estadd local obs   	= string(e(N),"%9.0fc")
		//estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
		
		// iv
		eststo: reghdfe white county_population (asian = hat_asian_tt1) [aweight=total], absorb(year cdcode) vce(cluster cdcode) 
		estadd local obs   	= string(e(N),"%9.0fc")
		estadd local wid 	= string(e(widstat), "%9.2fc")
		estadd local year_FE "Yes"
		estadd local region_FE "Yes"
		estadd local weight "Yes"
		estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
	
	
// Est out
	
	#d;
	esttab *
		using "`path'/analysis/output/B_IV.tex",
		replace se wrap noobs constant
		nomtitles booktabs fragment nonumber nodep
		scalars("obs N"  "year_FE Year FE" "region_FE District FE" "weight District Size Weights" "wid Weak identification" "adjusted_r2 Adjusted R2" )  
		star(* .10 ** .05 *** .01);
	#d cr
	
