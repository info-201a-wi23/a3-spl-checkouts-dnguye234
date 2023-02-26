x_values <- seq(1, 3)
y_values <- seq(1, 3)

spl_df <- read.csv("~/Desktop/2017-2023-10-Checkouts-SPL-Data.csv", stringsAsFactors = FALSE)

library(ggplot2)

c2_df <- spl_df %>%
  filter(Creator %in% c("Murata, Sayaka, 1979-", "Sayaka Murata")) %>%
  group_by(CheckoutMonth, Title) %>%
  summarise(total_checkout = sum(Checkouts))

c2_clean_1 <- c2_df %>%
  filter(Title %in% c("Convenience Store Woman", "Convenience Store Woman (unabridged)", "Convenience Store Woman (Unabridged)", "Convenience store woman / Sayaka Murata ; translated from the Japanese by Ginny Tapley Takemori.", "Convenience Store Woman: A Novel")) %>% 
  summarise(total_checkout = sum(total_checkout)) %>%
  mutate(Title = "Convenience Store Woman")

c2_clean_2 <- c2_df %>%
  filter(Title %in% c("Earthlings : a novel / Sayaka Murata ; translated from the Japanese by Ginny Tapley Takemori.", "Earthlings: A Novel", "Earthlings: A Novel (unabridged)", "Earthlings: A Novel (unabridged) (Unabridged)")) %>% 
  summarise(total_checkout = sum(total_checkout)) %>%
  mutate(Title = "Earthlings: A Novel")

c2_clean_3 <- c2_df %>%
  filter(Title %in% c("Life ceremony : stories / Sayaka Murata ; translated from the Japanese by Ginny Tapley Takemori.", "Life Ceremony: Stories", "Life Ceremony: Stories (unabridged)")) %>% 
  summarise(total_checkout = sum(total_checkout)) %>%
  mutate(Title = "Life Ceremony: Stories")

c2_df_join <- rbind(c2_clean_1, c2_clean_2, c2_clean_3)

ggplot(c2_df_join) +
  geom_line(aes(x = CheckoutMonth, y = total_checkout, color = Title)) +
  labs(title = "Total Checkouts Of Works by Sayaka Murata", 
       caption = "Data Provided by the Seattle Public Library, from 2017 to 2023", 
       x = "month", 
       y = "total checkouts") +
  scale_x_continuous(breaks = seq(1, 12, 1))
