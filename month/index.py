
import pandas as pd

nq=pd.read_csv("../Nasdaq 100 Historical Data.csv")

nq.Date=nq.Date.map(lambda x: pd.to_datetime(x,format='%b %d, %Y'))
nq["Month"]=nq["Date"].map(lambda x:x.to_period("M"))



sp=pd.read_csv("../S&P 500 Historical Data.csv")

sp.Date=sp.Date.map(lambda x: pd.to_datetime(x,format='%b %d, %Y'))
sp["Month"]=sp["Date"].map(lambda x:x.to_period("M"))



djs=pd.read_csv("../Dow Jones Industrial Average Historical Data.csv")

djs.Date=djs.Date.map(lambda x: pd.to_datetime(x,format='%b %d, %Y'))
djs["Month"]=djs["Date"].map(lambda x:x.to_period("M"))





