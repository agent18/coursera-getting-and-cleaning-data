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

	> 0. Extracts the data from the respective folder
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
[http://vita.had.co.nz/papers/tidy-data.pdf](http://vita.had.co.nz/papers/tidy-data.pdf). The Data set is
further split into columns to make sure there is only one variable in
one column. The dataset is called
`traintest.melt`. It looks like the following:

```R
  Subject           Activity     Value Domain     VariableType  Jerk MeanOrSTD
1       1             LAYING 0.2215982   Time BodyAccelaration FALSE      Mean
2       1            SITTING 0.2612376   Time BodyAccelaration FALSE      Mean
3       1           STANDING 0.2789176   Time BodyAccelaration FALSE      Mean
4       1            WALKING 0.2773308   Time BodyAccelaration FALSE      Mean
5       1 WALKING_DOWNSTAIRS 0.2891883   Time BodyAccelaration FALSE      Mean
6       1   WALKING_UPSTAIRS 0.2554617   Time BodyAccelaration FALSE      Mean
  Direction AngleA AngleB
1         X   <NA>   <NA>
2         X   <NA>   <NA>
3         X   <NA>   <NA>
4         X   <NA>   <NA>
5         X   <NA>   <NA>
6         X   <NA>   <NA>
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
- AverageVariable.txt: File containing the unique parameters of the
tidy `traintest.melt$AverageValue`

**Note: The data in the zip is not provided here as the files are very
large, it must be downloaded from the link in the above section**

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
