# 4 - Exploratory Data Analysis
# Course Project 1

rm(list=ls())
setwd("~/R Projects/Coursera/4 - Exploratory Data Analysis/Course Project 1")

# Download uri.
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileUrl <- gsub("%2F", "/", fileUrl)

# Filename
fileName <- "household_power_consumption.zip"

if (!file.exists(fileName)){
  message("Data is missing, downloading into: ", getwd())
  
  # Donload.
  download.file(fileUrl, fileName, method = "auto") # Don't use curl on Windows.
  
  message("Unzipping...")
  unzip(fileName)
}
