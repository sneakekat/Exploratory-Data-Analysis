flibrary(dplyr)
library(lubridate)

powerdata <- read.table(file="household_power_consumption.txt", sep=";", skip=66637, na.strings="?", stringsAsFactors = FALSE)
powerdataDF <- tbl_df(powerdata)

colnames(powerdataDF) <- c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")
powerdataJan <- filter(powerdataDF, Date %in% c("1/2/2007", "2/2/2007")) #filter for Jan 1 & Jan 2 2007 only
powerdataJan$date_time = dmy_hms(paste(powerdataJan$Date, powerdataJan$Time))  #combine date & time, create new column
datadf <- powerdataJan

png("plot4.png")
par(mfrow=c(2,2))

#top left plot
with(datadf, plot(date_time, GlobalActivePower, xlab="", type="l", ylab="Global Active Power")) #create plot, date_time against globactipow, type="n" means no points


#top right plot
with(datadf, plot(date_time, Voltage, xlab="datetime", type="l")) #create plot, date_time against globactipow, type="n" means no points


#bottom left plot 
with(datadf, plot(date_time, SubMetering1, xlab="", ylab="Energy sub metering", type="l")) # first plot
lines(datadf$date_time, datadf$SubMetering2,col="red", type="l")  #2nd line, sub2
lines(datadf$date_time, datadf$SubMetering3,col="blue", type="l")  #3rd line, sub3
legend("topright", c("Submetering1", "Submetering2", "Submetering3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

#bottom right plot
with(datadf, plot(date_time, GlobalReactivePower, xlab="datetime", ylab="Global_reactive_power", type="l")) #create plot, date_time against globactipow, type="n" means no points

dev.off()

#dev.copy(png, file="plot4.png") #same plot to png file

