## Code Book for the Getting and Cleaning Data course project

### Study design
The data used in this analysis came from a study in which 30 volunteers aged 19-48 performed a series of
activities (walking, walking upstairs and downstairs, sitting, standing and lying down) while wearing a
Samsung Galaxy S II smartphone with built in accelerometer and gyroscope. These instruments were used to
gather 3-axial (in the X, Y and Z directions) data about the subjects' acceleration and angular velocity
at a sampling frequency of 50Hz. The data from nine of the subjects were randomly selected to form the
test data set and the remaining data formed the training set.

### Pre-processing and analysis
A median filter and third order, 20Hz low pass Butterworth filter were used to remove noise from the data,
the cleaned signals were sampled in windows of 2.56s, overlapping by 50% and with 128 readings per window
and a 0.3Hz low pass Butterworth filter was used to separate the acceleration data into body and
gravitational components. Jerk signals were obtained by deriving the body component of the linear
acceleration and the angular velocity in time and the Euclidean norm was applied to find the magnitudes of
each variable. Lastly, a Fast Fourier Transform was applied to the non-gravitational variables. A variety of
statistical measures were obtained from each variable, of which only the arithmetic mean and standard
deviation were chosen for further analysis. Each feature was normalised to the interval [-1,1], removing all
units. Once the other features were removed, the arithmetic mean of each required feature for each subject
and activity was calculated and the results displayed in the final tidy data set.

### Variables
For simplicity and brevity, the original names for the selected features were retained in the final data
set. The prefix to each one denotes whether it is a non-Fourier transformed ("t" for time domain) or
Fourier transformed ("f" for frequency domain). The gravitational components to the linear acceleration
data are marked as "Gravity"; all other features are concerned with the subjects' motion and are marked
as "Body". (For unknown reasons, an extra "Body" is inserted in the names of features 516-544 - this is
not flagged up or explained in the original explanation of the variable names and may be a typo).
Accelerometer and gyroscope data are distinguished by "Acc" and "Gyro" respectively. The derived features,
jerk signals and magnitudes, are labelled "Jerk" and "Mag". The statistical measure being reported is then
added - "mean()" or "std()" (for standard deviation) as appropriate. Finally, where appropriate the axis
(X, Y or Z) along which the measurement was taken is recorded.