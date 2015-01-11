###############################################################################
##                                                                           ##
##  Exploratory Data Analysis                                                ##
##  Project 01                                                               ##
##  Plot 02                                                                  ##
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

png(filename = "./data/plot2.png",
    width = 480,
    height = 480)

plot(x = data$DateC,
     y = data$Global_active_power,
     type = "l",
     xlab="", 
     ylab="Global Active Power (kilowatts)")

dev.off()



