## Getting and Cleaning Data Course Project

* Data obtained from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* Explination of data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

* This script requires that all files be extracted from the zipped dataset and present in the current working directory.
* The variables used for the tidy dataset were chosen because they either had std() or mean() in the name.

## Codebook:
* features - a data.table which holds the column names for the sensor datasets.
* x_test, x_train - two data.tables which hold the sensor data.
* x - the combination of the x_test and x_train data.tables 
* x_meanAndStd - x with just the mean and std columns
* activities - a data.table which holds the activity names and activityIDs
* y_test, y_train - two data.tables which hold the activityID for each recording.
* y - the combination of the y_test and y_train data.tables.
* subject_test, subject_train - two data.tables which hold the subjects per observation.
* subjects - the combination of subject_test and subject_train
* data - the combination of subjects, y, and x_meanAndStd
* result - the aggregation of the mean data by subjectID and activity