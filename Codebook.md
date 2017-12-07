# Code Book for R script
This file describes the variables, the data, and any transformations or work I perfomed to clean up the raw data.

* here is the link where I downloaded the raw data
 https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* The run_analysis.R perfoms the following steps to get and clean the raw data.
1. Read X_train.txt, y_train.txt and subject_train.txt and store them in x_training, y_training, and subject_train.
2. Add features to the x_training as column name.
3. Extracts only the measurements on the mean and standard deviation for each measurment and store them in x_training_needed.
4. Combine x_training_needed and y_training and store the data in training
5. Repeat these steps for test data set.
6. Merge the training data and test data.
7. Appropriately labels the data set with descriptive variable names.
8. From the clean set in step 7, creates a second tidy data set with the average of each variable for each activity and each subject. The data set is stored in cleandata.


