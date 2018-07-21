##Read the data out of the file
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.string = "?")

##Convert the Date into the right format
data[,1] <-  as.Date(strptime(data[,1], "%d/%m/%Y"))

##Subset of the necessary data
data_extract <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

##Join the Date and Time in one column and in the right format
data_extract$Date <- as.POSIXct(strptime(paste(data_extract[,1], data_extract[,2]), "%Y-%m-%d %H:%M:%S"))

##Delete the unecessary data
rm(data)

##Open the file for the plot
png("plot2.png")

##Plot the data
with(data_extract, plot(Date, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))

##Close the file
dev.off()