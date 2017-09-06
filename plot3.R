library(dplyr)
library(lubridate)

powerdata <- read.table(file="household_power_consumption.txt", sep=";", skip=66637, na.strings="?", stringsAsFactors = FALSE)
powerdataDF <- tbl_df(powerdata)

colnames(powerdataDF) <- c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")
powerdataJan <- filter(powerdataDF, Date %in% c("1/2/2007", "2/2/2007")) #filter for Jan 1 & Jan 2 2007 only
powerdataJan$date_time = dmy_hms(paste(powerdataJan$Date, powerdataJan$Time))  #combine date & time, create new column
datadf <- powerdataJan


with(datadf, plot(date_time, SubMetering1, xlab="", ylab="Energy sub metering", type="l")) # first plot
lines(datadf$date_time, datadf$SubMetering2,col="red", type="l")  #2nd line, sub2
lines(datadf$date_time, datadf$SubMetering3,col="blue", type="l")  #3rd line, sub3

legend("topright", c("Submetering1", "Submetering2", "Submetering3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))



