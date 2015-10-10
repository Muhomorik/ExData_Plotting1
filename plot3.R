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
  select(Date, Time, 
         Sub_metering_1, Sub_metering_2, Sub_metering_3) %>%
  # Filter data, still text here.
  filter(Date == "1/2/2007" | Date == "2/2/2007") %>%
  # Make new column of type: "POSIXct" "POSIXt"
  mutate(DateTime = as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")) %>%
  # And remove now unused Date & Time.
  select(DateTime, Sub_metering_1, Sub_metering_2, Sub_metering_3)

# Change data types.
mydata$Sub_metering_1 <- as.numeric(mydata$Sub_metering_1)
mydata$Sub_metering_2 <- as.numeric(mydata$Sub_metering_2)
mydata$Sub_metering_3 <- as.numeric(mydata$Sub_metering_3)

# Create chart.
png(filename="plot3.png", width=480, height=480, units="px")

plot(mydata$DateTime, mydata$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering", col="black")

lines(mydata$DateTime, mydata$Sub_metering_2, col="red")
lines(mydata$DateTime, mydata$Sub_metering_3, col="blue")

# Legend
legend("topright", cex=0.8, lty=1, col=c("black", "red", "blue"), 
       legend=names(mydata)[2:4])

# End.
dev.off()
