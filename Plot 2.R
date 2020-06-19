powerdata <- read.csv("household_power_consumption.txt",colClasses = "character",sep = ";")
  powerdata <- na.omit(powerdata)
  powerdata$Date <- as.Date(powerdata$Date, format = "%d/%m/%Y") #put in "Date" format
  powerdata <- subset(powerdata, Date == "2007-02-01"|Date == "2007-02-02") #select 2 days of data
  powerdata$Time <- as.character(powerdata$Time)
  powerdata[ ,3:9] <- sapply(powerdata[ , 3:9],as.numeric ) #put rest of columns as numerical
  
  powerdata$DateTime <- combine.date.and.time(powerdata$Date, powerdata$Time) #combine date and time
  powerdata <- subset(powerdata, select = -c(Date, Time)) #Remove the Date and Time columns after combining
  powerdata <- select(powerdata, DateTime, everything()) #re-order everything

  
  png(file = "active_power_vs_day.png", height = 480, width = 480)
  
  #Create graph of Global Active Power vs Day of the week
  plot(powerdata$DateTime, powerdata$Global_active_power,
       type = "l",
       ylab = "Global active power (kilowatts)",
       xlab = "")
  
  dev.off()