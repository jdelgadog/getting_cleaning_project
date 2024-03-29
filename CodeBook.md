Steps used to run the run_analysis.R script:

1. Set your working directory where you download the project's dataset and where it will be allocated the R scripts.
2. Download the dataset and extract under the folder called "UCI HAR Dataset".
3. Load all the data from folder and assign to variables.
        features <- features.txt : 561 rows, 2 columns
        The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
        activities <- activity_labels.txt : 6 rows, 2 columns
        List of activities performed when the corresponding measurements were taken and its codes (labels)
        subject_test <- test/subject_test.txt : 2947 rows, 1 column
        contains test data of 9/30 volunteer test subjects being observed
        x_test <- test/X_test.txt : 2947 rows, 561 columns
        contains recorded features test data
        y_test <- test/y_test.txt : 2947 rows, 1 columns
        contains test data of activitiesícode labels
        subject_train <- test/subject_train.txt : 7352 rows, 1 column
        contains train data of 21/30 volunteer subjects being observed
        x_train <- test/X_train.txt : 7352 rows, 561 columns
        contains recorded features train data
        y_train <- test/y_train.txt : 7352 rows, 1 columns
        contains train data of activitiesícode labels

4. Merges the training and the test sets to create one data set
        x (10299 rows, 561 columns) is created by merging x_train and x_test using rbind() function
        y (10299 rows, 1 column) is created by merging y_train and y_test using rbind() function
        subject (10299 rows, 1 column) is created by merging subject_train and subject_test using rbind() function
        all_Data (10299 rows, 563 column) is created by merging subject, x and y using cbind() function

5. Extracts only the measurements on the mean and standard deviation for each measurement
        all_Data (10299 rows, 88 columns) is created by subsetting all_Data, with only columns: subject, code and the measurements on the mean and std for each measurement.

6. Uses descriptive activity names to name the activities in the data set
        Decoding the activities code from all_Data with the description inside the activities data set.

7. Appropriately labels the data set with descriptive variable names
        code column in all_Data renamed into activities (only columns will be affected).
        All Acc -> Accelerometer
        All Gyro -> Gyroscope
        All Mag -> Magnitude
        All start with character f -> Frequency
        All start with character t -> Time

8. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
        dataProc (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.