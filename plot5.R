###################################################################################################
#Plot 5
#The emissions from motor vechicles have decrease from 1999-2008 in Baltimore.
#The sources considered as motor vechicles sources are:
#the sources for which SCC.Level.Twoc in source_Classification_Code.rds is "Vechicles" or "vechicles"
#####################################################################################################

#Load the ggplot2 library
library("ggplot2")

#Read the data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

#Get the needed data for motor vehicles sources for Baltimore City, Maryland.
SCC <- SCC[grep("[Vv]ehicles", SCC$SCC.Level.Two),]
needed <- NEI[NEI$SCC %in% SCC$SCC,]
needed <- needed[needed$fips == "24510",]

#Get the total PM2.5 emissions for all sources for each year
Total_Emissions <- sapply(split(needed$Emissions,needed$year), sum)

#convert the vector obtained above into a data frame for plotting.
Total_PM25 = data.frame(year1 = as.numeric(as.character(names(Total_Emissions))), emissions = Total_Emissions, year = names(Total_Emissions))

#Open the png device to store the plot as .png file.
png(file = "plot5.png", width = 480, height = 480, units = "px")

#plot the graph by calling the ggplot function from ggplot2 function.
ggplot(data = Total_PM25, aes(x = year1, y = emissions)) +                      #Get the data
      geom_line() +                                                             #Plot the line
      geom_point(aes(color = year),size = 3) +                                  #Plot the points for each year
      labs(title = "Change in Total Motor Vechicle Emissions in Baltimore") +   #Title
      labs(y = "Total Motor Vechicle Emissions(Tonnes)", x = "Year")            #X and Y axis labels  

#Close the png device.
dev.off()