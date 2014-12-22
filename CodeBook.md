**This Code Book explains the variables and the transformations performed on them**

**Variables**

Subject:
*Represented by numbers of which there are 30 meaning the total participants in this test*

activity:
*transformed from numerical label to the complete character label of which there are six* :
-WALKING
-WALKING_UPSTAIRS
-WALKING_DOWNSTAIRS
-SITTING
-STANDING
-LAYING

features:
*Operations performed on the raw data(sensor records) which count to 561 of which 79 constituting means and standard deviations(std) were subseted for analysis, such as features for following records* :
-tBodyAcc-XYZ
-tGravityAcc-XYZ
-tBodyAccJerk-XYZ
-tBodyGyro-XYZ
-tBodyGyroJerk-XYZ
-tBodyAccMag
-tGravityAccMag
-tBodyAccJerkMag
-tBodyGyroMag
-tBodyGyroJerkMag
-fBodyAcc-XYZ
-fBodyAccJerk-XYZ
-fBodyGyro-XYZ
-fBodyAccMag
-fBodyAccJerkMag
-fBodyGyroMag
-fBodyGyroJerkMag

Notes:
 The test and train data sets were each induvidually cleaned and merged with related labels and subjects into a data.frame and finally the test and train data sets were merged together and run an analysis on it to obtain the means for each feature categorized by subject-activity pairs
