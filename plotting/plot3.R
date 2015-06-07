plot3<-function(){
    dfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    fname<-"~/Documents/coursera/datasets/household_power_consumption.zip"
    download.file(dfile,fname,method="curl",mode="wb")
    con<-unzip(fname)
    
    
    data<-read.table(con,sep=";",header=TRUE,na.strings="?")
    index<-which(data$Date=="1/2/2007" | data$Date=="2/2/2007")
    length(index)
    data.sub<-na.omit(data[index,]) # read data for above two dates
    # plot 3
    png(filename="plot3.png",width=480,height=480) #open device
    y1<-data$Sub_metering_1[index]
    y2<-data$Sub_metering_2[index]
    y3<-data$Sub_metering_3[index]
    ylim<-max(c(max(y1),max(y2),max(y3)))
    plot(y1[index2],axes=FALSE,type="l",main=NA,xlab=NA,ylab=NA)
    axis(1,at=tick1,labels=lab)
    axis(2,seq(0,ylim,10))
    lines(y2[index2],col="red")
    lines(y3[index2],col="blue")
    box(lty="solid")
    title(ylab="Energy sub metering")
    legend('topright',c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","blue","red"))
    dev.off()
    unlink(fname)
}