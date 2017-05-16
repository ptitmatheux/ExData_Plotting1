
# unzipping and loading the whole dataset into R:
zipfile <- "data/exdata_data_household_power_consumption"
system(paste("unzip", zipfile, "-d data/"))
txtfile <- "data/household_power_consumption.txt"
df <- read.csv(txtfile, header=TRUE, sep=";", na.strings="?", colClasses=c(rep("character", 2), rep("numeric", 7)))
system(paste("rm ", txtfile))

# Adding a column containing the date + time observations as date-time objects:
df[["DateTime"]] <-  strptime(mapply(paste0, df[, "Date"], df[, "Time"]), format="%d/%m/%Y %H:%M:%S")
# subsetting the dataset to the relevant time interval:
df.sub <- subset.data.frame(df, DateTime >= strptime("2007/02/01", format="%Y/%m/%d") & DateTime < strptime("2007/02/03", format="%Y/%m/%d"))

# Plot:
png("plot3.png", width = 480, height = 480)
plot(x=df.sub[, "DateTime"], y=df.sub[, "Sub_metering_1"], type="l", xlab="", ylab="Energy sub metering")
lines(x=df.sub[, "DateTime"], y=df.sub[, "Sub_metering_2"], type="l", col="red")
lines(x=df.sub[, "DateTime"], y=df.sub[, "Sub_metering_3"], type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1, 1, 1), col=c("black", "red", "blue"))
dev.off()
