library(plyr)
library(dplyr)

#------------------------------------------------------------------------------
# do some basic validations
#------------------------------------------------------------------------------

if (!file.exists("UCI HAR Dataset"))
{
  stop("Cannot find the sub-directory 'UCI HAR Dataset': cannot proceed with analysis without data.")
}

#------------------------------------------------------------------------------
# 1. Merges the training and the test sets to create one data set.
#------------------------------------------------------------------------------
# Load general data:
# - 'activity_labels.txt': Links the class labels with their activity name.
# - 'features.txt': List of all features.
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")

# Load training data:
# - 'train/X_train.txt': Training set.
# - 'train/y_train.txt': Training labels.
# - 'train/subject_train.txt': Each row identifies the subject who performed 
#             the activity for each window sample. Its range is from 1 to 30. 
trainSet <- read.table("UCI HAR Dataset/train/X_train.txt")
trainLabels <- read.table("UCI HAR Dataset/train/y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Load testing data:
# - 'test/X_test.txt': Test set.
# - 'test/y_test.txt': Test labels.
# - 'test/subject_test.txt': Each row identifies the subject who performed 
#             the activity for each window sample. Its range is from 1 to 30.
testSet <- read.table("UCI HAR Dataset/test/X_test.txt")
testLabels <- read.table("UCI HAR Dataset/test/y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Join data together
dataSet <- rbind.fill(trainSet, testSet)
dataLabels <- rbind.fill(trainLabels, testLabels)
dataSubject <- rbind.fill(trainSubject, testSubject)


# Clean up the objects that aren't needed anymore to free up memory
rm(trainSet)
rm(trainLabels)
rm(trainSubject)

rm(testSet)
rm(testLabels)
rm(testSubject)


#------------------------------------------------------------------------------
# 2. Extracts only the measurements on the mean and standard deviation for each
#    measurement.
#       mean(): Mean value
#       std(): Standard deviation
#------------------------------------------------------------------------------
# Gather the mean and standard deviation measurements
meanFeatures <- features[grep("mean", features$V2),]
stdFeatures <- features[grep("std", features$V2),]

# Put all desired measurements together & order them
MeanAndStdFeatures <- rbind.fill(meanFeatures, stdFeatures)
MeanAndStdFeatures <- MeanAndStdFeatures[ order(MeanAndStdFeatures[1]), ]

# Create a new column that represents the old column name that will exist in the dataSet
#MeanAndStdFeatures <- mutate(MeanAndStdFeatures, OldColNames = paste("V", as.character(V1), sep = '')) 

# Clean up the objects that aren't needed anymore to free up memory
rm(meanFeatures)
rm(stdFeatures)


#------------------------------------------------------------------------------
# 3. Uses descriptive activity names to name the activities in the data set
#------------------------------------------------------------------------------
dataLabels2 <- join(dataLabels, activityLabels, by="V1", type="left", match="all")
names(dataLabels2) <- c("dataLabels", "activityLabels")


#------------------------------------------------------------------------------
# 4. Appropriately labels the data set with descriptive variable names. 
#------------------------------------------------------------------------------
names(dataSet) <- features$V2


# rename the column containing the data Subject information 
names(dataSubject) <- "dataSubject"
# add a transformed column to have the data Subject as a factor variable
dataSubject$dataSubjectFactor <- factor(dataSubject$dataSubject)

# create a new mini data set & append all desired columns to it
miniDS <- cbind(dataSubject[2], dataLabels2[2], dataSet[names(dataSet) %in% MeanAndStdFeatures$V2])


#------------------------------------------------------------------------------
# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.
#------------------------------------------------------------------------------
# calculate the mean of each variable, group-by subject & activity
tidyDS <- aggregate(miniDS[,3:ncol(miniDS)], list(miniDS$dataSubjectFactor,miniDS$activityLabels), mean)

# correct the names of the group-by variable columns
names(tidyDS)[1:2] <- names(miniDS)[1:2]


# Clean up the objects that aren't needed anymore to free up memory
rm(activityLabels)
rm(features)
rm(dataLabels)
rm(dataSubject)

rm(MeanAndStdFeatures)
rm(dataLabels2)


#------------------------------------------------------------------------------
# output tidy dataset as a text file
#------------------------------------------------------------------------------
write.table(tidyDS, 
            file = "TidyDataSet.txt", 
            append = FALSE, 
            sep = "\t", 
            row.names = FALSE,
            col.names = TRUE)
