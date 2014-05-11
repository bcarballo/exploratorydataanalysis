#Plot 1

##Set system time
Sys.setlocale("LC_TIME", "English")

#Select and read the file: household_power_consumption"
  #This will pop-up a GUI so look for it
  filename <- file.choose(new=FALSE)
  #Read just the data between 1/2/2007 and 2/2/2007
  con <- textConnection( grep( "^1/2/2007|^2/2/2007", readLines(filename), value=TRUE))
  #Became the data read to a dataframe
  hpc <- read.csv( con, sep=';', header=FALSE,stringsAsFactors=FALSE)
  #Close connection
  close(con)
  #Read just the first row from the file to get the names of the columns
  columnames<-read.csv(filename,sep=";",header=FALSE,nrow=1,stringsAsFactors=FALSE)
  #Name the column
  names(hpc)<-columnames[1,]

#Plot and save the graph number 1
  #Choose the directory where you want to save the plot
  dir<-choose.dir(default = "", caption = "Select directory")
  #Set the working directory
  setwd(dir)
  #Graphics device PNG to save the plot 1 in png format (480x480)
  png("plot1.png",width = 480, height = 480, units = "px")
  #Plot the histogram
  hist(hpc$Global_active_power, col="red", xlab="Global Active Power (kilowatts)",main="Global Active Power")
  #Close the graphics device
  dev.off()