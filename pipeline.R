# Libraries
library(ggraph)
library(igraph)
library(tidyverse)
library(readxl)

# Read data from Excel file
excel_file <- "physical-spatial_ Edge Bundling.xlsx"
data <- read_excel(excel_file, sheet = "Sheet1", col_names = TRUE)

# Create a hierarchical structure
hierarchy <- data.frame(from = colnames(data), to = colnames(data))

# Create a dataframe with connection between leaves (individuals)
all_leaves <- colnames(data)
connect <- data.frame(
  from = sample(all_leaves, length(all_leaves), replace = TRUE),
  to = sample(all_leaves, length(all_leaves), replace = TRUE)
)

# Create a graph object
mygraph <- graph_from_data_frame(hierarchy)

# Create a vertices data.frame
vertices <- data.frame(
  name = unique(c(as.character(hierarchy$from), as.character(hierarchy$to))),
  value = runif(length(unique(c(hierarchy$from, hierarchy$to))))
)

# Add a column with the group of each name
vertices$group <- hierarchy$from[match(vertices$name, hierarchy$to)]


mygraph <- graph_from_data_frame( hierarchy, vertices=vertices )


