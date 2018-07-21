##Load the data out of the file
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.string = "?")

##Convert the Date into the right format
data[,1] <-  as.Date(strptime(data[,1], "%d/%m/%Y"))

##Subset of the necessary data
data_extract <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")

##Open the file for the plot
png("plot1.png")

##Plot the data
hist(data_extract$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

##Close the file
dev.off()