
Description of script run_analysis.R
1. Datasets used
    The data is assumed to be in "~/Documents/coursera/UCI HAR Dataset" folder
   
   a.  The files train/X_train.txt and test/X_test.txt contain the feature values for each of the observations. 
    b. The files train/Y_train.txt and test/Y_train.txt contain the activity value for each observation found in the X_*.txt files. 
    c. The file features.txt contain the names of the features measured.
    d. The file activity_labels.txt contains the description of the category variable for activity. 

2. To run the script, source the script "run_analysis.R" and they type "run_analysis.R"
3. The script merges the X_* and Y_* datasets, assigns column names from features.txt. Further, the activity description for each observation is attached using the information in activity_labels.txt. Finally, data is re-ordered for each activity and each subject and a tidy data is output to a text file.  
The script writes the tidy data in a text file called "~/Documents/coursera/tidydata"
# Courseproject
