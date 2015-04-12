# plot1.R
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

# Plots histogram 
oldpar <- par(cex = 1)
par(cex = 0.75)
with(mydata, hist(Global_active_power, breaks = 16, col = 'red',
                  xlab = 'Global Active Power (kilowatts)', ylab = 'Frequency',
                  main = 'Global Active Power'))

# Copies the plot to an output .png file
dev.copy(png, file = 'plot1.png')
dev.off()