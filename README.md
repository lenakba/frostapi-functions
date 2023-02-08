# Frost API Functions
Contains R functions for easy extraction of Vestland weather sensors from the Frost API, and for finding latitude and longitude of given sensor.
Use of these tools require a Frost API ID (Client ID) which can be obtainted at the Frost API website: https://frost.met.no/howto.html.
Please refer to this website for more information about the API, and for the API reference tables, see https://frost.met.no/api.html.

Both functions can be found in the script `functions.R`. 
The script `example.R` shows how the functions are used in practice.
Required packages are `jsonlite` and `tidyverse`.

## get_all_vestland_sensors

Function for obtaining Vestland sensor data given a Frost API ID. Requires a Frost API ID (Client ID). 
The function extracts data from /sources. Returns an object of class dataframe and class tibble. 
The dataframe includes the id, name and all other variables/features available 
from /sources including the latitude and longitude.

Argument(s):
*frost_api_id           Client ID to access the FROST api.          


!WARNING! The function extracts data at all data quality levels (0,1,2,3,4).

## get_coordinates_by_id
Function for obtaining latitude and longitude of a sensor, given sensor ID, and a dataframe of sensors. 
The dataframe of sensors can be the direct output of ´get_all_vestland_sensors´.

Argument(s):
* sensor_id            String. ID of a sensor. For instance, "SN50810" denotes the sensor at Åsane, Bergen.
* sensors_df           Dataframe or tibble. Must include the sensor id column, which must have the name "id".


## Example

Example of how to use the `get_all_vestland_sensors`
and `get_coordinates_by_id` functions. Note that this code 
# is not reproducible, as it will throw an error
if you do not replace the "my_frost_api_id" string with
a valid Frost API ID. 

```
frost_api_id = "my_frost_api_id"

# This code assumes the ´functions.R´ script is in the same location as the 
# `example.R` script, and that the source file location is in the working repo.
source("functions.R")

# Fetching Vestland sensors for your Frost API Client Id
sensors_df = get_all_vestland_sensors(frost_api_id)

# Finding the latitude and longitude for the Åsane sensor
get_coordinates_by_id("SN50810", sensors_df)
```