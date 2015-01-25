# This code assumes you've downloaded and unzipped the file 
#   exdata-data-NEI_data.zip in your working directory.  If you haven't it's 
#   easy enough to write the code to check using file.exists etc

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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
  labs(title = expression("PM"[2.5]*" Motor Vehicle Related Source Emissions From Baltimore City from 1999-2008"))

dev.off()
