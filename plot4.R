#Read the data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

#Get the needed data for coal combustion-related sources
SCC <- SCC[grep("[Cc]ombustion", SCC$SCC.Level.One),]
test3 <- unique(c(grep("[Cc]oal", SCC$SCC.Level.Three),grep("[Cc]oal", SCC$SCC.Level.Four)))
SCC <- SCC[test3,]
needed <- NEI[NEI$SCC %in% SCC$SCC,]

#Get the total PM2.5 emissions for all sources for each year
Total_Emissions <- sapply(split(needed$Emissions,needed$year), sum)

#convert the vector obtained above into a data frame forp plotting.
Total_PM25 = data.frame(year = as.numeric(as.character(names(Total_Emissions))), emissions = Total_Emissions)

#Plot the graph
png(file = "plot4.png", width = 480, height = 480, units = "px")
plot(Total_PM25$year, Total_PM25$emissions,
     type = "o",
     xlab = "year",
     ylab = "Emissions from coal combustion-related sources",
     main = "Changes in emissions from coal combustion-related sources",
     pch = 19,
     col = c(1:4))
legend("topright",
       legend = c("1999","2002","2005","2008"),
       pch = 19,
       col = c(1:4))
dev.off()