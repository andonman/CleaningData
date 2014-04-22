Data
====
This repository includes:
a .R file (R script) named on run_Analysis.R 

This script gets it's data from data folder that should be placed
inside user's home directory

For example my working home directory is Desktop:
> getwd()
[1] "C:/Users/admin/Desktop"


The R script (run_Analysis.R) encompasses the codes for:
reading different pieces of data into R,
combining these pieces to obtain the full large Data (data dimension: 10299*563),
Adding descriptive names for each activity,
fixing unusual features of variable names,
calculating the average value of each variable for each subject and each activity and creat new independent data set (data dimension: 180*88),
export the data into a txt file named on "tidyData".


The Guide for interpreting each variable
========================================

t (at the beginning of the variable names): time domain signals
f (at the beginning of the variable names): frequency domain signals
mean: Mean value
std: Standard deviation
meanFreq: Weighted average of the frequency components to obtain a mean frequency
angle: Angle between to vectors
X, Y, Z: the axis of X, Y and Z (signals can be in the X, Y and Z directions)
Acc: Acceleration signal from the smartphone accelerometer (sensor signal).
Gyr: Angular velocity from the smartphone gyroscope (sensor signal).
Body: The signals related to the body of subject (individual) who has been examined.
Jerk: Jerk signals (the body linear acceleration and angular velocity were derived in time to reach this signal)
Mag: magnitude of the three-dimensional signals calculated using the Euclidean norm
Gravity: The signals related to the gravity.
Subject: The numbers between 1 to 30 which are identifiers of the subjects (individuals) who carried out the experiment.
Activity: including 6 activities performed by subjects (STANDING, SITTING, LAYING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS)
