# 4 - Exploratory Data Analysis
# Course Project 1

# Set locale (or will get day in other language).
Sys.setlocale("LC_ALL", "English_United Kingdom")

library(dplyr)

rm(list=ls())
setwd("~/R Projects/Coursera/4 - Exploratory Data Analysis/Course Project 1")

# Call download script. Downloads and unzips data if missing.
source("download.R")

data <- "household_power_consumption.txt"
if (!file.exists(data)) stop("Data is missing.")

# Load data into frame and table.  
mydf <- read.csv(data, stringsAsFactors = FALSE, header=TRUE, na.strings = c("?",""), sep= ";")
mydf <- tbl_df(mydf)

# Info size just for fun.
data.size <- object.size(mydf)   
data.size <- format(data.size, quote = FALSE, units = "MB")
message("Table size = ", data.size)

# internal
#names(mydf)

mydata <- mydf %>%
  # Select columns.
  select(Global_active_power, Global_reactive_power,
         Voltage,
         Date, Time, 
         Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
  # Filter data, still text here.
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  # Make new column of type: "POSIXct" "POSIXt"
  mutate(DateTime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")) %>%
  # And remove now unused Date & Time.
  select(Global_active_power, Global_reactive_power,
         Voltage,
         DateTime, 
         Sub_metering_1, Sub_metering_2, Sub_metering_3)

# Change data types.
mydata$Sub_metering_1 <- as.numeric(mydata$Sub_metering_1)
mydata$Sub_metering_2 <- as.numeric(mydata$Sub_metering_2)
mydata$Sub_metering_3 <- as.numeric(mydata$Sub_metering_3)

mydata$Global_active_power <- as.numeric(mydata$Global_active_power)
mydata$Global_reactive_power <- as.numeric(mydata$Global_reactive_power)
mydata$Voltage <- as.numeric(mydata$Voltage)

# Create chart.
png(filename="plot4.png", width=480, height=480, units="px")
#windows()

par(mfcol = c(2,2))

# 1
plot(mydata$DateTime, mydata$Global_active_power, 
     type="l", xlab="", ylab="Global Active Power", col="black")

# 2 
plot(mydata$DateTime, mydata$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering", col="black")

lines(mydata$DateTime, mydata$Sub_metering_2, col="red")
lines(mydata$DateTime, mydata$Sub_metering_3, col="blue")

# Legend
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# 3
plot(mydata$DateTime, mydata$Voltage, 
     type="l", xlab="datetime", ylab="Voltage")

# 4
plot(mydata$DateTime, mydata$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_Power")

# End.
dev.off()
