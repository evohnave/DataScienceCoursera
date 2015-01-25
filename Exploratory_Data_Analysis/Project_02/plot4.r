# This code assumes you've downloaded and unzipped the file 
#   exdata-data-NEI_data.zip in your working directory.  If you haven't it's 
#   easy enough to write the code to check using file.exists etc

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

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
  labs(title = expression("Plot 4: PM"[2.5]*" Coal-Combustion Related Source Emissions Across US from 1999-2008"))

dev.off()