library(dplyr)
library(reshape2)

# read in the feature variables' names
nam1<-read.table("./features.txt")

### Test data ###
# read in the test data
test1<-read.table("./test/subject_test.txt")
test2<-read.table("./test/y_test.txt")
test3<-read.table("./test/x_test.txt")

#assign variables' names
colnames(test1)<-"subject"
colnames(test2)<-"activity"
colnames(test3)<-nam1[,2]

# put them all together
test<-cbind(test1, test2, test3)

### Train data ###
# read in the test data
train1<-read.table("./train/subject_train.txt")
train2<-read.table("./train/y_train.txt")
train3<-read.table("./train/x_train.txt")

#assign variables' names
colnames(train1)<-"subject"
colnames(train2)<-"activity"
colnames(train3)<-nam1[,2]

# put them all together
train<-cbind(train1, train2, train3)

### Put test and train data together ###
actdata<-rbind(test, train)

### Extract only the measures of the mean and std
nam2<-c("subject", "activity", as.character(nam1[grepl("mean\\()",nam1$V2)| grepl("std\\()",nam1$V2),2]))
actdata1<-actdata[,nam2]

### Add activity names
actnames<-read.table("./activity_labels.txt")
actdata2<-merge(actdata1,actnames,by.x="activity", by.y="V1", all=TRUE)

# Drop activity numbers, move activity name to the left
actdata3<-select(actdata2, V2, everything(), -activity)

# Rename the variables  
colnames(actdata3)<-gsub("-", "", names(actdata3))            # remove -
colnames(actdata3)<-gsub("mean\\()", "mean.", names(actdata3))         # replace mean() with mean.
colnames(actdata3)<-gsub("std\\()", "std.", names(actdata3))         # replace std() with std.
colnames(actdata3)<-gsub("^t", "time.", names(actdata3))      # replace "t" with "time"
colnames(actdata3)<-gsub("^f", "freq.", names(actdata3))      # replace "f" with "freq"
colnames(actdata3)<-gsub("BodyBody", "Body", names(actdata3))      # fix double "body" 
colnames(actdata3)<-gsub("Body", "body.", names(actdata3))      # fix double "body" 
colnames(actdata3)<-gsub("Gravity", "gravity.", names(actdata3))      # more fixes
colnames(actdata3)<-gsub("Acc", "accelerometer.", names(actdata3))      
colnames(actdata3)<-gsub("X", "x", names(actdata3))  
colnames(actdata3)<-gsub("Y", "y", names(actdata3))  
colnames(actdata3)<-gsub("Z", "z", names(actdata3))  
colnames(actdata3)<-gsub("Gyro", "gyroscope.", names(actdata3))  
colnames(actdata3)<-gsub("Jerk", "jerk.", names(actdata3))
colnames(actdata3)<-gsub("Mag", "magnitude.", names(actdata3))
colnames(actdata3)[1]<-"activity"

# Group and calculate the means
actdata_grouped<-group_by(actdata3, activity, subject)
result<-summarize_all(actdata_grouped, .funs = c(mean="mean"))
colnames(result)<-gsub("_mean", "", names(result))
names(result)

# Tidy it up to get one variable per column
nam3<-names(result)[3:68]
small_melt<-melt(result, id=c("activity", "subject"), measure.vars=nam3)

small_melt$domain<-substr(small_melt$variable,1,4)
small_melt$variable<-gsub("time.", "", small_melt$variable)
small_melt$variable<-gsub("freq.", "", small_melt$variable)

small_melt$signal<-substr(small_melt$variable,1,(regexpr("\\.", small_melt$variable)-1))  
small_melt$variable<-gsub("body.", "", small_melt$variable)
small_melt$variable<-gsub("gravity.", "", small_melt$variable)  
  
small_melt$device<-substr(small_melt$variable,1,(regexpr("\\.", small_melt$variable)-1))  
small_melt$variable<-gsub("accelerometer.", "", small_melt$variable)
small_melt$variable<-gsub("gyroscope.", "", small_melt$variable)  

small_melt$jerk.signal<-(grepl("jerk",small_melt$variable)) 
small_melt$variable<-gsub("jerk.", "", small_melt$variable)

small_melt$signal.magnitude<-(grepl("magnitude",small_melt$variable)) 
small_melt$variable<-gsub("magnitude.", "", small_melt$variable)

small_melt$statistic<-substr(small_melt$variable,1,(regexpr("\\.", small_melt$variable)-1))  
small_melt$variable<-gsub("mean.", "", small_melt$variable)
small_melt$variable<-gsub("std.", "", small_melt$variable)  

small_melt$axis=small_melt$variable
small_melt<-small_melt[,-3]

# split on STD and Mean
means<-small_melt[which(small_melt$statistic=="mean"),]
colnames(means)[3]<-"average.of.mean"
means<-means[,-9]

stds<-small_melt[which(small_melt$statistic=="std"),]
colnames(stds)[3]<-"average.of.std"
stds<-stds[,-9]

# put them back together into one file
result1<-merge(means,stds, all=TRUE)
result1<-select(result1, subject, everything())

# save the result as text file
write.table(result1, file="./result.txt", row.name=FALSE)
