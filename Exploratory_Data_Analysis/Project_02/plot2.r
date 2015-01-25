# This code assumes you've downloaded and unzipped the file 
#   exdata-data-NEI_data.zip in your working directory.  If you haven't it's 
#   easy enough to write the code to check using file.exists etc

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot 2
Balt <- NEI[NEI$fips == "24510",]
BaltTotal <- aggregate(formula = Emissions ~ year,
                       data = Balt,
                       FUN = sum)

png(filename = "plot2.png",
    width = 480,
    height = 480)

barplot(height = BaltTotal$Emissions/10^3,
        names.arg=BaltTotal$year,
        col = "lightblue",
        xlab = "Year",
        ylab = "Emissions (thousand tons)",
        main = "Plot 2: Total PM2.5 Emissions From Baltimore",
        ylim = c(0,4))

dev.off()