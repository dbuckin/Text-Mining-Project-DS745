The purpose of this project was to see if the sentiment analysis on patient reviews corresponds with a given drug’s rating.

I took the “commentsReview” column and created a tibble from it where each row is one word. Then I removed stop words.
I used the “afinn” lexicon since it already scores the sentiment of words on a 10-point scale. Then I summed up the sentiment score of each word within each review. Some reviews did not contain emotionally significant terms; their values had “0” imputed.

The ratings over all the drugs were generally positive. However the results of my sentiment analysis followed a completely different pattern.  The vast majority of sentiment scores were neutral. The non-zero scores were mostly negative. I concluded that the sentiment scores I calculated were inconclusive regarding patients’ overall rating of their drugs. 
