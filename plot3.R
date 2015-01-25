# Plot for Emissions Comparation in the Baltimore

# Firstly, uncompress the rds file into the workspace. Assumption the data is ready.
# And readRDS() data into NEI.

NEI <- readRDS("summarySCC_PM25.rds")

# Subset emission data in Baltimore
Baltimore_data <- subset(NEI, fips == "24510")

# Draw plot
library(ggplot2)

ggplot_baltimore <- ggplot(Baltimore_data, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") +
  labs(x="Year", y=expression("Emission (Tons)")) +
  labs(title=expression("Emissions in Baltimore City"))

ggsave(ggplot_baltimore, file = "plot3.png")
