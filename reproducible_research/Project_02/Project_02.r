# Reproducible Research
# Project 02

# Assumes you have downloaded the bz2 file to your working directory

StormData <- read.csv(bzfile("repdata-data-StormData.csv.bz2"))
columns <- c("BGN_DATE","BGN_TIME","STATE","EVTYPE","FATALITIES","INJURIES","PROPDMG","PROPDMGEXP")
StormData2 <- StormData[,columns]

# Clean PROPDMGEXP
# Get rid of NA values
StormData2 <- subset(StormData2, StormData2$PROPDMGEXP!='+' &
                       StormData2$PROPDMGEXP!='-' & 
                       StormData2$PROPDMGEXP!='?')

StormData2$PROPDMGEXP <- toupper(StormData2$PROPDMGEXP)

# PROPDMGEXP gives the 'exponent' value of the property damage
old_vals <- c('0', '1', '2', '3', '4', '5', '6', '7', '8', 'H', 'K', 'M', 'B', '')
new_vals <- c(1, 0.1*10^3, 0.2*10^3, 0.3*10^3, 0.4*10^3, 0.5*10^3, 0.6*10^3, 0.7*10^3, 0.8*10^3, 
              10^2, 10^3, 10^6, 10^9, 1)

for(idx in 1:length(old_vals)){StormData2[StormData2$PROPDMGEXP == old_vals[idx], ]$PROPDMGEXP <- new_vals[idx]}
# Add in new column with real property damage value
StormData2$Damage <- as.numeric(StormData2$PROPDMG) * as.numeric(StormData2$PROPDMGEXP)

Totals.Injuries <- aggregate(formula = INJURIES ~ EVTYPE,
                             data = StormData2,
                             FUN = sum)
# Sort by most injuries
Totals.Injuries <- Totals.Injuries[order(x = Totals.Injuries$INJURIES, 
                                         decreasing = TRUE), ]
# Now for fatalities
Totals.Fatalities <- aggregate(formula = FATALITIES ~ EVTYPE,
                             data = StormData2,
                             FUN = sum)
# Sort by most fatalities
Totals.Fatalities <- Totals.Fatalities[order(x = Totals.Fatalities$FATALITIES, 
                                         decreasing = TRUE), ]
# And now for property damage
Totals.Damage <- aggregate(formula = Damage ~ EVTYPE, 
                           data = StormData2, 
                           FUN = sum)
# Sort by most damage
Totals.Damage <- Totals.Damage[order(x = Totals.Damage$Damage, 
                                         decreasing = TRUE), ]
# Plots of the top 10 for each category

barplot(height = Totals.Injuries$INJURIES[1:10],
        names.arg = Totals.Injuries$EVTYPE[1:10],
        main = "Top 10 Storm Sources of Injuries",
        xlab = "Source of Injuries")


