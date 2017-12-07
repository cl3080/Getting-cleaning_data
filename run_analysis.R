###load packages
require("data.table")
###load all informations for the training sets

activity_labels<-read.table("activity_labels.txt")
activity_labels<-activity_labels[,2]

###for the features, we only need the mean and standard deviation
features<-read.table("features.txt")
features<-features[,2]

features_needed<-grepl("mean|std",features)

###load training datasets
x_training<-read.table("~/Desktop/DS/Getting_and_cleaning_data/UCI HAR Dataset/train/X_train.txt")
y_training<-read.table("~/Desktop/DS/Getting_and_cleaning_data/UCI HAR Dataset/train/y_train.txt")

###add descriptive activity names to name the activities 
subject_train<-read.table("~/Desktop/DS/Getting_and_cleaning_data/UCI HAR Dataset/train/subject_train.txt")
names(subject_train)="subject"
names(x_training)=features
x_training_needed=x_training[,features_needed]
y_training[,2]=activity_labels[y_training[,1]]

###bind x_train.txt and y_train.txt
training<-cbind(subject_train,y_training,x_training_needed)


###repeat the steps for test dataset
x_test<-read.table("~/Desktop/DS/Getting_and_cleaning_data/UCI HAR Dataset/test/X_test.txt")
y_test<-read.table("~/Desktop/DS/Getting_and_cleaning_data/UCI HAR Dataset/test/y_test.txt")
subject_test<-read.table("~/Desktop/DS/Getting_and_cleaning_data/UCI HAR Dataset/test/subject_test.txt")
names(subject_test)="subject"
names(x_test)=features
x_test_needed=x_test[,features_needed]
y_test[,2]=activity_labels[y_test[,1]]
test<-cbind(subject_test,y_test,x_test_needed)

###merge training data and test data
mergeDT<-rbind(training,test)

###change labels for activity 
#change V1 to Activity_ID, V2 to Activity
names(mergeDT)<-gsub("V1","Activity_ID",names(mergeDT))
names(mergeDT)<-gsub("V2","Activity",names(mergeDT))

###"t" can be replaced with Time, "f" can be replaced with frequency,
###"Mag" can be replaced with magnitude,"Bodybody" can be replaced with Body,
###"Acc" can be replaced with Accelerometer, "Gyro" can be replaced with "Gyroscope"
names(mergeDT)<-gsub("^t","Time",names(mergeDT))
names(mergeDT)<-gsub("^f","Frequency",names(mergeDT))
names(mergeDT)<-gsub("^Mag","Magnitude",names(mergeDT))
names(mergeDT)<-gsub("Bodybody","Body",names(mergeDT))
names(mergeDT)<-gsub("Acc","Acceletometer",names(mergeDT))
names(mergeDT)<-gsub("Gyro","Gyroscope",names(mergeDT))
###replace "-","\\.""\\" with a space
names(mergeDT)<-gsub("-"," ",names(mergeDT))


###From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
cleandata<-aggregate(.~subject+Activity,mergeDT,mean)
cleandata<-cleandata[order(cleandata$subject,cleandata$Activity),]
write.table(cleandata,file="~/Desktop/DS/Getting_and_cleaning_data/UCI HAR Dataset/cleandata.txt", row.name=FALSE)

