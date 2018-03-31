library(dplyr)
library(lubridate)

datafile <- file.path("data", "household_power_consumption.txt")
rawdata <- read.csv2(datafile)

tidydata <- rawdata %>%
  mutate(Datetime = dmy_hms(paste(Date, Time)),
         Sub_metering_1 = as.numeric(as.character(Sub_metering_1)),
         Sub_metering_2 = as.numeric(as.character(Sub_metering_2)),
         Sub_metering_3 = as.numeric(as.character(Sub_metering_3)))

plotdata <- tidydata %>%
  filter(year(Datetime)==2007 &
           month(Datetime)==2 &
           day(Datetime)<=2)

png(filename = "plots/plot3.png",
    width = 480, height = 480,
    units = "px", pointsize = 12)

plot(y = plotdata$Sub_metering_1,
     x = plotdata$Datetime,
     type = "l", col = "black",
     ylab = "Energy sub metering",
     xlab = "")
lines(y = plotdata$Sub_metering_2,
     x = plotdata$Datetime,
     col = "red")
lines(y = plotdata$Sub_metering_3,
      x = plotdata$Datetime,
      col = "blue")
legend("topright", 
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  'Sub_metering_3'),
       lty = 1, col = c("black",
                        "red",
                        "blue"))

dev.off()
