## Problem 01
## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

setwd("C:/Users/Win10/Desktop/2nd Mini Project/specdata")

library("data.table")
library("reshape2")

#0. collecting data from UCI HAR Dataset, test, and train.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
# Load: activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# Load: data column names
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# Load and process X_test & y_test data.
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features

# Load activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Load and process X_train & y_train data.
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features

# Load activity data
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Bind data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

#1. Merges the training and the test sets to create one data set.
data = rbind(test_data, train_data)

#2. Extracts only the measurements on the mean and standard deviation for each measurement.
extract_features <- grepl("mean|std", features)
x_data <- rbind(X_test, X_train)
x_data <- x_data[,extract_features]
extracted_data <- cbind(data[,1:3], x_data)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
id_labels <- c("subject", "Activity_ID", "Activity_Label")
data_labels <- setdiff(colnames(extracted_data), id_labels)
melt_data <- melt(extracted_data, id = id_labels, measure.vars = data_labels)

tidy_data <- dcast(melt_data, subject + Activity_Label ~ variable, mean)