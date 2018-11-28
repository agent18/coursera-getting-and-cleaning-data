## Introduction 

The data in
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
(referred to as ZIPDATA), is studied and presented as per the
assignement given to ultimately come be a tidy dataset
`traintest-tidy.txt`.

The data looks as follows:

```R
  Subject           Activity AverageVariable     Value
1       1             LAYING   tBodyAccMeanX 0.2215982
2       1            SITTING   tBodyAccMeanX 0.2612376
3       1           STANDING   tBodyAccMeanX 0.2789176
4       1            WALKING   tBodyAccMeanX 0.2773308
5       1 WALKING_DOWNSTAIRS   tBodyAccMeanX 0.2891883
6       1   WALKING_UPSTAIRS   tBodyAccMeanX 0.2554617
```

- There are 4 variables, Subject, Activity, AverageVariable and Value

## Meaning of Variables

- Subject: There are 30 subjects used in this experiment. This is
  denoted by `1-30`.
  
- Activity: There are six activities that each subject performs for
  which some data is recorded. They
  are: LAYING, SITTING, STANDING, WALKING, WALKING\_DOWNSTAIRS and
  WALKING\_UPSTAIRS.
  
- AverageVariable: Several parameters are extracted from the recorded
  data. What the parameters mean is dealt with in the following sub-section  
  
- Value: The value of the AverageVariable denoted. The value ranges
  from [-1,1] as they are normamized.
  
## AverageValue

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





The complete list of variables of each feature vector is available in 'features.txt'


## Analysis

