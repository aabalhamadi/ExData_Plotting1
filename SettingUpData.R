#set link and file name

downloadURL <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
downloadFile <- paste(getwd(), "/household_power_consumption.zip", sep = "")
householdFile <- "household_power_consumption.txt"

#download

if (!file.exists(householdFile)) {
        download.file(downloadURL, downloadFile, method = "curl")
        unzip(downloadFile, overwrite = T, exdir = getwd())
}

#prepare data

plotData <- read.table(householdFile, header=T, sep=";", na.strings="?")

finalData <- plotData[plotData$Date %in% c("1/2/2007","2/2/2007"),]
SetTime <-strptime(paste(finalData$Date, finalData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
finalData <- cbind(SetTime, finalData)
