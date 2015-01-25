# Plot for Coal Emissions from PM2.5 in the United States

# Firstly, uncompress the rds file into the workspace. Assumption the data is ready.
# And readRDS() data into NEI.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal <- grep("coal",SCC$EI.Sector,value=T,ignore.case=T)
SRC_coal <- subset(SCC, EI.Sector %in% coal, select=SCC)
NEI_coal <- subset(NEI, SCC %in% SRC_coal$SCC)

plot_coal <- aggregate(NEI_coal[c("Emissions")], list(year = NEI_coal$year), sum)

# Draw plot
library(ggplot2)

plot_data <- ggplot(plot_coal, aes(x=year, y=Emissions)) +
  geom_bar(stat="identity") +
  labs(x="Year", y=expression("Emission (Tons)")) +
  labs(title=expression("Emissions"))

ggsave(plot_data, file = "plot4.png")
