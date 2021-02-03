library(chron)
library(dplyr)


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

par(mfrow = c(1, 1))

hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

dev.copy(png, "plot1.png", width  = 480, height = 480)
dev.off()

