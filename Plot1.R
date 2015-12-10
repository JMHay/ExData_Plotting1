
source("Load_Shape_Data.R") #creates the dataset plot_dt

## Create plot1.png
  # open graphics device
  png("plot1.png", width = 480, height = 480, units = "px")
  # set breaks
  breaks <- c(0, 0.5, 1, 1.5, 2, 2.5, 3, 3.5, 4, 4.5, 5, 5.5, 6, 6.5)
  # set label for x-axis
  xlab = 'Global Active Power (kilowatts)'
  # create histogram
  hist(as.numeric(plot_dt$Global_active_power), main = "Global Active Power", col = "Red", xlab=xlab)
  # close graphics device
  dev.off()

