
#loading the data
path = "/Users/deanebuckingham/Documents/DS745 - Data Viz & More/Text Mining Project/drugLib_raw/drugLibTrain_raw.csv"
standard_data <- read.csv(file=path, header=TRUE, stringsAsFactors=FALSE)

#exploring the data
nrow(standard_data) #3107 rows
unique(standard_data["effectiveness"]) #5 levels
unique(standard_data["sideEffects"]) #5 levels
table(standard_data[,3]) #shows we mostly have positive-reviewed drugs in the dataset
## 1   2   3   4   5   6   7   8   9  10 
## 305 103 146 107 159 157 350 558 480 742
plot(table(standard_data[,3]), xlab="rating", ylab="count")

library(tidyverse)
library(tidytext)

#creating a tibble where each row is a word
second_tidy_df <- tibble(line=1:nrow(standard_data),standard_data[,"commentsReview"])
second_tidy_df <- second_tidy_df %>% unnest_tokens(word, standard_data[,"commentsReview"]) 

#removing stop words
data(stop_words)
second_tidy_df <- second_tidy_df %>% anti_join(stop_words)

#sentiment analysis
my_second_sentiment <- second_tidy_df %>%
  inner_join(get_sentiments("afinn")) %>%  # using the afinn lexicon
  group_by(index=line) %>%
  summarise(sentiment = sum(score))

#Merging my sentiment results with my original dataframe
df_joined <- data.frame(index = seq(max(nrow(standard_data))))
df_joined <- cbind(df_joined, standard_data[,1:3]) 
df_joined <- merge(df_joined, my_second_sentiment, all.x = TRUE)
df_joined[is.na(df_joined)] <- 0
df_view <- df_joined[order(df_joined$rating),]

#plotting and viewing results
plot(table(df_view["sentiment"]), xlab="sentiment scores", ylab="frequency")

plot(df_view[,5] ~ df_view[,4], xlab="Original Rating", ylab="Calculated Sentiment")



