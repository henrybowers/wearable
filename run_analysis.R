## Getting and Cleaning Data - Project

setwd("~/Projects/Getting-Cleaning-Data/Project/wearable")

library(data.table)
library(plyr)
library(car)

#load test data
f<-"UCI HAR Dataset/test/X_test.txt"
x_test<-read.table(f)
f<-"UCI HAR Dataset/test/y_test.txt"
y_test<-read.table(f)
f<-"UCI HAR Dataset/test/subject_test.txt"
subject_test<-read.table(f)

###load train data
f<-"UCI HAR Dataset/train/X_train.txt"
x_train<-read.table(f)
f<-"UCI HAR Dataset/train/y_train.txt"
y_train<-read.table(f)
f<-"UCI HAR Dataset/train/subject_train.txt"
subject_train<-read.table(f)

###provide descriptive labels for subject and activity vectors
names(subject_train)[1]<-"subjectID"
names(subject_test)[1]<-"subjectID"
names(y_train)[1]<-"activityLabel"
names(y_test)[1]<-"activityLabel"

###consolidate train and test data into a single table
trainData<-cbind(subject_train,y_train,x_train)
testData<-cbind(subject_test,y_test,x_test)
combinedData<-rbind(trainData,testData)

###provide descriptive labels for feature columns
f<-"UCI HAR Dataset/features.txt"
featureNames<-read.table(f,stringsAsFactors=FALSE)

for(i in 1:nrow(featureNames)) {
        names(combinedData)[i+2]<-featureNames[i,2]
}

#use descriptive labels for activities
#1 WALKING, 2 WALKING_UPSTAIRS,3 WALKING_DOWNSTAIRS, 4 SITTING,5 STANDING,6 LAYING

combinedData<-mutate(combinedData,
                   activityLabel = recode(activityLabel,"1='WALKING';2='WALKING_UPSTAIRS';3='WALKING_DOWNSTAIRS';4='SITTING';5='STANDING';6='LAYING';else='NA'")
)

combinedData$activityLabel<-as.factor(combinedData$activityLabel)

###retain only mean and std feature variables, the first 6 feature vectors of each feature category

#find indices for means and stds in feature set
v<-append(1:2,grep("mean\\(|std",featureNames[,2])+2)

#subset combined data set to only those features
coreData<-subset(combinedData[,v])

#check subset
names(coreData)

###create independent tidy data set with the average of each variable for each activity and each subject 
my_mean <- numcolwise(mean, na.rm = TRUE)
featureMeans<-ddply(coreData, .(subjectID,activityLabel), my_mean)

