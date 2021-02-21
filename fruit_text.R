library(tidyverse)
# library(rtweet)

fruit <- read_csv("twitter/fruit.csv")
glimpse(fruit)

fruit$text

fruit1 <- fruit %>% extract(text, "fruit", "(\\b[a-z]+),")

fruit1 %>% count(fruit)

fruit1 %>% group_by(fruit) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

top10 <- fruit1 %>%
  group_by(fruit) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count)) %>% 
  slice(1:10)
top10

fruit1 %>% mutate(top10 = if_else(fruit %in% top10$fruit, fruit, "other"))

fruit1 <- fruit1 %>%
  mutate(top10 = if_else(fruit %in% top10$fruit, fruit, "other"))
glimpse(fruit1)

fruit1 %>% ggplot(aes(x = date, y = fav, color = top10)) +
  geom_point()

library(ggthemes)
fruit1 %>% ggplot(aes(x = date, y = fav, color = top10)) +
  geom_point(show.legend = FALSE, alpha = 0.5) +
  ggtitle("Popular fruits") +
  theme_wsj()
# ggsave("fruit_favs.png")



# fruit1 <- fruit %>% extract(text,
#                             c("fruit_name", "artist", "year"),
#                             "(^.+,) painted by (.+,) (\\d{4})",
#                             remove = FALSE)
# 
# glimpse(fruit1)
# 
# fruit1$year
# 
# fruit1 %>% filter(str_detect(fruit1$artist, "\\d"))
# fruit1 %>% filter(is.na(year)) %>% select(text)
# 
# fruit1$fruit_name
# 
# fruit1 %>% extract(fruit_name, "fruit",
#                    "[^\\s](.+),")
# 
# str_split(fruit1$fruit_name, " ")
# 
# str_count(fruit1$fruit_name, boundary("word"))
# 
# fruit1 %>% filter(is.na(str_count(fruit1$fruit_name, boundary("word")))) %>% 
#   select(text, fruit_name)
# 
# fruit2 <- fruit %>% extract(text,
#                             c("fruit_name"),
#                             "(^.+,){1}",
#                             remove = FALSE)
# glimpse(fruit2)                            
# 
# s <- fruit$text[1]
# s
# 
# s %>% str_extract("\\w,")
# ?str_extract
# s %>% str_subset("\\w,")
# s %>% str_extract("\\b[a-z]+,")
