# Codebook

The code is divided into 3 main sections:

* Functions
* Constants
* Main

## Functions

These subroutines are writtent to avoid code repetitions.

### fileJoin

Used to build filepaths, it concatentates string using a slash as separator

### downloadToDataDir

Downloads the given url to the given destination paths.
It creates `data` directory if it doesn't exist.

### extractUciHarFile

Extacts the zipped file.

## Constants

Fixed values like `data directory`,`URL`, `Zip File`.

## Main

This section is further divided into following:
* Download zip file if not available
* Build Train and Test datasets
* Merging of the datasets
* Build a long list of dataset using `melt()`
* Reshape the dataset and summarize the melted dataset using `dcast()` using the expression:
	`Subject + Activity ~ variable` mean result
* Transforms the column Activity into a factor to apply activity labels in the final dataset
* Writing of the resulting dataset to persistent storage

