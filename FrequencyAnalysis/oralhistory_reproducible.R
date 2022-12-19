library(tidyverse)
library(textclean)
library(tidytext)
library(ggthemes)

# Load data
grev <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Grevera%20and%20Piscotty%20-%20Sheet1.csv", stringsAsFactors = F)
glow<- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Louis%20and%20Margie%20Glowaki%20-%20Sheet1.csv", stringsAsFactors = F)
braz <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Chester%20Brazina%20-%20Sheet1.csv", stringsAsFactors = F)
naug <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Anthony%20Naugin%20-%20Sheet1.csv", stringsAsFactors = F)
lutc <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Edward%20Lutchko%20-%20Sheet1.csv", stringsAsFactors = F)
parr <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/John%20Parroccini%20%20-%20Sheet1.csv", stringsAsFactors = F)
ligi <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Ligi%20J.L.%20&%20L.John%20&%20Luigi%20Lig%20-%20Sheet1.csv", stringsAsFactors = F)
slav <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/John%20Slavetskas%20-%20Sheet1.csv", stringsAsFactors = F)
gamb <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Mr.%20&%20Mrs.%20Gambo%20-%20Sheet1.csv", stringsAsFactors = F)
matt <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Robert%20Mattes%20-%20Sheet1.csv", stringsAsFactors = F)
gunt <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Stanley%20Guntack%20-%20Sheet1.csv", stringsAsFactors = F)
gawr <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Stanely%20Gawrych%20-%20Sheet1.csv", stringsAsFactors = F)
pric <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Tom%20Price%20-%20Sheet1.csv", stringsAsFactors = F)
hand <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Thomas%20Handing%20-%20Sheet1.csv", stringsAsFactors = F)
bart <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Victor%20Bartus%20-%20Sheet1.csv", stringsAsFactors = F)
dutc <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Walter%20Dutchak%20-%20Sheet1.csv", stringsAsFactors = F)
bodn <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/John%20Bodnar%20-%20Sheet1.csv", stringsAsFactors = F)
ingl <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/John%20Inglis%20-%20Sheet1.csv", stringsAsFactors = F)
mulh <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Joh%20Mulherin%20-%20Sheet1.csv", stringsAsFactors = F)
bosa <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/John%20and%20Anna%20Bosak%20-%20Sheet1.csv", stringsAsFactors = F)
lamb <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Earl%20W%20Lamb%20-%20Sheet1.csv", stringsAsFactors = F)
kada <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Anna%20Kadak%20-%20Sheet1.csv", stringsAsFactors = F)
dago <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Bill%20Davitt%20%26%20John%20Gordon%20%20-%20Sheet1.csv", stringsAsFactors = F)
sera <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/_Helen%20Serafim%20%20-%20Sheet1.csv", stringsAsFactors = F)
bost <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Frank%20Bostjancic%20Scranton%20Project%20Tapes%20July%2011%201973%20%20-%20Sheet1.csv", stringsAsFactors = F)
mili <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/scranton_interviews/Joseph%20Miliauskas%20-%20Sheet1.csv", stringsAsFactors = F)

# Remove first few rows of metadata, but keep as dataframe. This is different for each file since they are inconsistent. 
grev <- grev[-(1:6), , drop=F]
glow <- glow[-(1:8),, drop=F]
braz <- braz[-(1:5),,drop=F]
naug <- naug[-(1:4),,drop=F]
lutc <- lutc[-(1:3),,drop=F]
parr <- parr[-(1:6),,drop=F]
ligi <- ligi[-(1:5),,drop=F]
slav <- slav[-(1:4),,drop=F]
gamb <- gamb[-(1:4),,drop=F]
matt <- matt[-(1:4),,drop=F]
gunt <- gunt[-(1:4),,drop=F]
gawr <- gawr[-(1:4),,drop=F]
pric <- pric[-(1:4),,drop=F]
hand <- hand[-(1:4),,drop=F]
bart <- bart[-(1:3),,drop=F]
dutc <- dutc[-(1:4),,drop=F]
bodn <- bodn[-(1:4),,drop=F]
ingl <- ingl[-(1:4),,drop=F]
mulh <- mulh[-(1:4),,drop=F]
bosa <- bosa[-(1:4),,drop=F]
lamb <- lamb[-(1:4),,drop=F]
kada <- kada[-(1:4),,drop=F]
dago <- dago[-(1:4),,drop=F]
sera <- sera[-(1:3),,drop=F]
bost <- bost[-(1:4),,drop=F]
mili <- mili[-(1:4),,drop=F]

#turn the column name into "text" to make analysis easier
names(grev) <- c("text")
names(glow) <- c("text")
names(braz) <- c("text")
names(naug) <- c("text")
names(lutc) <- c("text")
names(parr) <- c("text")
names(ligi) <- c("text")
names(slav) <- c("text")
names(gamb) <- c("text")
names(matt) <- c("text")
names(gunt) <- c("text")
names(gawr) <- c("text")
names(pric) <- c("text")
names(hand) <- c("text")
names(bart) <- c("text")
names(dutc) <- c("text")
names(bodn) <- c("text")
names(ingl) <- c("text")
names(mulh) <- c("text")
names(bosa) <- c("text")
names(lamb) <- c("text")
names(kada) <- c("text")
names(dago) <- c("text")
names(sera) <- c("text")
names(bost) <- c("text")
names(mili) <- c("text")

