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

#plot data to png device
png(filename = "plot1.png", width = 480, height = 480)
hist(subsetData$Global_active_power, col="red", ylab = "Frequency", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

