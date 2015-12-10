
source("Load_Shape_Data.R") #creates the dataset plot_dt

## Create plot2.png
  # open graphics device
  png("plot2.png", width = 480, height = 480, units = "px")
  # set label for x-axis
  xlab = ''
  ylab = 'Global Active Power (kilowatts)'
  # create line chart
  plot(x=c(1:2880), y=plot_dt$Global_active_power, type="l", xlab = xlab, ylab = ylab)
  # close graphics device
  dev.off()

