##      This code does the following:

##      1. Merges the training and the test sets to create one 
##      data set.
##      2. Extracts only the measurements on the mean and standard
##      deviation for each measurement. 
##      3. Uses descriptive activity names to name the activities 
##      in the data set
##      4. Appropriately labels the data set with descriptive variable 
##      names. 
##      5. From the data set in step 4, creates a second, independent
##      tidy data set with the average of each variable for each activity
##      and each subject.

##########################################################################

##      Load the needed package
        library(reshape2)

##      1. Merges the training and the test sets to create one 
##      data set.

        ##      Step 1: Get the activity names and feature names

        activities <- read.table("./activity_labels.txt",col.names=c("activity_id","activity_name"))
        features <- read.table("./features.txt")
        feature.names <- as.character(features[,2])

        ##      Step 2: Create the Test Data dataframe and label column names
        tests <- read.table("./test/X_test.txt")
        colnames(tests) <- feature.names

        test.subjects <- read.table("./test/subject_test.txt")
        colnames(test.subjects) <- "subject.names"

        test.activities <- read.table("./test/y_test.txt")
        colnames(test.activities) <- "activity.names"

        test.data <- cbind(test.subjects , test.activities, tests)


        ##     Step 3: Create the Training Data datafram and label column names
        ##     with same column names as Test Data
        trainings <- read.table("./train/X_train.txt")
        colnames(trainings) <- feature.names

        train.subjects <- read.table("./train/subject_train.txt")
        colnames(train.subjects) <- "subject.names"

        train.activities <- read.table("./train/y_train.txt")
        colnames(train.activities) <- "activity.names"
        
        train.data <- cbind(train.subjects , train.activities, trainings)


        ##      Step 4: Combine Test and Training Data into one data frame
        myData <- rbind(test.data, train.data)

##########################################################################

##      2. Extracts only the measurements on the mean and standard
##      deviation for each measurement. 

        ##      Step 1: Filter columns referring to mean() values
        mean.cols <- grep("mean", names(myData))
        mean.cols.names <- names(myData)[mean.cols]

        ##      Step 2: Filter columns referring to std() values
        std.cols <- grep("std", names(myData))
        std.cols.names <- names(myData)[std.cols]

        ##      Step 3: Create a dataframe with the mean and std columns only
        ms.Data <- myData[, c("subject.names", "activity.names", mean.cols.names, std.cols.names)]

##########################################################################

##      3. Uses descriptive activity names to name the activities 
##      in the data set

        ms.Names <- merge(activities, ms.Data, by.x="activity_id", by.y="activity.names", all=TRUE)
        colnames(ms.Names)[1] <- "activity.ID"
        colnames(ms.Names)[2] <- "activity.names"
        

##########################################################################

##      4. Appropriately labels the data set with descriptive variable 
##      names. 

        ms.Tidy <- melt(ms.Names,id=c("activity.ID","activity.names","subject.names"))

##########################################################################

##      5. From the data set in step 4, creates a second, independent
##      tidy data set with the average of each variable for each activity
##      and each subject.

        avg.Data <- dcast(ms.Tidy,activity.ID + activity.names + subject.names ~ variable,mean)

##########################################################################

##      Submission text file
        
        write.table(avg.Data,"./tidy_data.txt", row.names=FALSE)

