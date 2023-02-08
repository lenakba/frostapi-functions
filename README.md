# Frost API Functions
Contains R functions for easy extraction of Vestland weather sensors from the Frost API, and for finding latitude and longitude of given sensor.
For more information on the Frost API, please refer to https://frost.met.no/howto.html and the api reference at https://frost.met.no/api.html

Both functions can be found in the script ´functions.R´. 
Required packages are ´jsonlite´ and ´tidyverse´.

## get_all_vestland_sensors

Function for obtaining Vestland sensor data given a Frost API ID. Requires a Frost API ID (Client ID). 
The function extracts data from /sources. Returns an object of class dataframe and class tibble. 
The dataframe includes the id, name and all other variables/features available 
from /sources including the latitude and longitude.

!WARNING! The function extracts data at all data quality levels (0,1,2,3,4)

## get_coordinates_by_id
Function for obtaining latitude and longitude of a sensor, given sensor ID, and a dataframe of sensors. 
The dataframe of sensors can be the direct output of ´get_all_vestland_sensors´