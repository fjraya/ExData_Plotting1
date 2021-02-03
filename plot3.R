library(chron)
library(dplyr)
library(lubridate)


if(!file.exists("household_power_consumption.txt") & !file.exists("exdata_data_household_power_consumption.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "exdata_data_household_power_consumption.zip")
    unzip("exdata_data_household_power_consumption.zip")
}

setAs("character","formatedDate", function(from) as.Date(from, format="%d/%m/%Y") )

setAs("character", "formatedTime", function(from) times(from))

data <- read.table("household_power_consumption.txt",
                   sep = ";", header=TRUE,
                   na.strings    = c("?"),
                   colClasses = c("formatedDate", "formatedTime", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")) %>%filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))

data$datetime <- ymd_hms(paste(data$Date, data$Time))

par(mfrow = c(1, 1))


plot(Sub_metering_1 ~ datetime, data, type = "l", ylab = "Energy sub metering", xlab = "")
lines(Sub_metering_2 ~ datetime, data, type = "l", col = "red")
lines(Sub_metering_3 ~ datetime, data, type = "l", col = "blue")

legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)

dev.copy(png, "plot3.png", width  = 480, height = 480)
dev.off()