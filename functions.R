# Script to load functions get_all_vestland_sensors()
# and get_coordnates_by_id()
# needed for obtaining Vestland-sensors, and
# finding the latitude, longitude coords of any sensor

library(jsonlite) # reading JSON files
library(tidyverse) # datawrangling

# function for obtaining Vestland sensors given a FROST api ID
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
  stop("No connection to API. Check whether the FROST api ID is correct.")

d_vestland = l_vestland$data %>% as_tibble()
d_vestland
}

# function for obtaining latitude and longitude of a sensor
# given sensor ID, and a dataframe of sensors
get_coordinates_by_id = function(sensor_id, sensors_df){
  coords_df = sensors_df %>% filter(id == sensor_id) %>% select(geometry.coordinates)
  coords_v = coords_df$geometry.coordinates
  coords_v
}