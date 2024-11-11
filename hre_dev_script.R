library(tidyverse)
library(gt)

# Upload save to https://pdx.tools/
# Go to World Charts > Provinces > Download data as csv
df <- read_csv("C:/Users/Tom/Downloads/session2.csv")

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

vassals <- tribble(
  ~overlord, ~vassal,
  "RIG", "TEU",
  "RIG", "LIV"
)

df |>
  left_join(vassals, join_by(ownerTag == vassal)) |>
  mutate(
    ownerTag = coalesce(overlord, ownerTag),
    development = ifelse(is.na(overlord), development, development / 2)
  ) |>
  filter(ownerTag %in% tags, inHre) |>
  summarise(total_hre_dev = sum(development), .by = ownerTag) |>
  arrange(desc(total_hre_dev)) |>
  rename("Country" = ownerTag, "Total HRE Dev" = total_hre_dev) |>
  gt()
