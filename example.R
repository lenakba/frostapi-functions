# Example of how to use the get_all_vestland_sensors() 
# and get_coordinates_by_id() functions
# Note that this code is not reproducible, as it will throw an error
# if you do not replace the "my_frost_api_id" string with
# a valid Frost API ID. 
frost_api_id = "my_frost_api_id"

# This code assumes the ´functions.R´ script is in the same location as the 
# ´example.R´ script, and that the source file location is in the working repo.
source("functions.R")

# Fetching Vestland sensors for your Frost API Client Id
sensors_df = get_all_vestland_sensors(frost_api_id)

# Finding the latitude and longitude for the Åsane sensor
get_coordinates_by_id("SN50810", sensors_df)