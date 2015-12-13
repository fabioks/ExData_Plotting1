#Setting file name
file <- "household_power_consumption.zip"

#Download file if it was not already downloaded
if(!file.exists(file))
{
        URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(URL, file)
}

##Checking if file exists, if not, unzip the data
if(!file.exists("household_power_consumption"))
{
        unzip(file)
}

#Reading the required data only
data <- read.table("household_power_consumption.txt", header = FALSE, skip = 66637, nrows = 2880, sep = ";",
                   na.strings = "?", stringsAsFactors = FALSE, dec = ".")

#Configuring column names
names <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
           "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

#Setting column names
colnames(data) <- names

#Converting date column do Date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

#Creating new column with date and time
DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(DateTime)

#Plotting
plot(data$Sub_metering_1 ~ data$DateTime, type = "l", ylab = "Energy sub metering", xlab = "")
lines(data$Sub_metering_2 ~ data$DateTime, type = "l", col = "red")
lines(data$Sub_metering_3 ~ data$DateTime, type = "l", col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5,
       col=c("black", "red", "blue"), cex = .75)

#Saving to file png
dev.copy(png, filename = "plot3.png", height = 480, width = 480)

#Shutting off device
dev.off()

