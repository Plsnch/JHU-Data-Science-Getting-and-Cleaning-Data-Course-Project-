Getting and Cleaning Data Course Project
========================================

Project tasks
-------------

1.  Get raw data from the accelerometers from the Samsung Galaxy S
    smartphone
2.  Merge data on several samples
3.  Transform data into tidy format
4.  Make a summarized database on each variable’s average by subjects
    and activity type

Code info
---------

There are several tricks I’ve used to make the performance better and
the code itself more readable. Referencing **run\_analysis.R** this are:
1. Features are automaticly filtered, as only means and sd’s are to be
present in final datasets. In order to to so a vector is created in
*features* dataframe that specifies features in *line 18*. Features
marked with *NULL* will be omitted by *read.table* while reading, which
speeds up the process significatly. 2. Only selected features are used
to name raw data as in *line 25* and *line 37* 3. Activity labels are
automatically matched with activivity codes from train in test data as
in *line 30* and *line 42* 4. A summarized tidy data on averages by
subject and activities are created with using dplyr workflow.
*group\_by* in *line 51* specifies variables that are used to perform
summarization by, while *summarize\_all* just takes average of all other
variables.

Project reporting
-----------------

-   Summarized data
-   Github repo with:
    -   script named run\_analysis.R that performs all of the operations
        from raw data to a tidy dataset
    -   text file README.md that describes the code used
    -   text file code\_book.md that describes the data
