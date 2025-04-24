* Sydney Ball
* 6 Feb 2025
* Data 426
* HW3

clear

import delimited "C:\Users\sb3218a\OneDrive - american.edu\Desktop\Wages_Ecdat.csv"

* rns variable recod
gen South_Resident = "Southern" if rns == "yes"
replace South_Resident = "Not Southern" if rns == "no"

* rns80 variable recode
gen South_Resident_New = "Southern" if rns80 == "yes"
replace South_Resident_New = "Not Southern" if rns80 == "no"

* mrt variable recode
gen Marital_Status = "Married" if mrt == "yes"
replace Marital_Status = "Not Married" if mrt == "no"

* mrt80 variable recode
gen Marital_Status_New = "Married" if mrt80 == "yes"
replace Marital_Status_New = "Not Married" if mrt80 == "no"

* smsa variable recode
gen Metro_Resident = "Metro" if smsa == "yes"
replace Metro_Resident = "Not Metro" if smsa == "no"

* smsa80 variable recode
gen Metro_Resident_New = "Metro" if smsa80 == "yes"
replace Metro_Resident_New = "Not Metro" if smsa80 == "no"

* Summary stats
summarize

* 95% CI
ci means

* side-by-side boxplots of varaible
graph box iq

* side-by-side boxplots of varaible (by group)
graph box iq, by(mrt)

* QQ plots for y
qnorm lw
 
* QQ plots of y by group
qnorm lw if Marital_Status == "Married"
qnorm lw if Marital_Status == "Not Married"

*Pie Chart
graph pie, over(mrt) plabel(1 name) plabel(2 name) by(, title("Marital Status by Location") subtitle("Married or Not as Southerner or Not")) by(, legend(off)) by(South_Resident)

* Test for similarity between groups
ttest lw, by(Marital_Status)
ztest lw, by(Marital_Status)

* Correlation between X and Y
correlate school lw
 
 * Correlate between X and Y by groups
by Marital_Status, sort : correlate school lw
 
 * Scatterplot with a regression line
twoway (scatter lw kww) (lfit lw kww)
 
 
* Scatterplot witha  regression for groups
twoway (scatter lw kww) (lfit lw kww), by(South_Resident)
twoway (scatter lw kww) (lfit lw kww), by(Metro_Resident)

* Chi-sqaured analysis
tabulate Metro_Resident Metro_Resident_New, chi2 expected

 * Pie chart broken down by group
graph pie lw, over(school) plabel(_all percent)
  
 * Summary Stat table sorted by groups
by school, sort : summarize iq kww lw

* ANOVA and Bonferroni
oneway lw school, bonferroni

* Side-by-side boxplots of variable Y
graph box lw, by(Metro_Resident)
graph box lw, by(school)

* Grouped histograms for X
histogram iq, by(school)
histogram iq, by(Marital_Status)


* I added secondary codes for some of these prompts becuase one of my grouped
* variables had many subgroups, almost too many for some plots. 












