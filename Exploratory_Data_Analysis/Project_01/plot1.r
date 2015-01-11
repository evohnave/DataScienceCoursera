###############################################################################
##                                                                           ##
##  Exploratory Data Analysis                                                ##
##  Project 01                                                               ##
##  Plot 01                                                                  ##
##                                                                           ##
###############################################################################

#
# Read in all data
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
#

png(filename = "./data/plot1.png",
    width = 480,
    height = 480)

hist(data$Global_active_power,
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", 
     ylab="Frequency", 
     col="Red")

dev.off()




