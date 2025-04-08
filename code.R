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

# creating a summary data frame for the ggplot
summary_data_personal_info <- ad_data %>%
  group_by(has_personal_info) %>%
  summarize(count = n(), .groups = "drop") %>%
  complete(has_personal_info = c(TRUE, FALSE), fill = list(count = 0)) %>%
  mutate(
    Percentage = count / sum(count) * 100,
    fraction = count / sum(count),
    ymax = cumsum(fraction),
    ymin = c(0, head(ymax, n = -1)),
    midpoint = (ymin + ymax) / 2
  )

# total count where companies have access to personal info
count_access <- summary_data_personal_info$count[summary_data_personal_info$has_personal_info == TRUE]
count_no_access <- summary_data_personal_info$count[summary_data_personal_info$has_personal_info == FALSE]




