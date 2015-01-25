# Plot for Emissions from PM2.5 in the United States

# Firstly, uncompress the rds file into the workspace. Assumption the data is ready.
# And readRDS() data into NEI.

NEI <- readRDS("summarySCC_PM25.rds")

# Aggregate by yearly total emission in Baltimore
Baltimore_data <- subset(NEI, fips == "24510")
plot_data <- aggregate(Emissions ~ year,Baltimore_data, sum)

# Draw plot
png('plot2.png', width=480, height=480)

barplot(names.arg = plot_data$year, plot_data$Emissions,
     main = " Emissions from PM2.5 in the Baltimore",
     xlab = "Year", ylab = "Emissions from PM2.5")

dev.off()