
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

#  Plot:
png("plot2.png", width = 480, height = 480)
plot(x=df.sub[, "DateTime"], y=df.sub[, "Global_active_power"], type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
