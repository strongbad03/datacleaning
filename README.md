# JHU Getting & Cleaning Data
The "run.analysis.R" summaries the UCI wearables dataset available [here](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and described [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The script downloads the data and unpacks into a 'data' directory. The following operations are then performed on the data:
    * Testing, training, and subject datasets are read from text files.
	* The training and the test sets are merged with rbind() and cbind() to create one data set.
    * The means and standard deviations for each measurement are created. 
    * Activity labels (1,2,3...) are replaced with their human-legible equivalents (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS...).
	* Fields are renamed according to UCI naming conventions for each measurement (tBodyAcc-mean-X), with some characters removed using gsub().
    * A tidy data set is created and exported ('meansSubjectActivity.csv'). Each row contains the average of each of the 561 variables (e.g., tBodyAcc-mean-X)  grouped by each 'activity' (there are six types) and each 'subject' (there are 30 subjects), for a total of 180 records. For example, rows 1-6 show the mean of each variable's measurements for subject #2 and for each of the six activities. For more details on the variables measured, the reader is referred to [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
	
The script can be run in any R IDE or installation, though it requires the 'data.table' packages. An install.packages command on line 40 automatically installs the data.table package; this can be commented out if desired.