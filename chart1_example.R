spl_df <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)
x_values <- seq(1, 3)
y_values <- seq(1, 3)

# compare line graph of physical copies over the month of each year
library(ggplot2)
library(dplyr)
library(scales)

c1_df <- spl_df %>%
  filter(MaterialType %in% c("BOOK", "EBOOK", "AUDIOBOOK")) %>%
  group_by(CheckoutMonth, MaterialType) %>%
  summarise(avg_checkout = mean(Checkouts))

ggplot(c1_df) +
  geom_line(aes(x = CheckoutMonth, y = avg_checkout, color = MaterialType)) +
  labs(title = "Average Checkouts between Books, Ebooks, and Audiobooks", 
       caption = "Data Provided by the Seattle Public Library, from 2017 to 2023", 
       x = "month", 
       y = "average checkouts") +
  scale_x_continuous(breaks = seq(1, 12, 1))
