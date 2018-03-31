library(dplyr)
library(lubridate)

datafile <- file.path("data", "household_power_consumption.txt")
rawdata <- read.csv2(datafile)

tidydata <- rawdata %>%
  mutate(Datetime = dmy_hms(paste(Date, Time)),
         Global_active_power = as.numeric(as.character(Global_active_power)))

plotdata <- tidydata %>%
  filter(year(Datetime)==2007 &
           month(Datetime)==2 &
           day(Datetime)<=2)

png(filename = "plots/plot1.png",
    width = 480, height = 480,
    units = "px", pointsize = 12)

hist(plotdata$Global_active_power,
     na.rm= TRUE, col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()
