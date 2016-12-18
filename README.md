# getting_and_cleaning_data_course_project

The R script, run_analysis.R, does the following:

1. Download the dataset.
2. Load the activity and feature info.
3. Load both the train and test datasets, keep those columns which reflect a mean or a standard deviation.
4. Load the activity and subject data for each dataset
5. merge columns of activity, subject, and the data.
6. merge the two datasets.
7. Creates a tidy dataset that include the mean value of each variable for each subject and activity pair.
8. Output the result to file tidy.txt.
