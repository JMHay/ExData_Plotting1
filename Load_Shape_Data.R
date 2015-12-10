################################################################################
# The purpose of this script is to get and shape the dataset needed to create
# the plots required in the assignment
################################################################################
#
# The following is an excerpt from the assignment:
# Loading the data
#
# When loading the dataset into R, please consider the following:
#  
# The dataset has 2,075,259 rows and 9 columns. First calculate a rough estimate 
# of how much memory the dataset will require in memory before reading into R. 
# Make sure your computer has enough memory (most modern computers should be fine).
#
# We will only be using data from the dates 2007-02-01 and 2007-02-02. One 
# alternative is to read the data from just those dates rather than reading in
# the entire dataset and subsetting to those dates.
#
# You may find it useful to convert the Date and Time variables to Date/Time 
# classes in R using the strptime() and as.Date() functions.
#
# Note that in this dataset missing values are coded as ?.
################################################################################

# Data Source:

## create a local directory for the data
localDir <- "hpc_data"
if (!file.exists(localDir)) {
  dir.create(localDir)
}

## download and unzip the data
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- paste(localDir,basename(url),sep='/')
if (!file.exists(file)) {
  download.file(url, file)
  unzip(file,exdir=localDir)
}

# list.files(localDir) returns
# [1] "exdata%2Fdata%2Fhousehold_power_consumption.zip"
# [2] "household_power_consumption.txt"   
# We'll work with the second file
file <- paste(localDir, "household_power_consumption.txt", sep = "/") 

# Estimate memory required
file.size(file) ## returns 20640916

################################################################################
## The file size is not too large, but for the sake of learning, we'll
## assume it is too large and only extract what is needed.
## We've been told there are more than 2M rows; we'll read increments of 500K,
## verify dates, and save only what we need.
################################################################################

# Load File

library(dplyr) ## this package makes data manipulation easier

## Determine the class of each column in the file
tmp_dt <- read.table(file, header = TRUE, nrows = 50, sep = ";")
classes <- sapply(tmp_dt, class)

## Set variables to read blocks of data from file
colHeader <- names(tmp_dt)
plot_dt <- read.table(text = "", colClasses = classes, col.names = colHeader)
skip_num <- seq(from = 1, to = 2500001, by = 500000)
nrow_num <- 500000

## Read file block by block
for (i in skip_num) {
  tmp_dt <- read.table(file, header = F, na.strings="?", skip = i, nrows = nrow_num, sep = ";", colClasses = classes, col.names = colHeader)
  tmp_dt_1 <- filter(tmp_dt, as.Date(Date, "%d/%m/%Y") == "2007-02-01")
  tmp_dt_2 <- filter(tmp_dt, as.Date(Date, "%d/%m/%Y") == "2007-02-02")
  plot_dt <- rbind(plot_dt, tmp_dt_1, tmp_dt_2)
}

## Clear Memory
rm(tmp_dt, tmp_dt_1, tmp_dt_2)

# Shape Data
plot_dt$Date_Time <- strptime(paste(plot_dt$Date, plot_dt$Time), "%d/%m/%Y %H:%M:%S")
