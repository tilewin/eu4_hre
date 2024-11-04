library(tidyverse)
library(gt)

# Upload save to https://pdx.tools/
# Go to World Charts > Provinces > Download data as csv
df <- read_csv("C:/Users/Tom/Downloads/session1.csv")

tags <- c(
  "CRI",
  "BRI",
  "ZAZ",
  "BYZ",
  "PRO",
  "RIG",
  "LON",
  "SER",
  "SLO",
  "SIC",
  "GOT",
  "GRA",
  "FLA"
)

df |>
  filter(ownerTag %in% tags, inHre) |>
  summarise(total_hre_dev = sum(development), .by = ownerTag) |>
  arrange(desc(total_hre_dev)) |>
  rename("Country" = ownerTag, "Total HRE Dev" = total_hre_dev) |>
  gt()
