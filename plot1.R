####################################################################
# Plot 1
# The total PM2.5 Emissions in US have decreased from 1999 to 2008
####################################################################

#Read the data
NEI <- readRDS("summarySCC_PM25.rds")[,c(4,6)]
SCC <- readRDS("Source_Classification_Code.rds")

#Get the total PM2.5 emissions from all sources for each year
Total_Emissions <- sapply(split(NEI$Emissions,NEI$year), sum)

#convert the vector obtained above into a data frame for plotting.
Total_PM25 = data.frame(year = as.numeric(as.character(names(Total_Emissions))), emissions = Total_Emissions)

#Open the png device to store the plot as a .png file
png(file = "plot1.png", width = 480, height = 480, units = "px")

#Plot the graphusing the plot function.
plot(Total_PM25$year, Total_PM25$emissions,            #Data to be plotted   
     type = "o",                                       #plotting both line and point
     pch = 19,                                         #Shape of the points plotted
     col = c(1:4),                                     #Colour of the points plotted
     xlab = "Year",                                    #X-Axis label
     ylab = "Total PM2.5 Emissions(Tonnes)",           #Y-Axis label  
     main = "Change in total PM2.5 Emissions")         #graph title
legend("topright",                                     #Adding a legend
       legend = c(1999,2002,2005,2008), 
       pch = 19,
       col = c(1:4))     

#Closing the png device.
dev.off()