plot1<-function(){
dfile<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fname<-"~/Documents/coursera/datasets/household_power_consumption.zip"
download.file(dfile,fname,method="curl",mode="wb")
con<-unzip(fname)


data<-read.table(con,sep=";",header=TRUE,na.strings="?")
index<-which(data$Date=="1/2/2007" | data$Date=="2/2/2007")
length(index)
data.sub<-na.omit(data[index,]) # read data for above two dates

# check fonts of title and axes
par("font.main")
par("font.sub")
png(filename="plot1.png",width=480,height=480) #open device
hist(as.numeric(data.sub$Global_active_power),xlab="",ylab="",axes=FALSE,col="red",main="")
axis(1,seq(0,6,2))
axis(2,seq(0,1200,200))
title(main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency")
dev.off()
unlink(fname)
}