##Getting & Cleaning Data
##Wearable computing data assignment

#Download data and unzip
if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,"./data/wearables.zip")
setwd("./data")
unzip("wearables.zip")

#Read in observation datasets
setwd("UCI HAR Dataset/")
xtest <- read.table("./test/X_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
ytest <- read.table("./test/y_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
xtrain <- read.table("./train/X_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
ytrain <- read.table("./train/y_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

#Read in subject id datasets
subjTest <- read.table("./test/subject_test.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)
subjTrain <- read.table("./train/subject_train.txt", quote="\"", comment.char="", stringsAsFactors=FALSE)

#Merge datasets
labeledTest <- cbind(ytest,xtest)
labeledTrain <- cbind(ytrain,xtrain)
subjectTest <- cbind (subjTest,labeledTest)
subjectTrain <- cbind (subjTrain,labeledTrain)
allCases <- rbind(subjectTest,subjectTrain)

#Calculate mean and SD for each measurement
standardDeviations <- sapply(allCases[,3:563], FUN = sd) #don't take SD and mean
means <- sapply(allCases[,3:563], FUN = mean)            #of categorical variables

#Replace activity labels
labels <- read.table("activity_labels.txt")
allCases[,2] <- sapply(allCases[,2], function(x){   #replaces each label with its  
  labels$V2[match(x, labels$V1)]                    #equivalent in activity labels table
})

#Clean and replace variable names
require(data.table)
features <- read.table("features.txt")
features <- gsub("\\(\\)","", features$V2) #removes parentheses at end
features <- gsub(",","_",features) #replaces commas
features <- gsub("\\)","",features)
features <- gsub("\\(","_",features)
allFeatures <- append(c("subject","label"),features) #don't forget feature label
DT <- data.table(allCases) #data tables better than dplyr
colnames(DT) <- allFeatures

#Create a tidy data set with average of each variable
#for each activity and each subject.
meansSubjectActivity <- DT[, lapply(.SD, mean), 
                           by=list(subject,label)] #data table is awesome!
write.table(meansSubjectActivity, "meansSubjectActivity.csv", row.name=FALSE)