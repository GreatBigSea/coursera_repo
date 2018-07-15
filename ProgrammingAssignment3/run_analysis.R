library(dplyr)

##Import the necassary data
trainset <- read.table(file="./UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainlabels <- read.table(file="./UCI HAR Dataset/train/y_train.txt", header = FALSE)
subjecttrain <- read.table(file="./UCI HAR Dataset/train/subject_train.txt", header = FALSE)
testset <- read.table(file="./UCI HAR Dataset/test/X_test.txt", header = FALSE)
testlabels <- read.table(file="./UCI HAR Dataset/test/y_test.txt", header = FALSE)
subjecttest <- read.table(file="./UCI HAR Dataset/test/subject_test.txt", header = FALSE)
names <- read.table(file="./UCI HAR Dataset/features.txt", header = FALSE)
activities <- read.table(file="./UCI HAR Dataset/activity_labels.txt", header = FALSE)

##Extract and convert the names
names <- as.character(names[,2])
activities[,2] <- as.character(activities[,2])

##Add the right column names as preparation for the merge
names(activities) <- c("label", "activity")

##Get the columns for the wanted data
featuresWanted <- grep(".*mean.*|.*std.*", names)
featuresWanted.names <- names[featuresWanted]
featuresWanted.names <- gsub('-mean', 'Mean', featuresWanted.names)
featuresWanted.names <- gsub('-std', 'Std', featuresWanted.names)
featuresWanted.names <- gsub('[-()]', '', featuresWanted.names)

##Combine the labels, the subjects and the measurements to one combined table
set <- cbind(testlabels, subjecttest, testset[featuresWanted])

##Add names
names(set) <- c("label", "subject", featuresWanted.names)

##Add the descriptives via factors
allData <- merge(set, activities, by="label")

##The tiny data set with with the average of each variable for each activity and each subject
keydates <- group_by(allData, activity, subject) %>% summarise_all(mean)


