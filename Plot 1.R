powerdata <- read.csv("household_power_consumption.txt",colClasses = "character",sep = ";")
  powerdata <- na.omit(powerdata)
  powerdata$Date <- as.Date(powerdata$Date, format = "%d/%m/%Y") #put in "Date" format
  powerdata <- subset(powerdata, Date == "2007-02-01"|Date == "2007-02-02") #select 2 days of data
  powerdata$Time <- as.character(powerdata$Time)
  powerdata[ ,3:9] <- sapply(powerdata[ , 3:9],as.numeric ) #put rest of columns as numerical
  
  powerdata$DateTime <- combine.date.and.time(powerdata$Date, powerdata$Time) #combine date and time
  powerdata <- subset(powerdata, select = -c(Date, Time)) #Remove the Date and Time columns after combining
  powerdata <- select(powerdata, DateTime, everything()) #re-order everything

#create histogram for plot 1

png(file = "Global_active_power.png", width = 480, height = 480)

hist(powerdata$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
)

dev.off()
