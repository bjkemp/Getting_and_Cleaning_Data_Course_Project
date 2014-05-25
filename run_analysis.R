## This script loads and merges the UCI HAR testing and training datasets.
## Then returns an average of the dataset's mean and standard deviation values
## by test subject and activity.

## Codebook:
## features - a data.table which holds the column names for the sensor datasets.
## x_test, x_train - two data.tables which hold the sensor data.
## x - the combination of the x_test and x_train data.tables 
## x_meanAndStd - x with just the mean and std columns
## activities - a data.table which holds the activity names and activityIDs
## y_test, y_train - two data.tables which hold the activityID for each recording.
## y - the combination of the y_test and y_train data.tables.
## subject_test, subject_train - two data.tables which hold the subjects per observation.
## subjects - the combination of subject_test and subject_train
## data - the combination of subjects, y, and x_meanAndStd
## result - the aggregation of the mean data by subjectID and activity


## Load the column names for the sensor datasets.
features = read.table('features.txt', sep=' ', col.names=c('id', 'name'))

## Load, merge, and give column names to the sensor data.
x_test = read.table('X_test.txt', sep='')
x_train = read.table('X_train.txt', sep='')

x = rbind(x_test, x_train)
colnames(x) = features$name

## Reduce the dataset to only contain standard deviation
## and mean columns.
x_meanAndStd = x[sort(c(grep('std\\(\\)', features$name), 
	grep('mean\\(\\)', features$name))),]

## Load the names of the activities and their ID.
activities = read.table('activity_labels.txt', sep=' ', 
	col.names=c('activityID','activity'))

## Load the activity columns and merge them together.
y_test = read.table('y_test.txt', sep='')
y_train = read.table('y_train.txt', sep='')

y = rbind(y_test, y_train)
colnames(y) = c('activityID')

## Add the names of the activities using activityID.
y = merge(y, activities, by='activityID')


## Load the subject column, merge the test and training data,
## and rename the column.
subject_test = read.table('subject_test.txt', sep='')
subject_train = read.table('subject_train.txt', sep='')

subjects = rbind(subject_test, subject_train)
colnames(subjects) = c('subjectID')


## Combine all of the data together...
data = cbind(subjects, y, x_meanAndStd)

## ...then aggregate the mean of the sensor readings by subject and activity...
result = aggregate.data.frame(data, list(data$subjectID, data$activity), mean)[, c(-3, -5)]

## ...rename the first two columns...
colnames(result)[1:2] = c('subjectID', 'activity')

## ...and output the result in a tab delimited file.
write.table(result, 'result.txt', sep='\t')

