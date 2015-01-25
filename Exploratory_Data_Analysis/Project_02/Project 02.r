# All the code for all the plots in one file.

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

# Plot 3

library(ggplot2)

png(filename = "plot3.png",
    width = 640, 
    height = 480)

ggplot(Balt, aes(factor(year), Emissions, fill=type)) + 
  geom_bar(stat="identity") + 
  theme_bw() + 
  guides(fill=FALSE) + 
  facet_grid(. ~ type, scales = "fixed", space="fixed") +  
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) +  
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()

# Plot 4
# Subsetting...
Combustion <- grepl("comb", 
                    SCC$SCC.Level.One, 
                    ignore.case = TRUE)

Coal <- grepl("coal",
              SCC$SCC.Level.Four,
              ignore.case = TRUE)

Coal.Comb <- (Coal & Combustion)

ccSCC <- SCC[Coal.Comb,]$SCC
ccNEI <- NEI[NEI$SCC %in% ccSCC,]

library(ggplot2)

png(filename = "plot4.png",
    width = 640, 
    height = 480)

ggplot(ccNEI,aes(factor(year), Emissions/10^3)) + 
  geom_bar(stat = "identity", fill = "grey") + 
  theme_bw() +  
  guides(fill = FALSE) +
  labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Thousand Tons)")) + 
  labs(title = expression("PM"[2.5]*" Coal-Combustion Related Source Emissions Across US from 1999-2008"))

dev.off()

# Plot 5
# Subset as before, this time for motor vehicles
# Gather the subset of the NEI data which corresponds to vehicles
cars <- grepl("vehicle",
              SCC$SCC.Level.Two, 
              ignore.case = TRUE)

carsSCC <- SCC[cars,]$SCC

carsNEI <- NEI[NEI$SCC %in% carsSCC,]

# Plot 5 cares only about Baltimore...

BaltCars <- carsNEI[carsNEI$fips == "24510",]

png(filename = "plot5.png",
    width = 640, 
    height = 480)

ggplot(BaltCars,aes(factor(year), Emissions)) + 
  geom_bar(stat = "identity", fill = "grey") + 
  theme_bw() +  
  guides(fill = FALSE) +
  labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title = expression("PM"[2.5]*" Motor Vehicle Related Source Emissions From Baltimore from 1999-2008"))

dev.off()

# Plot 6
# Add a city to BaltCars
BaltCars$city <- "Baltimore City"

# Now subset LA motor vehicle data
LACars <- carsNEI[carsNEI$fips == "06037",]
LACars$city <- "Los Angeles County"

# Bind both LA and Baltimore together

LA.Balt <- rbind(LACars, BaltCars)

png(filename = "plot6.png",
    width = 640, 
    height = 480)

ggplot(LA.Balt,aes(factor(year), Emissions, fill = "city")) + 
  geom_bar(stat = "identity", fill = "grey") + 
  theme_bw() +  
  guides(fill = FALSE) +
  facet_grid(scales = "free", space = "free", . ~ city) +
  labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title = expression("PM"[2.5]*" Motor Vehicle Related Source Emissions From LA County from 1999-2008"))

dev.off()