# Add in new column to refer to which interview the data comes from
grev$ID <- "grev"
glow$ID <- "glow"
braz$ID <- "braz"
naug$ID <- "naug"
lutc$ID <- "lutc"
parr$ID <- "parr"
ligi$ID <- "ligi"
slav$ID <- "slav"
gamb$ID <- "gamb"
matt$ID <- "matt"
gunt$ID <- "gunt"
gawr$ID <- "gawr"
pric$ID <- "pric"
hand$ID <- "hand"
bart$ID <- "bart"
dutc$ID <- "dutc"
bodn$ID <- "bodn"
ingl$ID <- "ingl"
mulh$ID <- "mulh"
bosa$ID <- "bosa"
lamb$ID <- "lamb"
kada$ID <- "kada"
dago$ID <- "dago"
sera$ID <- "sera"
bost$ID <- "bost"
mili$ID <- "mili"

# Combine dataframes together into long corpus
dat <- rbind(grev, glow, braz, naug, lutc, parr, ligi, slav, gamb, matt, gunt, gawr, pric, hand, bart, dutc, bodn, ingl, mulh, bosa, lamb, kada, dago, sera, bost, mili)

# Standardize text
dat$tidied <- strip(dat$text, digit.remove=T, apostrophe.remove=T,lower.case=T)

#Here we follow basic analyses outlined in Text Mining with R: A Tidy Approach (Silge and Robinson 2017 [https://www.tidytextmining.com/tidytext.html])

# Look at top words
words <- dat %>% unnest_tokens(output=word, input=tidied)
# Top 50 words
words %>% count(word, sort = T) %>% top_n(50)

# Remove stopwords
data(stop_words)
dattidy <- words %>% anti_join(stop_words)
# Top 50 words
dattidy %>% count(word, sort = TRUE) %>% top_n(50) %>% mutate(word = reorder(word, n)) %>% data.frame()

# Remove common words, abbreviations, and names
datcommon <- c("1972", "didnt","bl","av","mm","thats","dont","hf","wasnt","youd","fz","cf","wb","ft","theyd","6","2","4","ss","yea","im","mj","piscotty", "grevera","an","lg","vb","je","av","mg","sg","el","jp","jb","brazina","yeah","j","b","fb","cg","bodnar","js", "1972", "didnt","bl","av","mm","thats","dont","hf","wasnt","youd","fz","cf","wb","ft","theyd","6","2","4","ss","yea","im","mj","piscotty", "grevera","an","lg","vb","je","av","mg","sg","el","jp","jb","brazina","yeah","j","b","fb","cg","bodnar","js", "malony", "margaret", "banas","bruno","laganowsky","fz","pz","bl","mary","falalko","frank","timko","marshilk","angela","varesano","brown","john","ss","sz","buzurka","zahay","interviewed","huh","yea","vb","piscotty","lagonosky", "maloney", "falatko")
datcommon<-data.frame(datcommon)
names(datcommon) <- "word"
# Antijoin with original data
dattidy <- dattidy %>% anti_join(datcommon)

# Top 50 words
top50_scranton <- dattidy %>% count(word, sort = TRUE) %>% top_n(50) %>% mutate(word = reorder(word, n)) %>% data.frame()

# Plot it
top50_scrantonplot <- top50_scranton %>% ggplot(aes(x = word, y = n)) + geom_col() + 
  xlab(NULL) + coord_flip() + labs(y = "Count", x = "Words", title = "Top 50 words in Scranton interviews") + theme_tufte(base_size = 18) + geom_hline(yintercept=100, linetype="dotted")+ geom_hline(yintercept=200, linetype="dotted")+ geom_hline(yintercept=300, linetype="dotted")
### Figure 1
top50_scrantonplot

## Bigram analysis
bigrams <- dat %>% unnest_tokens(output = bigrams, input = tidied, token = "ngrams",  n = 2)
# Separate words to pull out stop words
separated_words <- bigrams %>% separate(bigrams, c("word1", "word2"), sep = " ")
# Filter out stop words
dat_bigrams <- separated_words %>% filter(!word1 %in% stop_words$word) %>% filter(!word2 %in%  stop_words$word)
# Filter out common words
dat_bigrams <- dat_bigrams %>% filter(!word1 %in% datcommon$word) %>% filter(!word2 %in%  datcommon$word)
# Top bigrams, TABLE 1
dat_bigrams_count <- dat_bigrams %>% count(word1, word2, sort = TRUE)
top50bigramscranton<-dat_bigrams_count %>% top_n(50)
top50bigramscranton


## Trigram analysis
trigrams <- dat %>% unnest_tokens(output = sentence, input = tidied, token = "ngrams",  n = 3)
dat_trigrams_count <- trigrams %>% count(sentence, sort = TRUE) 
dat_trigrams_count %>% top_n(50)

## Analyzing words in proximity to key terms
### Coal
#What words appear near this term?
dattidy %>% count(word, sort = TRUE) %>% filter(word=="coal")
coalbigram <- dat_bigrams_count %>% filter(word1 == "coal" | word2 == "coal")
# Table 2
coalbigram                    















