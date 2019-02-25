
* This do file: OLS specifications for P&S and Boustan
* Author: Tammy Tseng
* Date: 2/22/2019

clear all
set more off

local path "/Users/tsengtammy/Dropbox/3 TT/4. Thesis"
cd "`path'"


*--------- TABLE 1: P&S -- OLS -- 1981 DATA ---------*

eststo clear	
	
	// School level (Cols 1-3)
	
		** Clean **
	
			import delimited using "`path'/build/data/output/agg_enrollment_CDS.csv", clear
			
			gen lhs = white_tt1 / total_tt1
			gen rhs = asian_tt1 / total_tt1
			
			la var rhs "Share Delta Asian"
		
		** Regress **
		
			eststo: reg lhs rhs, vce(cluster cds_code) 
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "No"
			estadd local region_FE "No"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe lhs rhs, absorb(year cds_code) vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
				// NOTE: WEIGHT IS TOTAL, NOT TOTAL_TT1 ?
			
			eststo: reghdfe lhs rhs [aweight=total], absorb(year cds_code) vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "Yes"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
	
	// School district level (Cols 4-6)
	
		** Clean **
	
			import delimited using "`path'/build/data/output/agg_enrollment_CD.csv", clear
			
			gen lhs = white_tt1 / total_tt1
			gen rhs = asian_tt1 / total_tt1
			
			la var rhs "Share Delta Asian"
		
		** Regress **
		
			eststo: reg lhs rhs, vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "No"
			estadd local region_FE "No"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe lhs rhs, absorb(year cdcode) vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe lhs rhs [aweight=total], absorb(year cdcode) vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "Yes"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")	
		
	// Est out
	
		#d; 
		esttab est*
			using "`path'/analysis/output/PS_OLS_81.tex",
			replace se wrap noobs constant
			nomtitles booktabs fragment nonumber nodep
			scalars("obs N" "year_FE Year FE" "region_FE Region FE" "weight Weights"  "adjusted_r2 Adjusted R2")  
			star(* .10 ** .05 *** .01);
		#d cr
	
	
*--------- TABLE 2: P&S -- OLS -- 1994 DATA ---------*

eststo clear	
	
	// School level (Cols 1-3)
	
		** Clean **
	
			import delimited using "`path'/build/data/output/agg_enrollment_CDS.csv", clear
			
			drop if year < 1994
			
			gen lhs = white_tt1 / total_tt1
			gen rhs = asian_tt1 / total_tt1
			
			la var rhs "Share Delta Asian"
		
		** Regress **
		
			eststo: reg lhs rhs, vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "No"
			estadd local region_FE "No"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe lhs rhs, absorb(year cds_code) vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe lhs rhs [aweight=total], absorb(year cds_code) vce(cluster  cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "Yes"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
	
	// School district level (Cols 4-6)
	
		** Clean **
	
			import delimited using "`path'/build/data/output/agg_enrollment_CD.csv", clear
			
			drop if year < 1994
			
			gen lhs = white_tt1 / total_tt1
			gen rhs = asian_tt1 / total_tt1
			
			la var rhs "Share Delta Asian"
		
		** Regress **
		
			eststo: reg lhs rhs, vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "No"
			estadd local region_FE "No"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe lhs rhs, absorb(year cdcode) vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe lhs rhs [aweight=total], absorb(year cdcode) vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "Yes"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")	
		
	// Est out
	
		#d; 
		esttab est*
			using "`path'/analysis/output/PS_OLS_94.tex",
			replace se wrap noobs constant
			nomtitles booktabs fragment nonumber nodep
			scalars("obs N" "year_FE Year FE" "region_FE Region FE" "weight Weights"  "adjusted_r2 Adjusted R2")  
			star(* .10 ** .05 *** .01);
		#d cr

	
*--------- TABLE 3: Boustan -- OLS -- 1981 DATA ---------*

eststo clear	
	
	// School level (Cols 1-3)
	
		** Clean **
	
			import delimited using "`path'/build/data/output/agg_enrollment_CDS.csv", clear
		
		** Regress **
		
			eststo: reg white asian, vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "No"
			estadd local region_FE "No"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe white asian county_population, absorb(year cds_code) vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe white asian county_population [aweight=total], absorb(year cds_code) vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local region_FE "Yes"
			estadd local county_FE "Yes"
			estadd local weight "Yes"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
		
	// School district level (Cols 4-6)
	
		** Clean **
	
			import delimited using "`path'/build/data/output/agg_enrollment_CD.csv", clear
		
		** Regress **
		
			eststo: reg white asian, vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "No"
			estadd local region_FE "No"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe white asian county_population, absorb(year cdcode) vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe white asian county_population [aweight=total], absorb(year cdcode) vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local region_FE "Yes"
			estadd local county_FE "Yes"
			estadd local weight "Yes"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
	// Est out
	
		#d; 
		esttab est*
			using "`path'/analysis/output/B_OLS_81.tex",
			replace se wrap noobs constant
			nomtitles booktabs fragment nonumber nodep
			scalars("obs N" "year_FE Year FE" "region_FE Region FE" "weight Weights"  "adjusted_r2 Adjusted R2")  
			star(* .10 ** .05 *** .01);
		#d cr

		
	
*--------- TABLE 4: Boustan -- OLS -- 1994 DATA ---------*

eststo clear	
	
	// School level (Cols 1-3)
	
		** Clean **
	
			import delimited using "`path'/build/data/output/agg_enrollment_CDS.csv", clear
			drop if year < 1994
		
		** Regress **
			
			eststo: reg white asian, vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "No"
			estadd local region_FE "No"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe white asian county_population, absorb(year cds_code) vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe white asian county_population [aweight=total], absorb(year cds_code) vce(cluster cds_code)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local region_FE "Yes"
			estadd local county_FE "Yes"
			estadd local weight "Yes"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
		
	// School district level (Cols 4-6)
	
		** Clean **
	
			import delimited using "`path'/build/data/output/agg_enrollment_CD.csv", clear
			drop if year < 1994
			
		** Regress **
		
			eststo: reg white asian, vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "No"
			estadd local region_FE "No"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe white asian county_population, absorb(year cdcode) vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local year_FE "Yes"
			estadd local region_FE "Yes"
			estadd local weight "No"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
			
			eststo: reghdfe white asian county_population [aweight=total], absorb(year cdcode) vce(cluster cdcode)
			estadd local obs   	= string(e(N),"%9.0fc")
			estadd local region_FE "Yes"
			estadd local county_FE "Yes"
			estadd local weight "Yes"
			estadd local adjusted_r2 	= string(e(r2_a), "%9.2fc")
		
	// Est out
	
		#d; 
		esttab est*
			using "`path'/analysis/output/B_OLS_94.tex",
			replace se wrap noobs constant
			nomtitles booktabs fragment nonumber nodep
			scalars("obs N" "year_FE Year FE" "region_FE Region FE" "weight Weights"  "adjusted_r2 Adjusted R2")  
			star(* .10 ** .05 *** .01);
		#d cr
