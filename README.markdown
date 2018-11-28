## Introduction

This repository contains the files and descriptions required for the
Assignment: Getting and Cleaning Data, which is part of the Coursera Course
Data Science Specialization

## How to use

- Clone this repository:

	git clone https://github.com/agent18/coursera-getting-and-cleaning-data.git
	
- Download and extract the zip link below to the same folder as the
  clone
  
  link: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  
- Running run_analysis.R in RStudsio/R does the following:

    > 1. Merges the training and the test sets to create one data set.
    > 2. Extracts only the measurements on the mean and standard deviation for each measurement.
    > 3. Uses descriptive activity names to name the activities in the data set
    > 4. Appropriately labels the data set with descriptive variable names.
    > 5. From the data set in step 4, creates a second, independent tidy
    >    data set with the average of each variable for each activity and
    >    each subject.
	
	> --- From the assignment

- As part of STEP 5, the data set obtained is Melted (made long) to
make it tidier based on discussion in
[http://vita.had.co.nz/papers/tidy-data.pdf](http://vita.had.co.nz/papers/tidy-data.pdf). The dataset is called
`traintest.melt`. It looks like the following:

```R
  Subject           Activity AverageVariable     Value
1       1             LAYING   tBodyAccMeanX 0.2215982
2       1            SITTING   tBodyAccMeanX 0.2612376
3       1           STANDING   tBodyAccMeanX 0.2789176
4       1            WALKING   tBodyAccMeanX 0.2773308
5       1 WALKING_DOWNSTAIRS   tBodyAccMeanX 0.2891883
6       1   WALKING_UPSTAIRS   tBodyAccMeanX 0.2554617
```


## File list
- run_analysis.R : The file that does the analysis and provides the
  tidy long data set `traintest.melt`.
  
  
- README.markdown: The file that contains the readme of this
  repository
- CodeBook.md :  It is a code book that describes the variables, the
  data, and any transformations or work that was performed to clean up
  the data. 
- traintest-tidy.txt : File that contains text data of the tidy
  dataset written by using the following command,
  
		write.table(traintest.melt,"./traintest-tidy.txt",row.names=FALSE)
  
**Note: The data is not provided here as the files are very large, it
must be downloaded from the link in the above section**

## Appendix Info about the DATA:

> One of the most exciting areas in all of data science right now is
> wearable computing - see for example this article . Companies like
> Fitbit, Nike, and Jawbone Up are racing to develop the most advanced
> algorithms to attract new users. The data linked to from the course
> website represent data collected from the accelerometers from the
> Samsung Galaxy S smartphone. A full description is available at the
> site where the data was obtained:
>
> http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
>
> Here are the data for the project:
>
> https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

> --- From the assignment

The data contains a README.txt which explains how the data is
obtained. But for the sake of clarity the CODEBOOK tries to be
complete by including it as well.
