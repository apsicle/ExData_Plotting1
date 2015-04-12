# plot3.R
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

# Plots 3 lines, submetering 1, 2, and 3, vs. dateTime,
# with a color coded legend.
oldpar <- par(cex = 1)
par(cex = 0.75)
plot(dateTime, mydata$Sub_metering_1, type = 'n', xlab = '',
     ylab = "Energy sub metering", cex = 0.75)
lines(dateTime, mydata$Sub_metering_1, col = "black")
lines(dateTime, mydata$Sub_metering_2, col = "red")
lines(dateTime, mydata$Sub_metering_3, col = "blue")
legend("topright",  col = c("black", "red", "blue"), lwd = 1, cex = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Copies the plot to an output .png file
dev.copy(png, file = 'plot3.png')
dev.off()