---
title: "README"
author: "Henry Bowers"
date: "Thursday, August 21, 2014"
output: Md file
---

This document describes the run_analysis.R script and provides a code book for the tables and table variables it manipulates.

# run_analysis.R script explanation

This script creates a tidy data set by merging and transforming raw data included in [Human Activity Recognition Using Smartphones Dataset Version 1.0.](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).

The tidy data set is exported to tidydata-hmb.txt.

The files it uses from the raw data set are activity_labels.txt, features.txt, x_train.txt, x_test.txt, y_train.txt, y_test.txt, subject_train.txt and subject_test.txt.

## Prerequisites
- libraries data.table, plyr, car
- Human Activity Recognition Using Smartphones Dataset Version 1.0, extracted to same directory as that of the run_analysis.R script.

NOTE: before running script, change setwd() on line 4 to directory containing script, or comment out the line

## Processing
The script performs the following steps:   
1. load test data  
2. load train data  
3. provide descriptive labels for subject and activity vectors  
4. consolidate train and test data into a single table  
5. provide descriptive labels for feature columns  
6. recode activity labels to be more descriptive  
7. retain only mean and std feature variables, the first 6 feature vectors of each feature category  
8. create independent tidy data set with the mean of each variable by activity and subject  
9. make mean vectors more accurately descriptive by appending "mean." to beginning of labels  
10. export tidy data set to text file  

# Code Book for run_analysis.R

The script creates several tables in sequence, creating new tables by manipulating the data in previously created tables. The names and purposes of each table are as follow:

- x_train : data table containing data from x_train.txt (feature data)
- y_train : data table containing data from y_train.txt (activity associated with feature data)
- subject_train : data table containing data from x_test.txt (subject IDs associated with feature data)
- x_test : data table containing data from x_test.txt (feature data)
- y_test : data table containing data from y_test.txt (activity associated with feature data)
- subject_test : data table containing data from x_test.txt (subject IDs associated with feature data)
- featureNames : data table containing data from features.txt (descriptive labels for feature vectors)
- trainData : data table appending subject_train, y_train and x_train by column
- testData : data table appending subject_test, y_test and x_test by column
- combinedData : data table appending trainData and testData by row
- coreData : data table that subsets combinedData to remove all features except those that measure mean and standard deviation
- featureMeans : data table containing mutated version of coreData that groups the mean of each feature by subject ID and activity
