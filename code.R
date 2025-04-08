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

