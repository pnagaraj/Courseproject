plot4<-function(){
    dfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    fname<-"~/Documents/coursera/datasets/household_power_consumption.zip"
    download.file(dfile,fname,method="curl",mode="wb")
    con<-unzip(fname)
    
    
    data<-read.table(con,sep=";",header=TRUE,na.strings="?")
    index<-which(data$Date=="1/2/2007" | data$Date=="2/2/2007")
    length(index)
    data.sub<-na.omit(data[index,]) # read data for above two dates
    
    # plot 4
    
    png(filename="plot4.png",width=480,height=480) #open device)
    par(mfrow=c(2,2),mar=c(3.2,3.8,1,1),ps = 10 ,cex=1,mgp=c(1.4,0.5,0))
    
    # top left
    plot(y[index2],axes=FALSE,type="l",main=NA,xlab=NA,ylab=NA)
    box(lty="solid")
    len1<-length(which(x=="Thu"))
    len2<-length(which(x=="Fri"))
    tick1<-c(1,len1+1,len2+len1) # tick marks
    lab<-c("Thu","Fri","Sat")
    axis(1,at=tick1,labels=lab,tck=-0.05)
    axis(2,seq(0,6,2),tck=-0.05)
    title(main=" ",ylab="Global Active Power",cex.lab=1)
    #top right
    y4<-data$Voltage[index]
    ylim4<-max(y4)
    plot(y4[index2],axes=FALSE,type="l",main=NA,xlab=NA,ylab=NA)
    axis(1,at=tick1,labels=lab,tck=-0.05)
    axis(2,seq(234,ylim4,2),tck=-0.05)
    title(main=" ",xlab="datetime",ylab="Voltage",cex.lab=1)
    box(lty="solid")
    
    # bottom left
    #par(cex=0.7)
    plot(y1[index2],axes=FALSE,type="l",main=NA,xlab=NA,ylab=NA)
    axis(1,at=tick1,labels=lab,tck=-0.05)
    axis(2,seq(0,ylim,10),tck=-0.05)
    lines(y2[index2],col="red")
    lines(y3[index2],col="blue")
    
    legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","blue","red"),cex=0.7)
    box(lty="solid")
    title(main=" ",ylab="Energy sub metering",cex.lab=1)
    
    
    # bottom right
    y5<-data$Global_reactive_power[index]
    ylim5<-max(y5)
    plot(y5[index2],axes=FALSE,type="l",main=NA,xlab=NA,ylab=NA)
    axis(1,at=tick1,labels=lab,tck=-0.05)
    axis(2,seq(0,ylim5,0.1),tck=-0.05)
    title(main=" ",xlab="datetime",ylab="Global_reactive_power",cex.lab=1)
    box(lty="solid")
    dev.off()
    # deletes fname
    
    unlink(fname)
}