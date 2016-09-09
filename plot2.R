#Read the data
NEI <- readRDS("summarySCC_PM25.rds")[,c(1,4,6)]
NEI <- NEI[NEI$fips == "24510",]    #get the data only for Baltimore City

#Get the total PM2.5 emissions for all sources for each year
Total_Emissions <- sapply(split(NEI$Emissions,NEI$year), sum)

#convert the vector obtained above into a data frame forp plotting.
Total_PM25 = data.frame(year = as.numeric(as.character(names(Total_Emissions))), emissions = Total_Emissions)

#Plot the graph 
png(file = "plot2.png", width = 480, height = 480, units = "px")
plot(Total_PM25$year, Total_PM25$emissions, 
     type = "o",                                     #plot
     xlab = "Year", 
     ylab = "Total PM2.5 Emissions(Tonnes)",
     main = "Total PM2.5 Emissions in Baltimore City from 1999 to 2008",
     pch = 19,
     col = c(1:4))
legend("topright",
       legend = c("1999","2002","2005","2008"),
       pch = 19,
       col = c(1:4))        
dev.off()