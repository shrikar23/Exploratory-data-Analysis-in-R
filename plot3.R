#load the dplyr and ggplot2 packages
library("dplyr")
library("ggplot2")

#Read the data
NEI <- readRDS("summarySCC_PM25.rds")

#Select the data for Baltimore City
needed <- NEI[NEI$fips == "24510",c(4:6)]
needed <- tbl_df(needed)

#Get the total of PM2.5 emissions grouped by year and type.
needed <- summarize(group_by(needed, type, year), total = sum(Emissions))

#plot the graph by calling the qplot function from ggplot2 function.
png(file = "plot3.png", width = 480, height = 480, units = "px")
qplot(year, total, data = needed, geom = c("line","point"), color = type)
dev.off()