## README for Getting and Cleaning Data course project

### Documents
This repo contains the R script for analysis of a data set from an experiment regarding wearable computing
(specifically the Samsung Galaxy S II smartphone) as detailed in the code book, which is also included in
this repo.

### Accessing and running the data and script
The data for this analysis are available as a zip file at
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip - the R script
assumes that the zip file is in the current working directory. The script itself should run at least
in R 3.1.2. No packages were required to run the script.

### Details of analysis
It being assumed that the zip file is already in the user's working directory, the file is extracted and
the two data sets read in along with the activity labels and subject IDs, which are appended to the data
sets. The column names are also read in and assigned to the data sets so that they can be bound together
and sorted by ID and activity. A new data frame is created with only the means and standard deviations
and relabelled with the original column names. The numerical activity labels are replaced by the appropriate
descriptions. Finally, the combined data set is split by subject and activity and the mean of each feature
calculated and recorded in the final tidy data set.