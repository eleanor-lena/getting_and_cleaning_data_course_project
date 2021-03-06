library(reshape2)

fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "dataset.zip", method = "curl" )
unzip("dataset.zip")

activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activitylabels[,2])

features <- read.table("UCI HAR Dataset/features.txt")

#extract only the data on mean and standard deviation
namewanted <- grep(".*mean.*|.*std.*",features[,2])
features.names <- features[namewanted,2]
features.names <- gsub("-mean", "Mean", features.names)
features.names <- gsub("-std", "Std", features.names)
features.names <- gsub("[()-]", "", features.names)

#load the datasets
train <- read.table("UCI HAR Dataset/train/X_train.txt")[namewanted]
trainActivity <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainSubject <- read.table("UCI HAR Dataset/train/Subject_train.txt")
train <- cbind(trainSubject, trainActivity,  train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[namewanted]
testActivity <- read.table("UCI HAR Dataset/test/Y_test.txt")
testSubject <- read.table("UCI HAR Dataset/test/Subject_test.txt")
test <- cbind(testSubject, testActivity, test)

#merge train and test data
allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", features.names)

allData$activity <- factor(allData$activity, levels = activitylabels[,1], labels = activitylabels[,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id.vars = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject+activity  ~ variable, mean)

write.table(allData.mean, file = "tidy.txt", quote = FALSE, row.names = FALSE)

