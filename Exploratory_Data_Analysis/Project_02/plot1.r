# This code assumes you've downloaded and unzipped the file 
#   exdata-data-NEI_data.zip in your working directory.  If you haven't it's 
#   easy enough to write the code to check using file.exists etc

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot 1
Totals <- aggregate(formula = Emissions ~ year,
                    data = NEI,
                    FUN = sum)

png(filename = "plot1.png",
    width = 480,
    height = 480)

barplot(height = Totals$Emissions/10^6,
        names.arg=Totals$year,
        col = "lightblue",
        xlab = "Year",
        ylab = "Emissions (hundred thousand tons)",
        main = "Plot 1: Total PM2.5 Emissions From All US Sources",
        ylim = c(0,8))

dev.off()