library(dplyr)
library(lubridate)

powerdata <- read.table(file="household_power_consumption.txt", sep=";", skip=66637, na.strings="?", stringsAsFactors = FALSE)
powerdataDF <- tbl_df(powerdata)

colnames(powerdataDF) <- c("Date", "Time", "GlobalActivePower", "GlobalReactivePower", "Voltage", "GlobalIntensity", "SubMetering1", "SubMetering2", "SubMetering3")
powerdataJan <- filter(powerdataDF, Date %in% c("1/2/2007", "2/2/2007")) #filter for Jan 1 & Jan 2 2007 only
powerdataJan$date_time = dmy_hms(paste(powerdataJan$Date, powerdataJan$Time))  #combine date & time, create new column

png("plot2.png")
plot2 <- with(powerdataJan, plot(date_time, GlobalActivePower, xlab="", type="n")) #create plot, date_time against globactipow, type="n" means no points
lines(powerdataJan$date_time, powerdataJan$GlobalActivePower, lwd=1.5) #connects each point in plot with line
#dev.copy(png, file="plot2.png") #same plot to png file
dev.off()
