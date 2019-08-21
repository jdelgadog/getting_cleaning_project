library(dplyr)

setwd("C:/Course")

filename<-"datosProyecto.zip"

# Data to be processed
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, filename, method="curl")

#Unzip file
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Data to be used
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#1. Merges the training and the test sets to create one data set.
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
all_Data <- cbind(subject, x, y)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
tidyData <- all_Data %>% select(subject, code, contains("mean"), contains("std"))

#3. Uses descriptive activity names to name the activities in the data set
tidyData$code <- activities[tidyData$code, 2]

#4. Appropriately labels the data set with descriptive variable names.
names(tidyData)[2] = "activity"
names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData), ignore.case = FALSE)
names(tidyData)<-gsub("^t", "Time", names(tidyData), ignore.case = FALSE)
names(tidyData)<-gsub("^f", "Frequency", names(tidyData), ignore.case = FALSE)
names(tidyData)<-gsub("-std()", "STD", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("angle", "Angle", names(tidyData))
names(tidyData)<-gsub("tBody", "TimeBody", names(tidyData), ignore.case = FALSE)
names(tidyData)<-gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))
names(tidyData)<-gsub("Acc", "Accelerometer", names(tidyData), ignore.case = FALSE)
names(tidyData)<-gsub("Gyro", "Gyroscope", names(tidyData), ignore.case = FALSE)

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
dataProc <- tidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
