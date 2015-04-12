# plot4.R
# Coded by: Ryan Yan
# Revision Date: 04.10.15

file = "./exdata_data_household_power_consumption/household_power_consumption.txt"

# Chooses rows that are relevant and reads them into a dataframe
skipped = 46*60*24 + 60*6 + 36 
read = 2*60*24
mydata = read.table(file, header = TRUE, sep = ";", na.strings = "?",
                    nrows = read, skip = skipped)
header = read.table(file, header = TRUE, sep = ";", nrows = 1)
names(mydata) = names(header)

# Combines the two Date and Time columns into a POSITct variable
dateTime = paste(as.character(mydata$Date), as.character(mydata$Time), sep = " ")
dateTime = as.POSIXct(strptime(dateTime, format = "%d/%m/%Y %H:%M:%S"))

# Sets up a 2 x 2 array of plots by row
oldpar <- par(mfrow = c(1,1), mar = c(4, 4, 2, 2), cex = 1)
par(mfrow = c(2, 2), mar = c(7, 5, 2, 2), cex = 0.65)

# First plot: Global Active Power vs. dateTime
plot(dateTime, mydata$Global_active_power, type = 'l', xlab = '',
     ylab = "Global Active Power")

# Second plot: Voltage vs. dateTime
plot(dateTime, mydata$Voltage, type = 'l', xlab = 'datetime', ylab = 'Voltage')

# Third plot; 3 sub_metering variables vs. dateTime
plot(dateTime, mydata$Sub_metering_1, type = 'n', xlab = '',
     ylab = "Energy sub metering")
lines(dateTime, mydata$Sub_metering_1, col = "black")
lines(dateTime, mydata$Sub_metering_2, col = "red")
lines(dateTime, mydata$Sub_metering_3, col = "blue")
legend("topright", bty = 'n', col = c("black", "red", "blue"), lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex = 0.95)

#Fourth plot: Global Reactive Power vs. dateTime
plot(dateTime, mydata$Global_reactive_power, type = 'l', xlab = 'datetime',
     ylab = 'Global_reactive_power')

# Copies the plot to an output .png file
dev.copy(png, file = 'plot4.png')
dev.off()

