# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Uploading packages
library(dplyr)

# Downloading data
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- getwd()
download.file(url, file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# Uploading universal info for both train and set - features and activity labels
features <- read.table(paste0(path,"/UCI HAR Dataset/features.txt")) %>% 
  mutate(V3=ifelse(grepl("mean",V2)|grepl("std",V2),NA,"NULL"))

activities <- read.table(paste0(path,"/UCI HAR Dataset/activity_labels.txt"))

# Getting train data
raw_train <- read.table(paste0(path,"/UCI HAR Dataset/train/X_train.txt"),
                        colClasses=features$V3)
names(raw_train) <- features$V2[is.na(features$V3)]

subjects_train <- read.table(paste0(path,"/UCI HAR Dataset/train/subject_train.txt"))

labs_train <- read.table(paste0(path,"/UCI HAR Dataset/train/y_train.txt")) %>% 
  inner_join(activities)

data_train <- cbind(subject=subjects_train$V1,activity_label=labs_train$V2,raw_train)

# Getting test data
raw_test <- read.table(paste0(path,"/UCI HAR Dataset/test/X_test.txt"),
                        colClasses=features$V3)
names(raw_test) <- features$V2[is.na(features$V3)]

subjects_test <- read.table(paste0(path,"/UCI HAR Dataset/test/subject_test.txt"))

labs_test <- read.table(paste0(path,"/UCI HAR Dataset/test/y_test.txt")) %>% 
  inner_join(activities)

data_test <- cbind(subject=subjects_test$V1,activity_label=labs_test$V2,raw_test)

## Making a complete data
data_complete <- rbind(data_train,data_test)

## Making a summarized average data on every variable by subject and activity type
data_average <- data_complete %>% 
  group_by(subject,activity_label) %>% 
  summarise_all(funs(mean(.,narm=T))) %>% 
  ungroup()

## Writing summarized data
write.table(data_average,file=paste0(path,"/data_average.txt"),row.names=F)