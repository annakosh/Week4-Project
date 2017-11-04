# Week4-Project

The code run_analysis.R uses the data from the Human Activity Recognition Using Smartphones Project.
The code does the following:
 -- reads in and merges the test and train data sets, as well as subject IDs, and activity indicators data sets
 -- extracts the measurements of the mean() and std() for each measurement
 -- replaces activities' indicators with the text labels
 -- renames the variables in the main data set, so that the variables' names are more readable
 -- creates a new data set with average for each variable for each activity and each subject in the main data set
 -- tidies up this data set, so that each column contains only one variable, as described in Hadley Wickham's "Tidy data" paper

 For tidying up, I created some new variables, according to my understanding of the Human Activity Recognition Using Smartphones Project documentation:
-- "domain": time or frequency           
-- "signal": body or gravity           
-- "device": accelerometer or gyroscope
-- "jerk_signal": logical indicator for jerk signal
-- "signal_magnitude": logical indicator for signal magnitude 
-- "axis": X, Y, or Z axis

The codebook describes the variables in more detail. 

I decided against creating a variable "statistic", taking values of "mean" and "std". Instead, I kept variables "average.of.mean" and "average.of.std".
I thought it would be more informative. 
As it was said in both "Tidy data" paper, and David Hood's blog article on tidý data, there is more than one way of tidying a data set, and it depends on the aims of the analysis. I tried to stick to the 5 principles of the tidy data, stated by Mr. Wickham. 

