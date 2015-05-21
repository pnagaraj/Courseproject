run_analysis<-function() {
    # init filename locations of X,Y data
    fnametestX<-"~/Documents/coursera/UCI HAR Dataset/test/X_test.txt"
    fnametestY<-"~/Documents/coursera/UCI HAR Dataset/test/Y_test.txt"
    fnametrainX<-"~/Documents/coursera/UCI HAR Dataset/train/X_train.txt"
    fnametrainY<-"~/Documents/coursera/UCI HAR Dataset/train/Y_train.txt"
    # init filename: feature names,activity names
    fnameattr<-"~/Documents/coursera/UCI HAR Dataset//features.txt"
    fnameact<-"~/Documents/coursera/UCI HAR Dataset/activity_labels.txt"
    # inti filename: subject id
    fnametestsub<-"~/Documents/coursera/UCI HAR Dataset/test/subject_test.txt"
    fnametrainsub<-"~/Documents/coursera/UCI HAR Dataset/train/subject_train.txt"

     
    # Read the feature names,clean names
    fdataattr<-readLines(fnameattr,n=-1)
    attr.sub<-gsub("\\()" , "" ,fdataattr)

    attr.sub<-gsub("," , "-" ,attr.sub)
    attr.sub<-gsub("\\(" , "-" ,attr.sub)
    attr.sub<-gsub("\\)" , "" ,attr.sub)
    attr.tab<-read.table(textConnection(attr.sub))
    # Read the subject id
    fdatatestsub<-read.table(fnametestsub,col.names="subject")
    fdatatrainsub<-read.table(fnametrainsub,col.names="subject")
    
    # Read the activity levels, convert to readable text
    fdataact<-read.table(fnameact)
    ff<-sub("ING","",fdataact$V2) # remove "ING"
    ff<-sub("TT","T",ff)
    ff<-sub("\\_","",ff)
    # implementdescriptive names in second col
    # read ytest data
    fdatatesty<-readLines(fnametestY,n=-1)
    # replace all categories with their activity labels
    fe<-ff[1]
    actlev<-gsub("1",fe,fdatatesty)
    
    fe<-ff[2]
    actlev<-gsub("2",fe,actlev)
    
    fe<-ff[3]
    actlev<-gsub("3",fe,actlev)
    
    fe<-ff[4]
    actlev<-gsub("4",fe,actlev)
    
    fe<-ff[5]
    actlev<-gsub("5",fe,actlev)
    
    fe<-ff[6]
    actlev<-gsub("6",fe,actlev)
    actlev<-read.table(textConnection(actlev),col.names="activity")
    # train Y:implementdescriptive names in second col
    # read ytest data
    fdatatrainy<-readLines(fnametrainY,n=-1)
    # replace all categories with their activity labels
    fe<-ff[1]
    actlev2<-gsub("1",fe,fdatatrainy)
    
    fe<-ff[2]
    actlev2<-gsub("2",fe,actlev2)
    
    fe<-ff[3]
    actlev2<-gsub("3",fe,actlev2)
    
    fe<-ff[4]
    actlev2<-gsub("4",fe,actlev2)
    
    fe<-ff[5]
    actlev2<-gsub("5",fe,actlev2)
    
    fe<-ff[6]
    actlev2<-gsub("6",fe,actlev2)
    
    actlev2<-read.table(textConnection(actlev2),col.names="activity")
    # Read the test data X,Y
    fdatatestX<-read.table(fnametestX,col.names=as.character(attr.tab[,2]))
    fdatatestY<-read.table(fnametestY,col.names="activity_level")
    
    # Read the train data X and bi
    fdatatrainX<-read.table(fnametrainX,col.names=as.character(attr.tab[,2]))
    fdatatrainY<-read.table(fnametrainY,col.names="activity_level")
    
    # merge subject id of train and test data
    fdatasub<-rbind(fdatatrainsub,fdatatestsub)
    
    #merge train and test data
    fdatatrain<-cbind(fdatatrainX,fdatatrainY)
    fdatatrain<-cbind(fdatatrain,actlev2)
    fdatatest<-cbind(fdatatestX,fdatatestY)
    fdatatest<-cbind(fdatatest,actlev)
    fdata<-rbind(fdatatrain,fdatatest)
    #append subject column
    fdata<-cbind(fdata,fdatasub)
    
    # get col indices that have mean in the feature name
    # also get col indices that have subject and activity data
    colidxmean<-grep("mean",tolower(attr.sub))
    colidxstd<-grep("std",tolower(attr.sub))
    colidx<-c(colidxmean,colidxstd,562,564)
    # extract cols that have mean or std
    fdatasel<-fdata[,colidx]
    # calculate mean for each activity and each subject
    agg<-aggregate(fdatasel,by=list(fdatasel$subject,fdatasel$activity_level),FUN=mean,na.rm=TRUE)
    # replace activity_level values by descriptive names
    agg$activity_level[agg$activity_level==1] <-ff[1]
    agg$activity_level[agg$activity_level==2] <-ff[2]
    agg$activity_level[agg$activity_level==3] <-ff[3]
    agg$activity_level[agg$activity_level==4] <-ff[4]
    agg$activity_level[agg$activity_level==5] <-ff[5]
    agg$activity_level[agg$activity_level==6] <-ff[6]
    # rename activity_level to activity
    agg <-rename(agg,c(activity_level="activity"))
    
    # remove Group.1 and Group.2 
    myvars<-names(agg) %in% c("Group.1", "Group.2")
    aggnew<-agg[!myvars]
    
    # write tidy data table 
    write.table(aggnew,file="~/Documents/coursera/tidydata",row.name=FALSE)
       
}