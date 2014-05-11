#Plot 4

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

#Plot and save the graph number 4
  #Load the libraries needed to plot the graph
  library(ggplot2)
  library(scales)
  library(grid)
  library(gridExtra)
  #Choose the directory where you want to save the plot
  dir<-choose.dir(default = "", caption = "Select directory")
  #Set the working directory
  setwd(dir)
  #Graphics device PNG to save the plot 4 in png format (480x480)
  png("plot4.png",width = 480, height = 480, units = "px")
  #Plot the graph
  p1<-ggplot(hpc, aes(x=Date_Time, y=Global_active_power)) +
    geom_line() + 
    scale_x_datetime(breaks = date_breaks("1 day"),
                     labels=date_format("%a")) + 
    theme_bw() + 
    theme(panel.grid.major=element_line(colour=NA),
          panel.grid.minor=element_line(colour=NA), 
          axis.title.y=element_text(vjust=0.25),
          axis.text.y=element_text(angle=90, hjust=0.5)) + 
    ylab("Global Active Power")+xlab("")
  
  p2<-ggplot(hpc, aes(x=Date_Time, y=Voltage)) +
    geom_line() + 
    scale_x_datetime(breaks = date_breaks("1 day"),
                     labels=date_format("%a")) + 
    scale_y_continuous(breaks=c(seq(234,246,2)),labels=c("234","","238","","242","","246")) +
    theme_bw() + 
    theme(panel.grid.major=element_line(colour=NA),
          panel.grid.minor=element_line(colour=NA), 
          axis.title.y=element_text(vjust=0.25),
          axis.title.x=element_text(size=10),
          axis.text.y=element_text(angle=90, hjust=0.5)) + 
    ylab("Voltage")
  
  p3<-ggplot(hpc, aes(x=Date_Time, y = value)) + 
    geom_line(aes(y = Sub_metering_1, col = "Sub_metering_1")) + 
    geom_line(aes(y = Sub_metering_2, col = "Sub_metering_2")) + 
    geom_line(aes(y = Sub_metering_3, col = "Sub_metering_3")) + 
    scale_colour_manual(values=c("black","red","blue")) + 
    scale_x_datetime(breaks = date_breaks("1 day"),labels=date_format("%a")) +
    theme_bw() + 
    theme(panel.grid.major=element_line(colour=NA),
          panel.grid.minor=element_line(colour=NA),
          legend.title=element_blank(),
          legend.position=c(0.715,0.85),
          legend.key = element_blank(),
          legend.background = element_blank(),
          axis.title.y=element_text(vjust=0.25),
          axis.text.y=element_text(angle=90, hjust=0.5)) +
    xlab("") +
    ylab("Energy sub metering")
  
  p4<-ggplot(hpc, aes(x=Date_Time, y=Global_reactive_power)) +
    geom_line() + 
    scale_x_datetime(breaks = date_breaks("1 day"),
                     labels=date_format("%a")) + 
    theme_bw() + 
    theme(panel.grid.major=element_line(colour=NA),
          panel.grid.minor=element_line(colour=NA), 
          axis.title.y=element_text(vjust=0.25),
          axis.title.x=element_text(size=10),
          axis.text.y=element_text(angle=90, hjust=0.5)) 
  #Put the 4 plots together
  grid.arrange(p1,p2,p3,p4)
  
  #Close the graphics device
  dev.off()