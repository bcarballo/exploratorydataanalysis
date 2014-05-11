#Plot 3

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
  #Create the Date_Time column which combines:$Date and $Time columns
  hpc$Date_Time<-paste(hpc$Date,hpc$Time, sep=" ")
  #Format Date_Time column
  hpc$Date_Time<-strptime(hpc$Date_Time,"%d/%m/%Y %H:%M:%S")

#Plot and save the graph number 3
  #Load the libraries needed to plot the graph
  library(ggplot2)
  library(scales)
  library(grid)
  #Choose the directory where you want to save the plot
  dir<-choose.dir(default = "", caption = "Select directory")
  #Set the working directory
  setwd(dir)
  #Graphics device PNG to save the plot 3 in png format (480x480)
  png("plot3.png",width = 480, height = 480, units = "px")
  #Plot the graph
  ggplot(hpc, aes(x=Date_Time, y = value)) + 
    geom_line(aes(y = Sub_metering_1, col = "Sub_metering_1")) + 
    geom_line(aes(y = Sub_metering_2, col = "Sub_metering_2")) + 
    geom_line(aes(y = Sub_metering_3, col = "Sub_metering_3")) + 
    scale_colour_manual(values=c("black","red","blue")) + 
    scale_x_datetime(breaks = date_breaks("1 day"),labels=date_format("%a")) +
    theme_bw() + 
    theme(panel.grid.major=element_line(colour=NA),
          panel.grid.minor=element_line(colour=NA),
          legend.title=element_blank(),
          legend.position=c(0.8565,0.9225),
          legend.key = element_blank(),
          legend.background = element_rect(colour = "black"),
          legend.text = element_text(size=12),
          axis.title.y=element_text(size=13, vjust=0.20),
          axis.text.y=element_text(size=12,angle=90, hjust=0.5, vjust=0.25),
          axis.text.x=element_text(size=13,vjust=1),
          axis.line=element_line(color="black"),
          axis.ticks.length=unit(0.3,"cm"),
          axis.ticks.margin=unit(0.2,"cm")) +
    xlab("") +
    ylab("Energy sub metering")
  #Close the graphics device
  dev.off()