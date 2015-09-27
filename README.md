# Getting and Cleaning Data course project Codebook

##Experimental Design and Background
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##Raw Data
For each record it is provided:
- id
- Activity
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Measurement features are normalized and bounded within [-1,1].

##Processed Data
The training data, ids, activities were merged into a training dataset and the testing data, ids, and activities were merged into a testing dataset.  The prefix of train or test (depending on the dataset) were added to each id to distinguish from training and testing.  The training and testing datasets were then merged together.  A new dataset was then created that only contained the activity (numerical category), id, and only means and standard deviations (std) of the measurements.  Activity was then coded from numerical to the descriptive names.  Column names we made more descriptive and readable by changing the following:
"Acc" to "acceleration_"
"Body" to "body_"
"Gravity" to "gravity_"
"Freq" to "frequency_"
"X" to "x_direction"
"Y" to "y_direction"
"Z" to "z_direction"
"Gyro" to "gyroscope_"
"Mag" to "magnitude_"
"Jerk" to "jerk_"
"t" to "time_"
"f" to "frequency_"
"mean" to "mean_"

Lastly, a tidy dataset was created by taking the mean of each variable for each activity and subject.
