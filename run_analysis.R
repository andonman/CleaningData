#Reading Data into R (this scripts expects all data to be inside data subfolder of home directory:

subjtst <- read.table("./data/test/subject_test.txt")    # V1 column name
subjtrn<- read.table("./data/train/subject_train.txt")   # V1 column name

Xtst<- read.table("./data/test/X_test.txt")   # V1 -> V561 column names
Xtrn<- read.table("./data/train/X_train.txt") # V1 -> V561 column names

Ytst<- read.table("./data/test/y_test.txt")   # V1 column name
Ytrn<- read.table("./data/train/y_train.txt") # V1 column name

act<- read.table("./data/activity_labels.txt") # V1 == activity number, V2 == activity name
feats <- read.table("./data/features.txt")     # V1 == function number, V2 == function name
```
#Using activity names to name the activities instead of original representation :

Ytst$V1[which(Ytst$V1==1)]<- "WALKING"
Ytst$V1[which(Ytst$V1==2)]<- "WALKING_UPSTAIRS"
Ytst$V1[which(Ytst$V1==3)]<- "WALKING_DOWNSTAIRS"
Ytst$V1[which(Ytst$V1==4)]<- " SITTING"
Ytst$V1[which(Ytst$V1==5)]<- "STANDING"
Ytst$V1[which(Ytst$V1==6)]<- "LAYING"
head(Ytst)
Ytrn$V1[which(Ytrn$V1==1)]<- "WALKING"
Ytrn$V1[which(Ytrn$V1==2)]<- "WALKING_UPSTAIRS"
Ytrn$V1[which(Ytrn$V1==3)]<- "WALKING_DOWNSTAIRS"
Ytrn$V1[which(Ytrn$V1==4)]<- " SITTING"
Ytrn$V1[which(Ytrn$V1==5)]<- "STANDING"
Ytrn$V1[which(Ytrn$V1==6)]<- "LAYING"
table(Ytrn)

#Creating full data set}
Xdata<- rbind(Xtst, Xtrn)
names(Xdata)<- feats$V2
Activity<- rbind(Ytst, Ytrn)
Subject<- rbind(subjtst, subjtrn)
Data<- cbind(Xdata, Activity, Subject)
names(Data)[562]<- paste("Activity")
names(Data)[563]<- paste("Subject")

#duplicated column names:
which(duplicated(names(Data)))
length(which(duplicated(names(Data))))

#adding X, Y, Z to duplicated columnss:
for (n in 303:316) {
    colnames(Data)[n] <- paste(colnames(Data)[n], "X", sep="")
}
for (n in 317:330) {
    colnames(Data)[n] <- paste(colnames(Data)[n], "Y", sep="")
}
for (n in 331:344) {
    colnames(Data)[n] <- paste(colnames(Data)[n], "Z", sep="")
}
for (n in 382:395) {
    colnames(Data)[n] <- paste(colnames(Data)[n], "X", sep="")
}
for (n in 396:409) {
    colnames(Data)[n] <- paste(colnames(Data)[n], "Y", sep="")
}
for (n in 410:423) {
    colnames(Data)[n] <- paste(colnames(Data)[n], "Z", sep="")
}
for (n in 461:474) {
    colnames(Data)[n] <- paste(colnames(Data)[n], "X", sep="")
}
for (n in 475:488) {
    colnames(Data)[n] <- paste(colnames(Data)[n], "Y", sep="")
}
for (n in 489:502) {
    colnames(Data)[n] <- paste(colnames(Data)[n], "Z", sep="")
}

#renaming the names of the variables 
colnames(Data) <- gsub('\\(|\\)',"",names(Data), perl = TRUE)
colnames(Data) <- gsub('\\-',"",names(Data), perl = TRUE)
colnames(Data) <- gsub('\\,',"",names(Data), perl = TRUE)

#Subsetting the full Data to obtain the measurements on the mean and standard deviation for each measurement:
meancols <- grep("[Mm]ean", colnames(Data), value=TRUE)
stdcols <- grep("[Ss]td", colnames(Data), value=TRUE)
meanColNum<- grep("[Mm]ean", colnames(Data))
stdColNum<- grep("[Ss]td", colnames(Data))
subData<- Data[, c(meanColNum, stdColNum, 562, 563)]

#Obtaining the average of each variable for each subject and activity:
library(data.table)
dt<- data.table(subData)
meanData<- dt[, lapply(.SD, mean), by=c("Subject", "Activity")]
meanData<- meanData[order(meanData$Subject),]

#Exporting data to a .txt file:
write.table(meanData, "tidyData.txt", sep="\t")