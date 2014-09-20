# Analysis of the 'Human Activity Recognition Using Smartphones' Dataset   
<br/>  
  
## Data
  
The data used for this analysis represents data collected from the accelerometers of the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project was obtained from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The README.txt provided with this dataset explains the experiments done to produce this dataset. The zip file named above includes the following files:

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

The raw data used to create the feature set is also included in the zip file (under the sub-folders 'train/Inertial Signals' & 'test/Inertial Signals'). This raw data was ignored for this analysis task.

<br/>  
   
## Analysis Overview  

The analysis performed here was done as part of the course requirements of 'Getting and Cleaning Data' (https://class.coursera.org/getdata-007), a course offered via Coursera.

The purpose of this project is to demonstrate my ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 

The following files exist in this Github repository to fulfill this requirement:

- 'README.md' : this file which explains how all of the scripts work and how they are connected.

- 'CodeBook.md' : a code book that describes the variables, the data, and any transformations or work that was performed to clean up the data.  

- 'run_analysis.R': an R script for performing the analysis. The output of which is a text file ('TidyDataSet.txt') which contains the resultant tidy dataset of the analysis.  

- 'TidyDataSet.txt': sample output of the analysis code.  

<br/>  
   
## Analysis  

In order to replicate the analysis and it's results, the following assumptions have been made:  

- You have a recent version of R installed (minimum version 3.1.0)  
- You have the following packages installed: plyr, dplyr.  
- The working directory contains the analysis code ('run_analysis.R') from this repository + the data folder ('UCI HAR Dataset') which results from downloading and unzipping the data file named above (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). Do not modify the folder hierarchy within this data folder.  


The diagram below is a visual depiction of how all the data files provided in the zip file relate to one another. The dataset has no ID numbers, so the implicit order of rows is used to piece the data together.  
    ![alt text](HowTheDataFilesFitTogether.png "How The Data Files Fit Together")  
This diagram was taken from the following site:  
    https://class.coursera.org/getdata-007/forum/thread?thread_id=49   
  
  
The analysis is run by executing the code from an R console within the working directory. For example:  
  ```R  
  source('~/MyWorkingDirectory/run_analysis.R')  
  ```  
  
  
The analysis code provided does the following:  

- It reads in all the data files named in the 'Data' section above.  
- Merges the training and test sets into a single dataset.  
- Extracts the features that are related to the mean and standard deviation for each measurement. The original data contains 561 features with time and frequency domain variables, 79 of these are either mean or standard deviation related features.  
- Gives descriptive activity names to the activities in the data set. There are a total of six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING).  
- Gives descriptive variable names to all the columns of the data set. The descriptive names are taken as-is from the features.txt file provided with the dataset. 
- Creates a tidy dataset with the average of each variable, for each activity and each subject.  
- Writes the tidy dataset to a file named 'TidyDataSet.txt' in the working directory.  
  
  
The tidy dataset that results from this analysis will have 180 observations (30 subjects * 6 activities = 180 grouped observations) & 81 variables (subject identifier + activity label + 79 features related to mean and standard deviation).
  
  
Characteristics of the output file ('TidyDataSet.txt') include:  

- It does *not* include row names  
- It does include column names  
- The column separator is a tab  


The output file is created using the write.table command. To view the output in R, the following commands can be used (these should be executed in the working directory which contains the generated 'TidyDataSet.txt' file, otherwise you will have to put the full file-path name into the command):       
  ```R  
  testoutput <- read.table("TidyDataSet.txt", header = TRUE)  
  View(testoutput)  
  ```  
A sample of the output file ('TidyDataSet.txt') is provided in this repository with the R analysis code, in case you don't want to run the analysis yourself to generate the file.  
  
<br/>   
