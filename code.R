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

# total count
total_count <- sum(summary_data_personal_info$count)

# first graph: number of companies with access to info vs no access

p1 <- ggplot(
  summary_data_personal_info,
  aes(
    ymax = ymax,
    ymin = ymin,
    xmax = 4,
    xmin = 3,
    fill = has_personal_info
  )
) +
  geom_rect() +
  coord_polar(theta = "y") +
  xlim(c(1, 4)) +
  theme_void() +
  labs(
    title = paste0(
      "Advertisers with access to your personal information (Total: ",
      total_count,
      ")"
    ),
    fill = "Category"
  ) +
  theme(plot.title = element_text(hjust = 0, color = "#4B0082")) +  # Deep indigo/purple
  scale_fill_manual(
    values = c("FALSE" = "#377EB8", "TRUE" = "#E41A1C"),
    labels = c(
      paste0("No access: ", count_no_access),
      paste0("Access to information: ", count_access)
    )
  )

# saving the plot to be used for creating the dashboard
ggsave(
  "plot_personal_info.png",
  plot = p1,
  width = 6,
  height = 4
)

# creating a summary data frame for the ggplot (for companies interacted with before)
summary_data_interaction <- ad_data %>%
  group_by(interacted_with_before) %>%
  summarize(count = n(), .groups = "drop") %>%
  complete(interacted_with_before = c(TRUE, FALSE), fill = list(count = 0)) %>%
  mutate(
    Percentage = count / sum(count) * 100,
    fraction = count / sum(count),
    ymax = cumsum(fraction),
    ymin = c(0, head(ymax, n = -1)),
    midpoint = (ymin + ymax) / 2
  )

# Extract counts for the legend
count_interacted <- summary_data_interaction$count[summary_data_interaction$interacted_with_before == TRUE]
count_not_interacted <- summary_data_interaction$count[summary_data_interaction$interacted_with_before == FALSE]

# Calculate total count
total_count_interaction <- sum(summary_data_interaction$count)

# second graph: number of companies interacted with before vs not interacted
p2 <- ggplot(
  summary_data_interaction,
  aes(
    ymax = ymax,
    ymin = ymin,
    xmax = 4,
    xmin = 3,
    fill = interacted_with_before
  )
) +
  geom_rect() +
  coord_polar(theta = "y") +
  xlim(c(1, 4)) +
  theme_void() +
  labs(
    title = paste0(
      "Advertisers you've interacted with before (Total: ",
      total_count_interaction,
      ")"
    ),
    fill = "Category"
  ) +
  theme(plot.title = element_text(hjust = 0, color = "#4B0082")) + # Same deep indigo/purple as other plot
  scale_fill_manual(
    values = c("FALSE" = "#E41A1C", "TRUE" = "#377EB8"),
    labels = c(
      paste0("Not interacted: ", count_not_interacted),
      paste0("Interacted: ", count_interacted)
    )
  )

# saving the plot to be used for creating the dashboard
ggsave(
  "plot_interaction.png",
  plot = p2,
  width = 6,
  height = 4
)

# creating a summary data frame for the ggplot (for companies user visited in-person)
summary_data_visited <- ad_data %>%
  group_by(visited_store) %>%
  summarize(count = n(), .groups = "drop") %>%
  complete(visited_store = c(TRUE, FALSE), fill = list(count = 0)) %>%
  mutate(
    Percentage = count / sum(count) * 100,
    fraction = count / sum(count),
    ymax = cumsum(fraction),
    ymin = c(0, head(ymax, n = -1)),
    midpoint = (ymin + ymax) / 2
  )

# Extract counts for the legend
count_visited <- summary_data_visited$count[summary_data_visited$visited_store == TRUE]
count_not_visited <- summary_data_visited$count[summary_data_visited$visited_store == FALSE]

# Calculate total count
total_count_visited <- sum(summary_data_visited$count)

# third graph: number of companies user visited in-person
p3 <- ggplot(summary_data_visited,
             aes(
               ymax = ymax,
               ymin = ymin,
               xmax = 4,
               xmin = 3,
               fill = visited_store
             )) +
  geom_rect() +
  coord_polar(theta = "y") +
  xlim(c(1, 4)) +
  theme_void() +
  labs(
    title = paste0(
      "Advertisers whose physical store you've visited (Total: ",
      total_count_visited,
      ")"
    ),
    fill = "Category"
  ) +
  theme(plot.title = element_text(hjust = 0, color = "#4B0082")) +
  scale_fill_manual(
    values = c("TRUE" = "#377EB8", "FALSE" = "#E41A1C"),
    labels = c(
      paste0("Not visited: ", count_not_visited),
      paste0("Visited: ", count_visited)
    )
  )















