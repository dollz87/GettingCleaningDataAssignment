# The Codebook

### Data Collection
Data was collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data for the project was downloaded from here: 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

### Getting started
The run_analysis.R script requires usage of the reshape2 package and any dependent packages it requires

### 1. Merging the data
The first step requires accessing the required files and labeling the dataframes appropriately.

Activity names and feature names were obtained by accessing the *activity_labels.txt* and *features.txt* files. This results in **activities* and **feature.names** variable.

Data frames were created for the training and testing data sets.

For Testing, we used *X_test.txt, subject_test.txt, y_test.txt*. Using the feature names obtained above, the column names were labeled using **feature.names**.
This was repeated for Training names with *X_train.txt, subject_train.txt and y_train.txt*

Test and Training Data were combined into one data frame using the *rbind* function. This results in a variable called **myData**.

### 2. Extract only the mean and standard deviation data 

Using *grep* filter ou tthe mean and std deviation data column names.

Then create a single data frame by filtering out the columns. This results in a variable called **ms.Data**.

### 3. Use descriptive activity names to name the activities

From the **activities* variable, **ms.Data** has the activity descriptive names merged using the *merge* function. This results in **ms.Names**.

### 4. Create a tidy data set with appropriately labeled data set with descriptive variable names.

A tidy data set is created using the *melt* function and grouping observations with **activity.ID, activity.names, subject.names*. This results in a tidy data frame called **ms.Tidy**.

###  5. Create a second, independent tidy data set with the average of each variable for each activity and each subject.

Using the *dcast* function, a new data set is created that has the averages called **avg.Data**.
