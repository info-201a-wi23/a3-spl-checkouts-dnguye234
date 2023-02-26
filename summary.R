spl_df <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

library(dplyr)

# What is the average number of checkouts for each item?
average_df <- spl_df %>%
  group_by(Title) %>%
  summarise(avg = mean(Checkouts)) %>%
  print()

# What is the month or year with the most/least checkouts for a book that you're interested in?
# Item of interest = Berserk : deluxe edition. 1 / by Kentaro Miura ; translation, Jason DeAngelis with Duane Johnson ; lettering and retouch, Dan Nakrosis with Studio Cutie.
monthly_df <- spl_df %>% 
  filter(Title == "Berserk : deluxe edition. 1 / by Kentaro Miura ; translation, Jason DeAngelis with Duane Johnson ; lettering and retouch, Dan Nakrosis with Studio Cutie.") %>%
  group_by(CheckoutMonth) %>%
  summarise(Checkouts) 

max_checkout <- monthly_df %>%
  filter(Checkouts == max(Checkouts)) %>%
  pull(CheckoutMonth)

min_checkout <- monthly_df %>%
  filter(Checkouts == min(Checkouts)) %>%
  pull(CheckoutMonth)
  
# What is the month or year with the most/least checkouts for ebooks?
ebook_df <- spl_df %>%
  filter(MaterialType == "EBOOK") %>%
  group_by(CheckoutYear) %>%
  summarise(avg = mean(Checkouts))

max_ebook <- ebook_df %>%
  filter(avg == max(avg)) %>%
  pull(CheckoutYear)

min_ebook <- ebook_df %>%
  filter(avg == min(avg)) %>%
  pull(CheckoutYear)

# How has the number of print book checkouts changed over time?
book_df <- spl_df %>%
  filter(MaterialType == "BOOK") %>%
  group_by(CheckoutYear) %>%
  summarise(Checkouts = sum(Checkouts)) %>%
  pull()