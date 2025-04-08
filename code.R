library(tidyverse)
library(rjson)
library(UpSetR)

# converting the JSON data to a data frame
ad_data <- fromJSON(file = "advertisers_using_your_activity_or_information.json")

ad_data <- ad_data[[1]]
ad_data <- do.call(rbind, lapply(ad_data, function(data_list) {
  data.frame(t(unlist(data_list)), stringsAsFactors = FALSE)
}))

# changing column names for better readability 

colnames(ad_data) <- c("company",
                       "has_personal_info",
                       "interacted_with_before",
                       "visited_store")

# converting columns to Boolean type 

ad_data <- mutate(
  ad_data,
  has_personal_info = as.logical(has_personal_info),
  interacted_with_before = as.logical(interacted_with_before),
  visited_store = as.logical(visited_store)
)


