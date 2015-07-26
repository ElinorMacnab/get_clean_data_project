# extract zip file if not done manually
unzip("getdata-projectfiles-UCI HAR dataset.zip")

# read in test and training datasets separately
training <- read.table("./UCI HAR Dataset/train/X_train.txt") # slow
test <- read.table("./UCI HAR Dataset/test/X_test.txt")

# read in activity labels for each dataset and convert to vectors
trainingLabels <- as.vector(read.table("./UCI HAR Dataset/train/y_train.txt")[,1])
testLabels <- as.vector(read.table("./UCI HAR Dataset/test/y_test.txt")[,1])

# bind labels (as factors) to data
trainingLabelled <- cbind(as.factor(trainingLabels), training)
testLabelled <- cbind(as.factor(testLabels), test)

# read in subject IDs and convert to vectors
trainingIDs<-as.vector(read.table("./UCI HAR Dataset/train/subject_train.txt")[,1])
testIDs <- as.vector(read.table("./UCI HAR Dataset/test/subject_test.txt")[,1])

# bind IDs (as factors) to data
trainingSubj <- cbind(as.factor(trainingIDs), trainingLabelled)
testSubj <- cbind(as.factor(testIDs), testLabelled)

# read in original column names and convert to a vector
features <- read.table("./UCI HAR Dataset/features.txt")
colNamesVector <- as.vector(features[,2])

# assign provisional column names (to aid binding data frames)
names(trainingSubj) <- c("Subject.ID", "Activity", colNamesVector)
names(testSubj) <- c("Subject.ID", "Activity", colNamesVector)

# bind data sets together
boundData <- rbind(trainingSubj, testSubj)

# sort by ID and activity
sortedData <- boundData[order(boundData$Subject.ID, boundData$Activity),]

# create integer and logical vectors of columns and names to keep
keepIntMeans <- grep("mean()", colNamesVector, fixed=T)
keepIntStds <- grep("std()", colNamesVector, fixed=T)
keepColsInt <- c(1, 2, keepIntMeans+2, keepIntStds+2)
keepNamesInt <- c(keepIntMeans, keepIntStds)
keepColsLogic <- 1:ncol(sortedData) %in% keepColsInt
keepNamesLogic <- 1:length(colNamesVector) %in% keepNamesInt

# create new array containing only desired columns and a vector containing their
# names
trimmedDataArr <- array(dim = c(nrow(sortedData), length(keepInt)))
trimmedColNames <- vector(mode = "character", length = length(keepInt)-2)
countCol <- 1
countName <- 1
for(i in 1:length(keepLogic)){
  if(keepColsLogic[i]){
    trimmedDataArr[,countCol] <- sortedData[,i]
    countCol <- countCol+1
  }
  if(keepNamesLogic[i]){
    trimmedColNames[countName] <- colNamesVector[i]
    countName <- countName+1
  }
}

# convert to data frame and add labels again
trimmedData <- as.data.frame(trimmedDataArr)

# replace activity labels and convert to factor
activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
activities <- as.character(activityLabels[,2])
for(i in 1:nrow(activityLabels)){
  trimmedData[trimmedData$V2 == i, 2] <- activities[i]
}
trimmedData[,2] <- as.factor(trimmedData[,2])

# rename columns
newColNames <- c("Subject.ID", "Activity", trimmedColNames)
names(trimmedData) <- newColNames

# take means within each subject and activity
finalDataArr <- array(dim=c(180,ncol(trimmedData)))
n <- ncol(finalDataArr)
count <- 1
subjectIDs <- vector(mode="integer")
for(i in 1:30){
  subjectIDs <- c(subjectIDs, rep(i,6))
}
finalDataArr[,1] <- subjectIDs
finalDataArr[,2] <- rep(activities, 30)
for(i in 1:30){
  for(j in 1:6){
    subframe<-subset(trimmedData,Subject.ID==i&Activity==activities[j])[,3:n]
    means <- colMeans(subframe)
    finalDataArr[count,3:n] <- means
    count <- count + 1
  }
}

# convert to data frame and add names
finalData <- as.data.frame(finalDataArr)
names(finalData) <- newColNames