# plot2.R
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

# Plots a line graph of Global Active Power vs. dateTime
oldpar <- par(cex = 1)
par(cex = 0.75)
plot(dateTime, mydata$Global_active_power, type = 'l', xlab = '',
     ylab = "Global Active Power (kilowatts)")

# Copies the plot to an output .png file
dev.copy(png, file = 'plot2.png')
dev.off()