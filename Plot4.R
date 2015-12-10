
source("Load_Shape_Data.R") #creates the dataset plot_dt

## Create plot2.png
  # open graphics device
  png("plot3.png", width = 480, height = 480, units = "px")
  # set label for x-axis
  xlab = ''
  ylab = 'Energy sub metering'
  # create chart with three lines
  plot(x=plot_dt$Date_Time, y=plot_dt$Sub_metering_1, type="l", xlab = xlab, ylab = ylab)
  lines(x=plot_dt$Date_Time, y=plot_dt$Sub_metering_2, type="l", col="Red")
  lines(x=plot_dt$Date_Time, y=plot_dt$Sub_metering_3, type="l", col="Blue")
  # add legend
  legend("topright", lty=1, lwd=1, col=c("Black","Red","Blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  # close graphics device
  dev.off()

