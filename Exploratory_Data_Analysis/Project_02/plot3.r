# This code assumes you've downloaded and unzipped the file 
#   exdata-data-NEI_data.zip in your working directory.  If you haven't it's 
#   easy enough to write the code to check using file.exists etc

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

Balt <- NEI[NEI$fips == "24510",]

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
  labs(title=expression("Plot 3: PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()