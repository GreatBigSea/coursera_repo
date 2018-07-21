##Read the data out of the file
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.string = "?")

##Convert the format of the dates
data[,1] <-  as.Date(strptime(data[,1], "%d/%m/%Y"))

##Subset of the necessary data
data_extract <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

##Join the Date and Time to one column and with the right format
data_extract$Date <- as.POSIXct(strptime(paste(data_extract[,1], data_extract[,2]), "%Y-%m-%d %H:%M:%S"))

##Remove the unecessary data
rm(data)

##Open the file for the plot
png("plot3.png")

##Create an empty plot
with(data_extract, plot(Date, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))

##Add the lines for the three measurements
with(data_extract, lines(Date, Sub_metering_1, type = "l", col = "black"))
with(data_extract, lines(Date, Sub_metering_2, type = "l", col = "red"))
with(data_extract, lines(Date, Sub_metering_3, type = "l", col = "blue"))

##Add the legend
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

##Close the file
dev.off()