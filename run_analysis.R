setwd("E:/Data Science/coursera/gncdata/getdata-projectfiles-UCI HAR Dataset")

##Load Activity and Feature Data
activity <- read.table("./UCI HAR Dataset./activity_labels.txt", stringsAsFactors = FALSE)
features <- read.table("./UCI HAR Dataset./features.txt")

##Load X_test set column name, Appropriately labels the data set with descriptive variable names. 
X_test <- read.table("./UCI HAR Dataset./test/X_test.txt", stringsAsFactors = FALSE)
colnames(X_test) <- as.character(features$V2)

## Load suject for Test data
subject_test <- read.table("./UCI HAR Dataset./test/subject_test.txt")
colnames(subject_test) <- c("Subject")

## Load Activity Details, Uses descriptive activity names to name the activities in the data set
y_test <- read.table("./UCI HAR Dataset./test/y_test.txt")
y_test <- merge(y_test, activity, by.x="V1")
colnames(y_test) <- c("Activity", "ActivityDesc")

## Create Test Data 
subject_activity <- cbind(subject_test, y_test)
subject_activity_data <-cbind(subject_activity, X_test)

##Load X_train and set column name, Appropriately labels the data set with descriptive variable names. 
X_train <- read.table("./UCI HAR Dataset./train/X_train.txt", stringsAsFactors=FALSE)
colnames(X_train) <- as.character(features$V2)

## Load Subject from training
subject_train <- read.table("./UCI HAR Dataset./train/subject_train.txt")
colnames(subject_train) <- c("Subject")

## Load Activity Details, Uses descriptive activity names to name the activities in the data set
y_train <- read.table("./UCI HAR Dataset./train/y_train.txt")
y_train <- merge(y_train, activity, by.x="V1")
colnames(y_train) <- c("Activity", "ActivityDesc")

## Create Training Data 
tr_subject_activity <- cbind(subject_train, y_train)
tr_subject_activity_data <- cbind(tr_subject_activity, X_train)

## Merge Test Data and Train Data to single Data Set
subject_activity_data <- rbind(subject_activity_data, tr_subject_activity_data)
subject_activity_data <- subject_activity_data[order(subject_activity_data$Subject),]

## Extracts only the measurements on the mean and standard deviation for each measurement. 
subject_activity_data <- subject_activity_data[,grep("(mean|std)\\(\\)|Subject|Activity|ActivityDesc",colnames(subject_activity_data)) ]

columnName <- read.table("./columnName.txt")
colnames(subject_activity_data)<-columnName$V1

formattedTidyDataSet <- format(subject_activity_data, digits=4, scientific=F, justify='right')

write.table(formattedTidyDataSet, file='./ProgrammingAssignment/tidyDataSet.txt',row.names=F, sep='\t', quote=F)


##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
secondtTidyDataSet <- summarise_each(group_by(subject_activity_data, Subject, ActivityDesc), funs(mean), 4:length(names(subject_activity_data)) )


formattedSecondtTidyDataSet <- format(secondtTidyDataSet, digits=4, scientific=F, justify='right')

write.table(formattedSecondtTidyDataSet, file='./ProgrammingAssignment/SecondtidyDataSet.txt',row.names=F, sep='\t', quote=F)



