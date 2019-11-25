data <- read.csv(file="City Data of HUD_Health Care Facilities.csv",header=TRUE)
data$Date <- format(as.Date(data$Week))

library(reshape2)



data_sub=data[which(data$PROPERTY.CITY=="CHICAGO"), ]

x=as.Date(data_sub$Date)

plots=geom_line(aes(x,y=data_sub$X20.Yr,group=1),colour="2")

ggplot(data_sub)+geom_line(aes(x,y=INTEREST.RATE,group=1),colour="1")+plots+
  scale_x_date(date_breaks = "1 year", date_labels = "%Y")+ theme(legend.position="right")

