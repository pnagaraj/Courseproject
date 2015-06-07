plot2<-function(){
    dfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    fname<-"~/Documents/coursera/datasets/household_power_consumption.zip"
    download.file(dfile,fname,method="curl",mode="wb")
    con<-unzip(fname)
    
    
    data<-read.table(con,sep=";",header=TRUE,na.strings="?")
    index<-which(data$Date=="1/2/2007" | data$Date=="2/2/2007")
    length(index)
    data.sub<-na.omit(data[index,]) # read data for above two dates
    # plot 2
    index<-which(data$Date=="1/2/2007" | data$Date=="2/2/2007")
    length(index)
    t<-paste(data$Date[index],data$Time[index],sep=" ") # concatenate date and time
    form<-"%d/%m/%Y %H:%M:%S"
    x<-weekdays(strptime(t,format=form),abbreviate=TRUE)
    index2<-which(x=="Thu" | x=="Fri" | x=="Sat")
    
    y<-data$Global_active_power[index]
    
    png(filename="plot2.png",width=480,height=480) #open device
    plot(y[index2],axes=FALSE,type="l",main=NA,xlab=NA,ylab=NA)
    box(lty="solid")
    len1<-length(which(x=="Thu"))
    len2<-length(which(x=="Fri"))
    tick1<-c(1,len1+1,len2+len1) # tick marks
    lab<-c("Thu","Fri","Sat")
    axis(1,at=tick1,labels=lab)
    axis(2,seq(0,6,2))
    title(main=" ",ylab="Global Active Power (kilowatts)")
    dev.off()
    unlink(fname)
}