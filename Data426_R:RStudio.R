rm(list=ls())
gc()

Wages_Ecdat <- read.csv("~/Desktop/stat 426/Wages Ecdat.csv")
  View(Wages_Ecdat)

names(Wages_Ecdat)
lengths(Wages_Ecdat)  
dim(Wages_Ecdat)
str(Wages_Ecdat)

library(tidyverse)  

#Re-code all the variables into something more explanatory
Wages_Ecdat$rns[Wages_Ecdat$rns == "yes"] <- "Southerner"
Wages_Ecdat$rns[Wages_Ecdat$rns == "no"] <- "Not Southerner"

Wages_Ecdat$rns80[Wages_Ecdat$rns80=="yes"]<-"Southerner"
Wages_Ecdat$rns80[Wages_Ecdat$rns80=="no"]<-"Not Southerner"

Wages_Ecdat$mrt[Wages_Ecdat$mrt=="yes"]<-'Married'
Wages_Ecdat$mrt[Wages_Ecdat$mrt=="no"]<-'Not Married'

Wages_Ecdat$mrt80[Wages_Ecdat$mrt80=="yes"]<-'Married'
Wages_Ecdat$mrt80[Wages_Ecdat$mrt80=="no"]<-'Not Married'

Wages_Ecdat$smsa[Wages_Ecdat$smsa=="yes"]<-'Metro'
Wages_Ecdat$samsa[Wages_Ecdat$smsa=="no"]<-'Not Metro'

Wages_Ecdat$smsa80[Wages_Ecdat$smsa80=="yes"]<-'Metro'
Wages_Ecdat$samsa80[Wages_Ecdat$smsa80=="no"]<-'Not Metro'

#Create subsets: 
married_people <- Wages_Ecdat[Wages_Ecdat$mrt=="Married",]
not_Married_people <- Wages_Ecdat[Wages_Ecdat$mrt=="Not Married",]

#Summary statistics:
mean(Wages_Ecdat$lw)
median(Wages_Ecdat$lw)

#5 number summary
quantile(Wages_Ecdat$lw, probs = seq(0,1,0.25))
summary(Wages_Ecdat)

#Variance and standard deviation:
var(Wages_Ecdat$lw)
sd(Wages_Ecdat$lw)

#More summary stats
library(psych)
describeBy(Wages_Ecdat$lw, Wages_Ecdat$mrt)

#Cumulative frequency distribution:
ex<- Wages_Ecdat$lw
plot(sort(ex))

#QQ Plots
qqplot(married_people$lw, not_Married_people$lw)
qqnorm(married_people$lw)

#boxplot, histogram and correlation:
hist(Wages_Ecdat$iq)
boxplot(Wages_Ecdat$iq)

#statistics:
hold <- table(Wages_Ecdat$mrt)
hold/sum(hold)

#graphics: 
ggplot(Wages_Ecdat, aes(x = mrt)) +
  geom_bar(fill = "blue3") +
  theme_bw()

#pie chart using base R:
mytable <- table(Wages_Ecdat$school)
pie(mytable, main = "Schooling Breakdown")

#test for similarity:
t.test(Wages_Ecdat$lw[Wages_Ecdat$mrt=="Married"],
       Wages_Ecdat$lw[Wages_Ecdat$mrt=="Not Married"])

#Confidence intervals:
library(Rmisc)
CI(Wages_Ecdat$lw, ci = .95)

#Correlation:
cor(Wages_Ecdat$school, Wages_Ecdat$lw80)

#scatterplot with regression line
ggplot(Wages_Ecdat, aes(x = kww, y= lw)) +
  geom_point(fill = "purple") +
  geom_smooth(se = FALSE) +
  theme_bw()

#grouped scatterplot:
ggplot(Wages_Ecdat, aes(x = kww, y= lw, color = mrt)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  theme_bw()

#Chi-squared analysis:
newtable <- table(Wages_Ecdat$mrt, Wages_Ecdat$mrt80)
newtable
chsq=chisq.test(newtable)
chsq$observed
chsq$expected
round(chsq$expected,2)

#graphics:
ggplot(Wages_Ecdat, aes(x = school, fill = mrt)) +
  geom_bar(position = "fill")

#ANOVA:
my_data <- Wages_Ecdat
results <- aov(lw~mrt, data = my_data)
summary(results)
TukeyHSD(results)

#graphics
boxes <- ggplot(Wages_Ecdat, aes(x = mrt, y = lw))
boxes + geom_boxplot()








