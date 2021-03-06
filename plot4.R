#download and unzip file %may be commented if data
if(!file.exists("household_power_consumption.txt")){
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household.zip", method = "curl")
  unzip("household.zip", overwrite = T)
}

#read data
library(data.table)
data<-fread("household_power_consumption.txt", na.strings="?")

#convert character to Date
data$Date<-as.Date(data$Date,format = "%d/%m/%Y")
subsetData<-subset(data, Date %in% c(as.Date("2007/02/01",format = "%Y/%m/%d"), as.Date("2007/02/02",format = "%Y/%m/%d")))

#convert character to numeric
subsetData$Global_active_power<-as.numeric(subsetData$Global_active_power)
#convert character to time
time<-strptime(paste(subsetData$Date, subsetData$Time), format="%Y-%m-%d %H:%M:%S")

#plot data to png device
png(filename = "plot4.png", width = 480, height = 480)
par(mfcol = c(2,2))

#plot 1
plot(time,subsetData$Global_active_power,type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")

#plot 2
plot(time,subsetData$Sub_metering_1,type = "l", ylab = "Energy sub metering",xlab = "")
lines(time,subsetData$Sub_metering_2, col="red")
lines(time,subsetData$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty="solid")

#plot 3
plot(time,subsetData$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")

#plot 4
plot(time,subsetData$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()
