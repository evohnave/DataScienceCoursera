# This code assumes you've downloaded and unzipped the file 
#   exdata-data-NEI_data.zip in your working directory.  If you haven't it's 
#   easy enough to write the code to check using file.exists etc

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Plot 6
# Subset as before, this time for motor vehicles
# Gather the subset of the NEI data which corresponds to vehicles
cars <- grepl("vehicle",
              SCC$SCC.Level.Two, 
              ignore.case = TRUE)

carsSCC <- SCC[cars,]$SCC

carsNEI <- NEI[NEI$SCC %in% carsSCC,]

# Get Baltimore data...

BaltCars <- carsNEI[carsNEI$fips == "24510",]

# Add a city to BaltCars
BaltCars$city <- "Baltimore City"

# Now subset LA motor vehicle data
LACars <- carsNEI[carsNEI$fips == "06037",]
LACars$city <- "Los Angeles County"

# Bind both LA and Baltimore together

LA.Balt <- rbind(LACars, BaltCars)

library(ggplot2)

png(filename = "plot6.png",
    width = 640, 
    height = 480)

ggplot(LA.Balt,aes(factor(year), Emissions, fill = "city")) + 
  geom_bar(stat = "identity", fill = "grey") + 
  theme_bw() +  
  guides(fill = FALSE) +
  facet_grid(scales = "free", space = "free", . ~ city) +
  labs(x = "Year", y = expression("Total PM"[2.5]*" Emission (Tons)")) + 
  ggtitle(expression(atop("Plot 6: PM"[2.5]*" Motor Vehicle Related Source Emissions 1999-2008",
                          atop("Baltimore City and LA County"))))
dev.off()
