import matplotlib
import scipy 
import pandas
import numpy

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd

d = {'col1': [1,2], 'col2': [3,4]}
df = pd.DataFrame(data=d)
print(df)

df['newcol']=[3,4]
df['onesCol']=1 
print(df) 
df2 = pd.DataFrame([[5,6],[7,8]], columns=['A','B'])
print(df2)

df2._append(df)
df._append(df2) 
df._append(df2, ignore_index=True)

d3 = {'col1':[3]}
df3 = pd.DataFrame(data=d3) 
df._append(df3, ignore_index=True)
df=df._append(df3, ignore_index=True)
df 
df.col2[2] = 7 
df
df.loc[2, 'newcol'] = 17 

df.to_csv("testing.csv")

#Check the uploaded Edcat Wages data
mydata = pd.read_csv(
"/Users/sydneyball/Desktop/Stat 426/Wages Ecdat.csv")

print(mydata)
print(dir(mydata))
print(mydata.shape)
print(mydata.dtypes)
print(mydata.describe())

#Recoding variables
mydata['South Resident'] = 'Southern'
for index, row in mydata.iterrows():
    if row["rns"] == "no":
        mydata.loc[index, 'South Resident'] = 'Not Southern'

mydata['South Resident New'] = 'Southern'
for index, row in mydata.iterrows():
    if row["rns80"] == "no":
        mydata.loc[index, 'South Resident New'] = 'Not Southern'
        
mydata['Metro Resident'] = 'Metro'
for index, row in mydata.iterrows():
    if row["mrt"] == "no":
        mydata.loc[index, 'Metro Resident'] = 'Not Metro'
        
mydata['Metro Resident New'] = 'Metro'
for index, row in mydata.iterrows():
    if row["mrt80"] == "no":
        mydata.loc[index, 'Metro Resident New'] = 'Not Metro'

mydata['Marital Status'] = 'Married'
for index, row in mydata.iterrows():
    if row["smsa"] == "no":
        mydata.loc[index, 'Marital Status'] = 'Not Married'
        
mydata['Marital Status New'] = 'Married'
for index, row in mydata.iterrows():
    if row["smsa80"] == "no":
        mydata.loc[index, 'Marital Status New'] = 'Not Married'
        
print(mydata.head())

#Create Subgroups
grouped = mydata.groupby("Marital Status")
g0 = grouped.get_group('Married')
g1 = grouped.get_group('Not Married')
print(g0)
print(g1)

catMarried = mydata[mydata['Marital Status']=='Married'] 
catNotMarried = mydata[mydata['Marital Status']=='Not Married']

#Whole data or subgroups
print(mydata['lw'].std())
print(g1['lw'].std())
print(mydata.size)
print(mydata.shape)
print(mydata.shape[0])

#Mean, Median, Mode, 5 number summary
print(mydata['lw'].mean())
print(mydata['lw'].median())
print(mydata['lw'].mode())
print(mydata['lw'].describe())

from scipy import stats
expo = mydata.lw.tolist()
m = np.mean(expo) 
sdem = stats.sem(expo) 
n = len(expo)

stats.norm.ppf(.5) 
stats.norm.ppf(.84)

leftcutoff = stats.norm.ppf(.025)
print(leftcutoff)
cutoff = stats.norm.ppf(.975) 
print(cutoff)

cutoff = stats.t.ppf(.975, n-1)
h = stats.sem(expo) * cutoff
print(h)

myInterval = [m - h, m+h]
print(myInterval)

#Histograms:
plt.hist(mydata.lw)
plt.show()

#Boxplots:
mydata.boxplot(column='lw')
plt.show()

#Making a sorted copy of one column in your DataFrame, so we can make a CFD:
x=mydata[['lw']]
type(x) 
x.sort_values(by=['lw']) 
print(x)
y=x.sort_values(by=['lw']) 
print(y) 

#Plot a cumulative frequency distribution (CFD):
y.lw.tolist() 
plt.plot(y.lw.tolist())
plt.show() 

#Pie chart:
mydata.school.value_counts(sort=False).plot.pie()
plt.show()

#t-test
stats.ttest_ind(catMarried['lw'], catNotMarried['lw']) 

#Computing correlations:
correlation = mydata['iq'].corr(mydata['school'])
print(correlation)

#Scatterplots:
mydata.plot.scatter('iq','lw') 
plt.show() 

plt.plot(mydata.iq, mydata.lw,'+') 
plt.show()

# Scatterplot Matrix:
pd.plotting.scatter_matrix(mydata.loc[:,['iq','lw','school','age']])
plt.show()

#. Basic scatterplot by subgroups:
plt.plot(g1.iq, g1.lw, '+')
plt.plot(g0.iq, g0.lw, 'x')
plt.show()

# Lines (any polynomial) fit by subgroups:
z0 = np.polyfit(x=g0.iq, y=g0.lw, deg=1)
z1 = np.polyfit(x=g1.iq, y=g1.lw, deg=1)
p0 = np.poly1d(z0)
p1 = np.poly1d(z1)

# Create ordered pairs in preparation for plotting.
mydata['line0'] = p0(mydata.iq)
mydata['line1'] = p1(mydata.lw)
print(mydata.dtypes)

#Plot points and lines together for the subgroups:
plt.plot(mydata.iq, mydata.line0,'red')
plt.plot(mydata.lw, mydata.line1,'blue')
plt.plot(g0.iq, g0.lw, 'ro') 
plt.plot(g1.iq, g1.lw, 'bo') 
plt.show()

plt.plot(mydata.lw, mydata.line0,'red',label='Married') 
plt.plot(mydata.lw, mydata.line1,'blue',label='Not Married')
plt.plot(g0.iq, g0.lw, 'ro') 
plt.plot(g1.iq, g1.lw, 'bo') 
plt.legend(['Married','Not Married'], loc=2) 
plt.show()
# not sure what happended, but this graph looks a little funny

#Chi Square:
from scipy.stats import chi2_contingency
pd.crosstab(mydata.school, mydata.lw) 
pd.crosstab(mydata.school, mydata.lw, margins=True) 
CT = pd.crosstab(mydata.school, mydata.lw)
print(chi2_contingency(CT)) 

#ANOVA:
F, p = stats.f_oneway(g0.lw, g1.lw)
print(F, p)

#Create histogram grouped by an attribute in a column:
grouped = mydata.groupby("Marital Status")
grouped.hist('lw')
plt.show()

#Boxplots two ways:
mydata.groupby('Marital Status').boxplot(column='lw')
plt.show()

