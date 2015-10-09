# 4 - Exploratory Data Analysis
# Course Project 1

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
  select(Global_active_power, Date) %>%
  # Filter data, still text here.
  filter(Date == "1/2/2007" | Date == "2/2/2007")

# Create chart.
png(filename = "plot1.png", width=480, height=480, units="px")
hist(mydata$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
