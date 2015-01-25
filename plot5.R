# Plot for Vechicle Emissions in the Baltimore

# Firstly, uncompress the rds file into the workspace. Assumption the data is ready.
# And readRDS() data into NEI.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Generate Data
vehicle_emission <- grep("vehicle",SCC$EI.Sector,value=T,ignore.case=T)
SCC_vehicle <- subset(SCC, EI.Sector %in% vehicle_emission, select=SCC)
Baltimore_emission <- subset(NEI, fips == "24510")
NEI_vehicle <- subset(Baltimore_emission, SCC %in% SCC_vehicle$SCC)
plot_vechile <- aggregate(NEI_vehicle[c("Emissions")], list(year = NEI_vehicle$year), sum)

# Draw plot
library(ggplot2)

plot_data <- ggplot(plot_vechile, aes(x=year, y=Emissions)) +
  geom_bar(stat="identity") +
  labs(x="Year", y=expression("Emission (Tons)")) +
  labs(title=expression("Emissions in Baltimore"))

ggsave(plot_data, file = "plot5.png")