## Introduction 

**Note:** The Codebook thus describes the variables, the data and any
transformations or work that has been perfromed to clean up the data
as per the assignment specifications.

The data in
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
(referred to as ZIPDATA), is studied and presented as per the
assignement given to ultimately come be a tidy dataset
`traintest-tidy.txt`.

The data looks as follows:

```R
      Subject         Activity       Value    Domain        VariableType  Jerk
11404      11          WALKING -0.49855464 Frequency            BodyGyro FALSE
1378       20          WALKING -0.34444391      Time GravityAccelaration FALSE
12351      19         STANDING -0.96425911 Frequency    BodyAccelaration FALSE
4662       27 WALKING_UPSTAIRS -0.05092352      Time            BodyGyro  TRUE
15380      14          SITTING  0.08921496     Angle                <NA> FALSE
4885        5           LAYING -0.98342226      Time            BodyGyro  TRUE
              MeanOrSTD Direction AngleA      AngleB
11404 StandardDeviation         Z   <NA>        <NA>
1378               Mean         Y   <NA>        <NA>
12351 StandardDeviation       Mag   <NA>        <NA>
4662               Mean         Y   <NA>        <NA>
15380              <NA>      <NA>      Z GravityMean
4885  StandardDeviation         X   <NA>        <NA>
```

- There are 9 variables, Subject, Activity, AverageVariable and
  Value. This data set is tidy as it has one variable in one column.

## Meaning of Variables

- Subject: There are 30 subjects used in this experiment. This is
  denoted by `1-30`.
  
- Activity: There are six activities that each subject performs for
  which some data is recorded. They
  are: LAYING, SITTING, STANDING, WALKING, WALKING\_DOWNSTAIRS and
  WALKING\_UPSTAIRS.
  
- AverageVariable: Several parameters are extracted from the recorded
  data. What the parameters mean is dealt with in the following sub-section  
  
- Value: The value of the `AverageVariable` denoted for a given
  `Subject` and given `Activity`. The value ranges
  from [-1,1] as they are normalized. As a result they have no units.
  
## AverageVariable

### Signals used to obtain the parameters in AverageValue

**Note:** The file `features_info.txt` present in the ZIPDATA is
modified to maintain the holistic picture of the data in
`traintest-tidy.txt`. The changes are shown in *"italic"*

The features selected for this database come from the accelerometer
and gyroscope 3-axial raw signals tAcc-XYZ* (for example, tAccX, tAccY,
tAccZ)* and tGyro-XYZ. These time domain signals (prefix 't' to denote
time) were captured at a constant rate of 50 Hz. Then they were
filtered using a median filter and a 3rd order low pass Butterworth
filter with a corner frequency of 20 Hz to remove noise. Similarly,
the acceleration signal was then separated into body and gravity
acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another
low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were
derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and
tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional
signals were calculated using the Euclidean norm (tBodyAccMag,
tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these
signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ,
fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to
indicate frequency domain signals).

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

From the above we get 81 parameters with `Mean` (Mean value)
 and `STD` (Standard deviation).
 
**For example:**  `tBodyAcc-XYZ` becomes the following 6 variables

``` R
 [1] tBodyAccMeanX                          
 [2] tBodyAccMeanY                          
 [3] tBodyAccMeanZ                          
 [4] tBodyAccSTDX                           
 [5] tBodyAccSTDY                           
 [6] tBodyAccSTDZ 
```
`fBodyGyroJerkMag` becomes the following 2 variables

``` R
[77] fBodyBodyGyroJerkMagMean               
[78] fBodyBodyGyroJerkMagSTD    
```
Additional vectors are obtained by averaging the signals in a signal
window sample. These are used to get the `angle` between two
vectors. The following 7 parameters result:

``` R
[80] AngleBettBodyAccMeanAndGravity         
[81] AngleBettBodyAccJerkMeanAndGravityMean 
[82] AngleBettBodyGyroMeanAndGravityMean    
[83] AngleBettBodyGyroJerkMeanAndGravityMean
[84] AngleBetXAndGravityMean                
[85] AngleBetYAndGravityMean                
[86] AngleBetZAndGravityMean 
```
The complete list of variables of each feature vector is available in 'AverageVariable.txt'


## Explanation of the cleaning of the code.

The code `run-analysis.R` contains the code with explanation of the
transformations done. The transformations done can be split into 5
steps as per the assignment.

0. Extracted the data from the respective folder

	Extracted the data from train and test folders and make them into
`train` and `test` dataset respectively. Extracted headers separately
and then adds to the above datasets.

1. Merged the training and the test sets to create one data set.

	rbind is used to merge `train` and `test`, to form `traintest`.


2. Extracted only the measurements on the mean and standard deviation
   for each measurement.
   
   Using `grep` the locations of the mean and std measurements are
   located and the `traintest` is updated accordingly.
   
3. Used descriptive activity names to name the activities in the data
   set
   
   Activity names are made descriptive. Example: `1` becomes `WALKING`
   
4. Appropriately labeled the data set with descriptive variable names.

	The goal here is to clean up the colnames with descriptive easily
    accessible names. So that is done using gsub to have uniform names
    with capitalization where expected and no hyphens and brackets in
    confusing places. Look at `run_analysis.R` for more info.
	
5. From the data set in step 4, created a second, independent tidy
    data set with the average of each variable for each activity and
    each subject.

	Here the dataset is made long and tidy (as per the advice of
    http://vita.had.co.nz/papers/tidy-data.pdf), by melting the
    dataset in step 4, except for `Subject` and `Activity`.
	
	

