# CodeBook for Analysis

<br/>

## Original Feature Selection provided with Data  
#### (reference: Text in this section was taken verbatim from the 'features_info.txt' file that comes with the dataset)  

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.  


Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).  


Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).  


These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.  

tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are:  

mean(): Mean value  
std(): Standard deviation  
mad(): Median absolute deviation   
max(): Largest value in array  
min(): Smallest value in array  
sma(): Signal magnitude area  
energy(): Energy measure. Sum of the squares divided by the number of values.  
iqr(): Interquartile range   
entropy(): Signal entropy  
arCoeff(): Autorregresion coefficients with Burg order equal to 4  
correlation(): correlation coefficient between two signals  
maxInds(): index of the frequency component with largest magnitude  
meanFreq(): Weighted average of the frequency components to obtain a mean frequency  
skewness(): skewness of the frequency domain signal  
kurtosis(): kurtosis of the frequency domain signal  
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.  
angle(): Angle between to vectors.  

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:  

gravityMean  
tBodyAccMean  
tBodyAccJerkMean  
tBodyGyroMean  
tBodyGyroJerkMean  

The complete list of variables of each feature vector is available in 'features.txt'  
  
<br/>
  
## Data  

The data used for this analysis represents data collected from the accelerometers of the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project was obtained from: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The README.txt provided with this dataset explains the experiments done to produce this dataset. 

<br/>

## Transformations Done & Summaries Calculated

The following transformations were done to the original dataset in the process of creating the tidy dataset:  

- The training and test datasets were concatenated together using 'rbind'. All concatenations put the training set first and test set second in the argument list. Three sets of files underwent this procedure: X_train.txt / X_test.txt, y_train.txt / y_test.txt, & subject_train.txt / subject_test.txt.  

- When determining which of the original features to keep, a simple grep command was used to find all features that had either 'mean' or 'std' in their names (as they are given in the 'features.txt' file). This resulted in a total of 79 out of 561 numeric features being kept in the final dataset.  

- All numeric features' names were kept as-is from the 'features.txt' file, so that the columns choosen could be compared directly with the raw data as given. No (potential) typos, or spelling errors were corrected for. Due to the highly technical nature of the data and my limited understanding of what each variable represents, more meaningful names were not choosen. 

- The descriptive activity names were taken from the list given in the 'activity_labels.txt' file, and they were not manipulated in anyway. The column containing these values was named "activityLabels", and this column was bound to the concetenated dataset using 'cbind'.  

- The subject identifiers were transformed into factors, and then this transformed column (labeled "dataSubjectFactor") was concetenated to the dataset using 'cbind'.  


When the analysis code completes, 3 datasets are left loaded in the environment (all other interim objects are removed as part of the analysis code execution):  

* 'dataSet' : the dataset that resulted from concatenating X_train.txt and X_test.txt, with columns renamed based on the 'features.txt' file. The original number of observations has not been changed. Nor has the original number of variables been changed.

* 'miniDS' : the smaller dataset that contains the limited number of columns we want - dataSubjectFactor, activityLabels, and 79 numeric features that are either mean or standard deviation calculations. The original number of observations has not been changed.  

* 'tidyDS' : the final "tidy" dataset that contains the same number of columns as 'miniDS', but each numeric column now contains the average of that variable, grouped by activity and subject. The calculations done leave a total of 180 observations (30 subjects * 6 activities = 180 grouped observations). This is the dataset that is written out to file ('TidyDataSet.txt') at the very end of the analysis code.  

<br/>
