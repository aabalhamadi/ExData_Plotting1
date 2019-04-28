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

#plot4

labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow=c(2,2))
plot(finalData$SetTime, finalData$Global_active_power, type="l", col="black", xlab="", ylab="Global Active Power")
plot(finalData$SetTime, finalData$Voltage, type="l", col="black", xlab="datetime", ylab="Voltage")
plot(finalData$SetTime, finalData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(finalData$SetTime, finalData$Sub_metering_2, type="l", col="red")
lines(finalData$SetTime, finalData$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=labels, lty=1, col=columnlines)
plot(finalData$SetTime, finalData$Global_reactive_power, type="l", col="black", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()