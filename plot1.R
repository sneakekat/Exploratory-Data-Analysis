library(dplyr)

powerdata <- read.table(file="household_power_consumption.txt", sep=";", skip=66637, na.strings="?", stringsAsFactors = FALSE)
powerdataDF <- tbl_df(powerdata)

colnames(powerdataDF) <- c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")
powerdataJan <- filter(powerdataDF, Date %in% c("1/2/2007", "2/2/2007"))
plot1 <- hist(powerdataJan$GlobalActivePower, main="Global Active Power", col="red",  lwd=6, xlab="Global Active Power (kilowatts)")
plot1



