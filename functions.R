# Script to load functions get_all_vestland_sensors()
# and get_coordnates_by_id()
# needed for obtaining Vestland-sensors, and
# finding the latitude, longitude coords of any sensor

library(jsonlite) # reading JSON files
library(tidyverse) # datawrangling

# Function for obtaining Vestland sensor data given a FROST api ID
# Requires a FROST api ID (Client ID). 
# This can be obtained here: https://frost.met.no/howto.html
# The function extracts data from /sources 
# Returns an object of class dataframe and class tibble. 
# The dataframe includes the id, name and all other variables/features available 
# from /sources including the latitude and longitude. 
# Argument(s):
# frost_api_id           Client ID to access the FROST api.          
get_all_vestland_sensors = function(frost_api_id){

  # extract data from source
  endpoint = paste0("https://", frost_api_id, "@frost.met.no/sources/v0.jsonld")
  county = "Vestland"
  url = paste0(
    endpoint, "?",
    "county=", county)
# Issue an HTTP GET request and extract JSON data
l_vestland = try(fromJSON(URLencode(url),flatten=T)) 
if(!is.list(l_vestland)) 
  stop("No connection to API. Check whether the FROST api ID is valid.")

d_vestland = l_vestland$data %>% as_tibble()
d_vestland
}

d_sensors = get_all_vestland_sensors("6e375444-e7e7-47b4-bc4b-56bf18fbeab8")

# Function for obtaining latitude and longitude of a sensor
# given sensor ID, and a dataframe of sensors.
# Returns a 1X2 vector with latitude, longitude
# sensor_id             # String. ID of a sensor. For instance, "SN50810" denotes the sensor at Åsane, Bergen.
# sensors_df            # Dataframe or tibble. Must include the sensor id column, which must have the name "id"
get_coordinates_by_id = function(sensor_id, sensors_df){
  stopifnot(is.data.frame(sensors_df))
  if(!"id" %in% names(sensors_df))
    stop("There are no column names in the given sensor data with the name 'id'.")
  if(!sensor_id %in% sensors_df$id) 
    stop("Sensor ID not found in data. Either sensor ID is invalid, or data is missing this sensor.")

  # find coordinates
  coords_df = sensors_df %>% filter(id == sensor_id) %>% select(geometry.coordinates)
  coords_l = coords_df$geometry.coordinates 
  
  # return vector of two elements
  element_number = length(coords_l)
  if(element_number > 1) 
    stop("The sensor data has one or more duplicates for the given sensor id.")
  coords_v = coords_l %>% pluck(element_number)
  coords_v
}
