# Plot for Vechicle Emissions in the Baltimore & LA

# Firstly, uncompress the rds file into the workspace. Assumption the data is ready.
# And readRDS() data into NEI.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Generate Data
vehicle_emission <- grep("vehicle",SCC$EI.Sector,value=T,ignore.case=T)
SCC_vehicle <- subset(SCC, EI.Sector %in% vehicle_emission, select=SCC)
NEI_vehicle <- subset(NEI, SCC %in% SCC_vehicle$SCC)

NEI_Baltimore <- NEI_vehicle[NEI_vehicle$fips=="24510",]
NEI_Baltimore$city <- "Baltimore"
NEI_LA <- NEI_vehicle[NEI_vehicle$fips=="06037",]
NEI_LA$city <- "Los Angeles"

NEI_Comparasion <- rbind(NEI_Baltimore, NEI_LA)

# Draw plot
library(ggplot2)

plot_data <- ggplot(NEI_Comparasion, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="Year", y=expression("Emission (Tons)")) +
  labs(title=expression("Emissions in Baltimore & LA"))

ggsave(plot_data, file = "plot6.png")