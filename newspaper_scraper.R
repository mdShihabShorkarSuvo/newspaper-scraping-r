# Install necessary packages
install.packages("rvest")
install.packages("dplyr")
install.packages("stringr")
install.packages("topicmodels")
install.packages("tidytext")



library(tidytext)

library(topicmodels)
# Load the libraries
library(rvest)
library(dplyr)
library(stringr)

# Specify the URL of the agriculture section
url <- "https://www.thedailystar.net/tags/agriculture"

# Read the HTML content from the URL
webpage <- read_html(url)

# Extract the links to the articles
article_links <- webpage %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  str_subset("/agriculture") %>%
  unique()

# Complete the URLs
# Specify the URL of the agriculture section
url <- "https://www.thedailystar.net/tags/agriculture"

# Read the HTML content from the URL
webpage <- read_html(url)

# Extract the links to the articles
article_links <- webpage %>%
  html_nodes("a") %>%
  html_attr("href") %>%
  str_subset("/agriculture") %>%
  unique()

# Print the extracted links to verify
print(article_links)

# Complete the URLs
base_url <- "https://www.thedailystar.net"
article_links <- paste0(base_url, article_links)

# Print the complete URLs to verify
print(article_links)


# Function to scrape text from an individual article
scrape_article <- function(link) {
  article_page <- read_html(link)
  article_text <- article_page %>%
    html_nodes("p") %>%  # Adjust the CSS selector based on the actual structure
    html_text() %>%
    paste(collapse = " ")
  return(article_text)
}

# Scrape all articles
articles <- sapply(article_links, scrape_article)

# Combine all articles into a single character vector
text_data <- paste(articles, collapse = " ")

# Print the combined text data to verify
print(text_data)


# Load the tm package
library(tm)

# Create a Corpus (collection of text documents)
corpus <- Corpus(VectorSource(text_data))

# Preprocess the text data
corpus <- tm_map(corpus, content_transformer(tolower)) # Convert to lowercase
corpus <- tm_map(corpus, removePunctuation) # Remove punctuation
corpus <- tm_map(corpus, removeNumbers) # Remove numbers
corpus <- tm_map(corpus, removeWords, stopwords("english")) # Remove stop words
corpus <- tm_map(corpus, stripWhitespace) # Remove extra whitespace
corpus <- tm_map(corpus, stemDocument) # Perform stemming

# Inspect the preprocessed text
inspect(corpus)

# Create a Document-Term Matrix
dtm <- DocumentTermMatrix(corpus)

# Inspect the Document-Term Matrix
inspect(dtm)


# Load the topicmodels library
library(topicmodels)

# Set the number of topics
num_topics <- 5

# Fit the LDA model
lda_model <- LDA(dtm, k = num_topics, control = list(seed = 1234))

# Get the terms for each topic
terms(lda_model, 5)


# Convert the LDA output to a tidy format
library(tidytext)
lda_tidy <- tidy(lda_model)

# Visualize the top terms per topic
library(ggplot2)
top_terms <- lda_tidy %>%
  group_by(topic) %>%
  top_n(10, beta) %>%
  ungroup() %>%
  arrange(topic, -beta)

ggplot(top_terms, aes(term, beta, fill = factor(topic))) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ topic, scales = "free") +
  coord_flip()