rm(list=ls())
##----------- 0. Loading the required data------------------------##
##-------------------------Headers---------------------##
## Extracting headers

X.header  <-
    read.table("./UCI HAR Dataset/features.txt")

X.header <- X.header$V2; print(length(X.header))
y.header <- "Activity"
subject.header <- "Subject"

header.data <- factor(append(c(subject.header,y.header),as.character(X.header)))


##-----------------------Train dataset---------------##
### Extract data from all files from train
subject.train <-
    read.table("./UCI HAR Dataset/train/subject_train.txt")
y.train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X.train <-
    read.table("./UCI HAR Dataset/train/X_train.txt")

print(c(dim(y.train),dim(X.train),dim(subject.train)))

X.header  <-
    read.table("./UCI HAR Dataset/features.txt")

### combining the vectors
train <- cbind(subject.train,y.train,X.train)
dim(train)
sum(is.na(train))

colnames(train) <- header.data

## ---------------------Test------------------------##
## Extract data from all files from test
subject.test <-
    read.table("./UCI HAR Dataset/test/subject_test.txt")
y.test <- read.table("./UCI HAR Dataset/test/y_test.txt")
X.test <-
    read.table("./UCI HAR Dataset/test/X_test.txt")

print(c(dim(y.test),dim(X.test),dim(subject.test)))

### combining the vectors
test <- cbind(subject.test,y.test,X.test)
dim(test)
sum(is.na(test))

colnames(test) <- header.data

##------------------processing the data---------------------##

## 1. Merging train and test data
traintest <- rbind(train,test)

## 2. Extract only mean and std deviation
location <- grep("Activity|Subject|[Mm]ean|[Ss]td",colnames(traintest))
#colnames(traintest[,location]) # to check if it is the right type of columns

traintest <- traintest[,location]
dim(traintest)
length(unique(traintest)) #Check if you have any dublicate columns

## 3. Use descriptive activity names to name the activities in the
## data set
activity.names <-
    read.table("./UCI HAR Dataset/activity_labels.txt")
activity.names$V2 <- as.character(activity.names$V2)

library(plyr)
traintest$Activity <-
    mapvalues(traintest$Activity,activity.names$V1,activity.names$V2)# requires `plyr`
## 4. Appropriately label the data set with descriptive variable
## names.

## I think the goal here is to remove the random convention of the
## variables, i.e., capitals with `-` with `()`. My goal is to clear
## the clutter and keep it simple enough to understand. I think the
## names are already clear, but might creat problems when trying to do
## Data Analysis by selecting few rows

### Capitalize main letters
colnames(traintest) <- gsub("mean","Mean",colnames(traintest))
colnames(traintest) <- gsub("std","STD",colnames(traintest))

colnames(traintest) <- gsub("angle\\(","AngleBet",colnames(traintest))


colnames(traintest) <- gsub("[Gg]ravity","Gravity",colnames(traintest))

### Remove hyphens and brackets like ()
colnames(traintest) <- gsub("-","",colnames(traintest))
colnames(traintest) <- gsub("\\(\\)","",colnames(traintest))

### Remove `,` and `)`
colnames(traintest) <- gsub(",","And",colnames(traintest))
colnames(traintest) <- gsub("\\)","",colnames(traintest))
#colnames(traintest)

## 5. From the data set in step 4, creates a second, independent tidy
## data set with the average of each variable for each activity and
## each subject.

##ordering the dataset for clarity.
traintest.order <- arrange(traintest,Subject,Activity)
dim(traintest.order)
#head(traintest.order[,c("Subject","Activity")], n=50)

## Making new data set that averages the values per subject and per activity.
traintest.new <-
    aggregate(traintest.order[,3:88],by=list(traintest.order$Subject,traintest.order$Activity),
              mean)
dim(traintest.new) # 180x88: 180 because of 30 Subjects and 6
                                        # activities
                                        # traintest.new[1:100,1:3]        

