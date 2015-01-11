###############################################################################
##                                                                           ##
##  Exploratory Data Analysis                                                ##
##  Project 01                                                               ##
##  Plot 04                                                                  ##
##                                                                           ##
###############################################################################

#
# Read in all data
# Note: if you ran my code for an earlier plot you can skip to below
#

data <- read.csv(file = "./data/household_power_consumption.txt",
                 header = TRUE,
                 sep = ";",
                 na.strings = "?")

#
# Add in new column DateC that converts data$Date from factor to date
#

data$DateC <- as.Date(data$Date, format="%d/%m/%Y")

#
# Subset for our dates of interest
#

data <- subset(data, subset=(DateC >= "2007-02-01" & DateC <= "2007-02-02"))

#
# Consider time...
#

data$DateC <- as.POSIXct(paste(data$DateC, data$Time))

#
# OK, DateC now has date and time data, let's make plots and save them to png
# NOTE: If you ran my code for another plot then you can start here
#

png(filename = "./data/plot4.png",
    width = 480,
    height = 480)

#
# So now we're doing a panel plot, and the left column plots are
#    plots 2 and 3... so we'll set mfcol and copy the code for these
#    plots first then do the other 2
# And I'm using the margins and outer margins from the lectures...
# Note that there was a small change to the ylabel for the first plot
#  and that the box for the legend was removed for the second plot
#

par(mfcol = c(2, 2),
    mar = c(4, 4, 2, 1),
    oma = c(0, 0, 2, 0))

# From plot2.r - Upper left plot
plot(x = data$DateC,
     y = data$Global_active_power,
     type = "l",
     xlab="", 
     ylab="Global Active Power")


# From plot3.r - Lower left plot
plot(x = data$DateC,
     y = data$Sub_metering_1,
     type = "l",
     xlab="", 
     ylab="Energy sub metering")
lines(x = data$DateC,
      y = data$Sub_metering_2,
      type = "l",
      col = "red")
lines(x = data$DateC,
      y = data$Sub_metering_3,
      type = "l",
      col = "blue")
legend(x = "topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"),
       lty = 1,
       lwd = 2,
       bty = "n")

# Upper right plot
plot(x = data$DateC,
     y = data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

# Lower right plot
plot(x = data$DateC,
     y = data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

dev.off()

