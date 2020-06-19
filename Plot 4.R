powerdata <- read.csv("household_power_consumption.txt",colClasses = "character",sep = ";")
  powerdata <- na.omit(powerdata)
  powerdata$Date <- as.Date(powerdata$Date, format = "%d/%m/%Y") #put in "Date" format
  powerdata <- subset(powerdata, Date == "2007-02-01"|Date == "2007-02-02") #select 2 days of data
  powerdata$Time <- as.character(powerdata$Time)
  powerdata[ ,3:9] <- sapply(powerdata[ , 3:9],as.numeric ) #put rest of columns as numerical
  
  powerdata$DateTime <- combine.date.and.time(powerdata$Date, powerdata$Time) #combine date and time
  powerdata <- subset(powerdata, select = -c(Date, Time)) #Remove the Date and Time columns after combining
  powerdata <- select(powerdata, DateTime, everything()) #re-order everything

  
  png(file = "energy quadrants.png", width = 480, height = 480)
  
  
  par(mfrow = c(2,2))
  # first quadrant
  plot(powerdata$DateTime, powerdata$Global_active_power,
       type = "l",
       ylab = "Global active power (kilowatts)",
       xlab = "")
  
  #second quadrant
  plot(powerdata$DateTime, powerdata$Voltage, 
       type = "l", 
       xlab = "datetime", 
       ylab = "Voltage")
  
  
  #third quadrant
  with(powerdata, {plot(DateTime, Sub_metering_1, type = "l",
                        ylab = "Energy sub metering",
                        xlab = " " )
    lines(DateTime, Sub_metering_2, type = "l", col = "red")
    lines(DateTime, Sub_metering_3, type = "l", col = "blue")
    legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black", "red", "blue"),
           lty = c(1,1)
    )
  })
  
  #fourth quadrant
  plot(powerdata$DateTime, powerdata$Global_reactive_power, 
       type = "l", 
       xlab = "datetime", 
       ylab = "Global_reactive_power")
  
  dev.off()