# Colnames are lost in the translation so they are re-instated
colnames(traintest.new) <- colnames(traintest.order)
traintest.new <- arrange(traintest.new,Subject,Activity)

## Melting to make it tidy based on discussion in
## http://vita.had.co.nz/papers/tidy-data.pdf

library(reshape2)
traintest.melt <-
    melt(traintest.new,id=c("Subject","Activity"),measure.vars=colnames(traintest.new)[3:88])

colnames(traintest.melt)[3] <- "AverageVariable"
colnames(traintest.melt)[4] <- "Value"

## final checks
dim(traintest.melt) # Dimension due to melting should be
                                        # [86x180 = 15480, 4]

sum(is.na(traintest.melt))

## Splitting column to make **more tidy**

traintest.melt$Domain <- NA
traintest.melt$VariableType <- NA
traintest.melt$Jerk <- NA
traintest.melt$MeanOrSTD <- NA
traintest.melt$Direction <- NA
traintest.melt$AngleA <- NA
traintest.melt$AngleB <- NA

### Domain
traintest.melt$Domain[grep("^t",traintest.melt$AverageVariable)] <- "Time"
traintest.melt$Domain[grep("^f",traintest.melt$AverageVariable)] <-
    "Frequency"
traintest.melt$Domain[grep("^Angle",traintest.melt$AverageVariable)] <- "Angle"

### Type of Variable: Body Accelaration or Gravity Accelaration or
### Body Angular velocity i.e., Body Gyro
traintest.melt$VariableType[grep("^[tf](.*)BodyAcc",traintest.melt$AverageVariable)]<- "BodyAccelaration"                 
traintest.melt$VariableType[grep("^[tf](.*)GravityAcc",traintest.melt$AverageVariable)] <-"GravityAccelaration"
traintest.melt$VariableType[grep("^[tf](.*)BodyGyro",traintest.melt$AverageVariable)]<-"BodyGyro"

### Jerk Mag Mean Std

traintest.melt$Jerk <- grepl("^[tf](.*)Jerk",traintest.melt$AverageVariable)
traintest.melt$Direction[grep("^[tf](.*)Mag",traintest.melt$AverageVariable)]<-"Mag"
traintest.melt$MeanOrSTD[grep("^[tf](.*)Mean",traintest.melt$AverageVariable)]<-"Mean"
traintest.melt$MeanOrSTD[grep("^[tf](.*)STD",traintest.melt$AverageVariable)]<-"StandardDeviation"
traintest.melt$MeanOrSTD[grep("^[tf](.*)MeanFreq",traintest.melt$AverageVariable)]<-"MeanFrequency"

traintest.melt$Direction[grep("[tf](.*)X$",traintest.melt$AverageVariable)]<- "X"
traintest.melt$Direction[grep("[tf](.*)Y$",traintest.melt$AverageVariable)]<- "Y"
traintest.melt$Direction[grep("[tf](.*)Z$",traintest.melt$AverageVariable)]<- "Z"



### Fixing the angle variables

ind <-grep("^AngleBet(.*)",traintest.melt$AverageVariable)
traintest.melt$AverageVariable <- as.character(traintest.melt$AverageVariable)
jesus <- lapply(traintest.melt$AverageVariable[ind], function(x)
    strsplit(x,split="Bet")[[1]][[2]])

traintest.melt$AngleA[ind] <- sapply(jesus, function(x) strsplit(x,split="And")[[1]][[1]])
traintest.melt$AngleB[ind]<- sapply(jesus, function(x)
    strsplit(x,split="And")[[1]][[2]])

### As factor
cols <- c("Domain","VariableType","Jerk","MeanOrSTD","Direction","AngleA","AngleB")
traintest.melt[cols] <- lapply(traintest.melt[cols],factor)

### Remove AverageVariable
traintest.melt <- within(traintest.melt, rm(AverageVariable))
## write table

write.table(traintest.melt,"./traintest-tidy.txt",row.names=FALSE)

