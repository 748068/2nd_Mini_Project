## Setting Directory
setwd("C:/Users/Win10/Desktop/2nd Mini Project/specdata")

## Gather Data
household_power_consumption<-read.table("household_power_consumption.txt",sep=";",header=TRUE)

household_power_consumption$Date<-as.Date(household_power_consumption$Date, format="%d/%m/%Y")

## Subsetting data from 2007-02-01 to 2007-02-02

household_power_consumption<-household_power_consumption[household_power_consumption$Date=="2007-02-02"|household_power_consumption$Date=="2007-02-01",]

household_power_consumption$Time<-paste(household_power_consumption$Date,household_power_consumption$Time,sep=" ")

household_power_consumption$Time<-strptime(household_power_consumption$Time, format="%Y-%m-%d %H:%M:%S")

## Securing data to be numeric

household_power_consumption$Global_active_power<-as.numeric(household_power_consumption$Global_active_power)

# Plot 01
hist(household_power_consumption$Global_active_power,xlab="Global Active Power (kilowatts)",ylab="Frequency",main= "Global Active Power",col="red")

## Creating a copy
dev.copy(png,'plot1.png')
dev.off()

# Plot 02
plot(household_power_consumption$Time,household_power_consumption$Global_active_power,ylab="Global Active Power (kilowatts)",xlab=" ",type="l")

## Creating a copy
dev.copy(png,'plot2.png')
dev.off()

#Plot 03

## Securing Data to be numeric
household_power_consumption$Sub_metering_1<-as.numeric(household_power_consumption$Sub_metering_1)

household_power_consumption$Sub_metering_2<-as.numeric(household_power_consumption$Sub_metering_2)

household_power_consumption$Sub_metering_3<-as.numeric(household_power_consumption$Sub_metering_3)

## Plotting Data
plot(household_power_consumption$Time,household_power_consumption$Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" ",col="black")

lines(household_power_consumption$Time,household_power_consumption$Sub_metering_2,type="l",col="red")

lines(household_power_consumption$Time,household_power_consumption$Sub_metering_3,type="l",col="blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)

## Creating a copy

dev.copy(png,'plot3.png')
dev.off()

# Plot 04

household_power_consumption$Global_reactive_power<-as.numeric(household_power_consumption$Global_reactive_power)

par(mfrow=c(2,2),mar=c(4,4,4,4),oma=c(2,2,0,0))

with(household_power_consumption,{
  plot(Time,household_power_consumption$Global_active_power,ylab="Global Active Power (kilowatts)",xlab=" ",type="l")
  
  plot(Time,Voltage,xlab="datetime",type="l")
  
  plot(Time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" ",col="black")
  lines(Time,Sub_metering_2,type="l",col="red")
  lines(Time,Sub_metering_3,type="l",col="blue")
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=1)
  
  plot(Time,Global_reactive_power,xlab="datetime",type="l")
})

## Creating a copy
dev.copy(png,'plot4.png')
dev.off()