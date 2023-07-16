#load libraries
library(tidyverse)
library(wordcloud)
library(wordcloud2)
library(tidytext)
library(stringr)
library(topicmodels)
library(data.table)
library(cleanNLP)
cnlp_init_udpipe()
library(quanteda)
library(textclean)
library(ggpubr)
library(kableExtra)
library(ggthemes)
library(textdata)


#First we load in the data, clean it up and tokenize it (turn into individual words). 

#load data
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


#check out structure
str(grev)
str(glow)
str(lutc)
str(parr)
str(ligi)

#the header of this spreadsheet has 6 rows that are not useful, lets remove them and rename the column
head(grev)
grev[1:10,]
glow[1:10,]
braz[1:10,]
naug[1:10,]
lutc[1:10,]
parr[1:10,]
ligi[1:10,]
slav[1:10,]
gamb[1:10,]
matt[1:10,]
gunt[1:10,]
gawr[1:10,]
pric[1:10,]
hand[1:10,]
bart[1:10,]
dutc[1:10,]
bodn[1:10,]
ingl[1:10,]
mulh[1:10,]
bosa[1:10,]
lamb[1:10,]
kada[1:10,]
dago[1:10,]
sera[1:10,]
bost[1:10,]
mili[1:10,]


#remove first few rows which are filler, but keep as dataframe. this is different for each file since they are inconsistant. 
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

#add in new column to refer to which interview the data comes from
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


#combine dataframes together into long corpus
dat <- rbind(grev, glow, braz, naug, lutc, parr, ligi, slav, gamb, matt, gunt, gawr, pric, hand, bart, dutc, bodn, ingl, mulh, bosa, lamb, kada, dago, sera, bost, mili)

# standardize text
#when loading the text, it includes curly apostrophes and these don't match with straight ones.
#here we remove punctuation, convert to lowercase, remove digits


dat$tidied <- strip(dat$text, digit.remove=T, apostrophe.remove=T,lower.case=T)

#remove stop words
data(stop_words)
dattidy <- words %>% anti_join(stop_words)
#top 50 words
dattidy %>% count(word, sort = TRUE) %>% top_n(50) %>% mutate(word = reorder(word, n)) %>% data.frame()

# Top 50 words in oral histories (no stop words)
top50wordsplot <- dattidy %>% count(word, sort = TRUE) %>% top_n(50) %>% 
mutate(word = reorder(word, n)) %>% ggplot(aes(x = word, y = n)) + geom_col() + 
  xlab(NULL) + coord_flip() + labs(y = "Count", x = "Unique words", title = "dat interview")
top50wordsplot

#A lot of these words are simply names or abbreviations of names, so let's remove them. This is a custom stopwords list.
datcommon <- c("1972", "didnt","bl","av","mm","thats","dont","hf","wasnt","youd","fz","cf","wb","ft","theyd","6","2","4","ss","yea","im","mj","piscotty", "grevera","an","lg","vb","je","av","mg","sg","el","jp","jb","brazina","yeah","j","b","fb","cg","bodnar","js", "1972", "didnt","bl","av","mm","thats","dont","hf","wasnt","youd","fz","cf","wb","ft","theyd","6","2","4","ss","yea","im","mj","piscotty", "grevera","an","lg","vb","je","av","mg","sg","el","jp","jb","brazina","yeah","j","b","fb","cg","bodnar","js", "malony", "margaret", "banas","bruno","laganowsky","fz","pz","bl","mary","falalko","frank","timko","marshilk","angela","varesano","brown","john","ss","sz","buzurka","zahay","interviewed","huh","yea","vb","piscotty","lagonosky", "maloney", "falatko", "glowaki", "ab", "hed", "jg","hes", "ak")
datcommon<-data.frame(datcommon)
names(datcommon) <- "word"
#antijoin with original data
dattidy <- dattidy %>% anti_join(datcommon)


#Additional word processing to combine common words. For example, "work" and "worked". Note: I'm not combining "mine" and "mines" since this could be a reference to a possessive term rather than the place. Left isnt converted to leave for the same reason

#Went back to top 300 words (showing up at least 16 times) and did data standardization for tense and plurality

dattidy$word<-dattidy$word %>% 
  str_replace("miners","miner") %>% str_replace("lived","live") %>% str_replace("cars","car")%>% str_replace("stores","store")%>% str_replace("brothers","brother")%>% str_replace("hours","hour")%>% str_replace("houses","house") %>% str_replace("stayed","stay") %>% str_replace("workers","worker")%>% str_replace("mentioned","mention") %>% str_replace("friends","friend") %>% str_replace("called","call") %>% str_replace("dollars","dollar") %>% str_replace("told","tell") %>% str_replace("striked","strike") %>% str_replace("paid","pay") %>% str_replace("weeks","week")  %>% str_replace("boys","boy") %>% str_replace("jobs","job")  %>% str_replace("strikes","strike")  %>% str_replace("died","die")  %>% str_replace("parents","parent")  %>% str_replace("bosses","boss")  %>% str_replace("days","day")%>% str_replace("companies","company") %>% str_replace("killed","kill") %>% str_replace("mentioned","mention")%>% str_replace("bought","buy") %>% str_replace("cares","care") %>% str_replace("walked","walk") %>% str_replace("stored","store")%>% str_replace("schools","school")

dattidy$word<-dattidy$word %>% 
  str_replace("homes","home")%>% 
  str_replace("nationalities","nationality")%>% 
  str_replace("mills","mill")%>% 
  str_replace("talked","talk")%>% 
  str_replace("talking","talk")%>% 
  str_replace("taking","take")%>% 
  str_replace("took","take")%>% 
  str_replace("gardens","garden")%>% 
  str_replace("raised","raise")%>% 
  str_replace("interviewing","interview")%>% 
  str_replace("happened","happen")%>% 
  str_replace("churches","church")%>% 
  str_replace("papers","paper")%>% 
  str_replace("relatives","relative")%>% 
  str_replace("girls","girl")%>% 
  str_replace("conditions","condition")%>% 
  str_replace("boarders","boarder")%>% 
  str_replace("heard","hear")%>% 
  str_replace("mothers","mother")%>% 
  str_replace("mcgurie","mcguire")%>% 
  str_replace("fathers","father")%>% 
  str_replace("living","live")%>% 
  str_replace("brought","bring")%>% 
  str_replace("helped","help")%>% 
  str_replace("lots","lot")%>% 
  str_replace("taught","teach")%>% 
  str_replace("helping","help")%>% 
  str_replace("songs","song")%>% 
  str_replace("sold","sell")%>% 
  str_replace("organized","organize")%>% 
  str_replace("organizations","organization")%>% 
  str_replace("played","play")%>% 
  str_replace("religions","religion")%>% 
  str_replace("foods","food")%>% 
  str_replace("families","family")%>% 
  str_replace("slovaks","slovak")%>% 
  str_replace("lives","live")


dattidy$word<-dattidy$word %>% 
  str_replace("stories","story")%>% 
  str_replace("picnics","picnic")%>% 
  str_replace("peddlers","peddler")%>% 
  str_replace("lost","lose")%>% 
  str_replace("chickens","chicken")%>% 
  str_replace("fights","fight")%>% 
  str_replace("months","month")%>% 
  str_replace("sisters","sister")%>% 
  str_replace("wrote","write")%>% 
  str_replace("closed","close")%>% 
  str_replace("cows","cow")%>% 
  str_replace("laborers","laborer")%>% 
  str_replace("belonged","belong")%>% 
  str_replace("boarding","board")%>% 
  str_replace("unions","union")%>% 
  str_replace("mules","mule")%>% 
  str_replace("changed","change")%>% 
  str_replace("owned","own")%>% 
  str_replace("started","start") %>% 
  str_replace("moved","move") %>% 
  str_replace("mined","mining") %>% 
  str_replace("found","find")%>% 
  str_replace("games","game")%>% 
  str_replace("operators","operator")%>% 
  str_replace("operators","operator")%>% 
  str_replace("hometead","homestead")%>% 
  str_replace("kids","kid")%>% 
  str_replace("kid","children")%>% 
  str_replace("customs","custom")%>% 
  str_replace("children","child")%>% 
  str_replace("running","run")


#New top 50 words
top50_scranton <- dattidy %>% count(word, sort = TRUE) %>% top_n(50) %>% mutate(word = reorder(word, n)) %>% data.frame()

#top 100 words
top100_scranton <- dattidy %>% count(word, sort = TRUE) %>% top_n(100) %>% mutate(word = reorder(word, n)) %>% data.frame()

#top 20 words
top20_scranton <- dattidy %>% count(word, sort = TRUE) %>% top_n(20) %>% mutate(word = reorder(word, n)) %>% data.frame()

#plot it
top50_scrantonplot <- top50_scranton %>% ggplot(aes(x = word, y = n)) + geom_col() + 
  xlab(NULL) + coord_flip() + labs(y = "Count", x = "Words", title = "Top 50 words in Scranton interviews") + theme_tufte(base_size = 18) + geom_hline(yintercept=100, linetype="dotted")+ geom_hline(yintercept=200, linetype="dotted")+ geom_hline(yintercept=300, linetype="dotted")
top50_scrantonplot


top20_scrantonplot <- top20_scranton %>% ggplot(aes(x = word, y = n)) + geom_col() + 
  xlab(NULL) + coord_flip() + labs(y = "Count", x = "Words", title = "Top 20 words in Scranton interviews") + theme_tufte(base_size = 18) + geom_hline(yintercept=100, linetype="dotted")+ geom_hline(yintercept=200, linetype="dotted")+ geom_hline(yintercept=300, linetype="dotted")
top20_scrantonplot

# Bigram analysis
#look at bigrams
bigrams <- dat %>% unnest_tokens(output = bigrams, input = tidied, token = "ngrams",  n = 2)
# separate words to pull out stop words
separated_words <- bigrams %>% separate(bigrams, c("word1", "word2"), sep = " ")
# filter out stop words
dat_bigrams <- separated_words %>% filter(!word1 %in% stop_words$word) %>% filter(!word2 %in%  stop_words$word)

# filter out common words
dat_bigrams <- dat_bigrams %>% filter(!word1 %in% datcommon$word) %>% filter(!word2 %in%  datcommon$word)

#remove NA

dat_bigrams <- dat_bigrams %>% filter(!is.na(word1))

#standardizing words based on tense and plurality


dat_bigrams$word1  <-
  dat_bigrams$word1 %>% 
  str_replace("miners","miner") %>% str_replace("lived","live") %>% str_replace("cars","car")%>% str_replace("stores","store")%>% str_replace("brothers","brother")%>% str_replace("hours","hour")%>% str_replace("houses","house") %>% str_replace("stayed","stay") %>% str_replace("workers","worker")%>% str_replace("mentioned","mention") %>% str_replace("friends","friend") %>% str_replace("called","call") %>% str_replace("dollars","dollar") %>% str_replace("told","tell") %>% str_replace("striked","strike") %>% str_replace("paid","pay") %>% str_replace("weeks","week")  %>% str_replace("boys","boy") %>% str_replace("jobs","job")  %>% str_replace("strikes","strike")  %>% str_replace("died","die")  %>% str_replace("parents","parent")  %>% str_replace("bosses","boss")  %>% str_replace("days","day")%>% str_replace("companies","company") %>% str_replace("killed","kill") %>% str_replace("mentioned","mention")%>% str_replace("bought","buy") %>% str_replace("cares","care") %>% str_replace("walked","walk") %>% str_replace("stored","store")%>% str_replace("schools","school")

dat_bigrams$word2  <-
  dat_bigrams$word2 %>% 
  str_replace("miners","miner") %>% str_replace("lived","live") %>% str_replace("cars","car")%>% str_replace("stores","store")%>% str_replace("brothers","brother")%>% str_replace("hours","hour")%>% str_replace("houses","house") %>% str_replace("stayed","stay") %>% str_replace("workers","worker")%>% str_replace("mentioned","mention") %>% str_replace("friends","friend") %>% str_replace("called","call") %>% str_replace("dollars","dollar") %>% str_replace("told","tell") %>% str_replace("striked","strike") %>% str_replace("paid","pay") %>% str_replace("weeks","week")  %>% str_replace("boys","boy") %>% str_replace("jobs","job")  %>% str_replace("strikes","strike")  %>% str_replace("died","die")  %>% str_replace("parents","parent")  %>% str_replace("bosses","boss")  %>% str_replace("days","day")%>% str_replace("companies","company") %>% str_replace("killed","kill") %>% str_replace("mentioned","mention")%>% str_replace("bought","buy") %>% str_replace("cares","care") %>% str_replace("walked","walk") %>% str_replace("stored","store")%>% str_replace("schools","school")

dat_bigrams$word1  <-
  dat_bigrams$word1 %>% 
  str_replace("homes","home")%>% 
  str_replace("nationalities","nationality")%>% 
  str_replace("mills","mill")%>% 
  str_replace("talked","talk")%>% 
  str_replace("talking","talk")%>% 
  str_replace("taking","take")%>% 
  str_replace("took","take")%>% 
  str_replace("gardens","garden")%>% 
  str_replace("raised","raise")%>% 
  str_replace("interviewing","interview")%>% 
  str_replace("happened","happen")%>% 
  str_replace("churches","church")%>% 
  str_replace("papers","paper")%>% 
  str_replace("relatives","relative")%>% 
  str_replace("girls","girl")%>% 
  str_replace("conditions","condition")%>% 
  str_replace("boarders","boarder")%>% 
  str_replace("heard","hear")%>% 
  str_replace("mothers","mother")%>% 
  str_replace("mcgurie","mcguire")%>% 
  str_replace("fathers","father")%>% 
  str_replace("living","live")%>% 
  str_replace("brought","bring")%>% 
  str_replace("helped","help")%>% 
  str_replace("lots","lot")%>% 
  str_replace("taught","teach")%>% 
  str_replace("helping","help")%>% 
  str_replace("songs","song")%>% 
  str_replace("sold","sell")%>% 
  str_replace("organized","organize")%>% 
  str_replace("organizations","organization")%>% 
  str_replace("played","play")%>% 
  str_replace("religions","religion")%>% 
  str_replace("foods","food")%>% 
  str_replace("families","family")%>% 
  str_replace("slovaks","slovak")%>% 
  str_replace("lives","live")


dat_bigrams$word2  <-
  dat_bigrams$word2 %>% 
  str_replace("homes","home")%>% 
  str_replace("nationalities","nationality")%>% 
  str_replace("mills","mill")%>% 
  str_replace("talked","talk")%>% 
  str_replace("talking","talk")%>% 
  str_replace("taking","take")%>% 
  str_replace("took","take")%>% 
  str_replace("gardens","garden")%>% 
  str_replace("raised","raise")%>% 
  str_replace("interviewing","interview")%>% 
  str_replace("happened","happen")%>% 
  str_replace("churches","church")%>% 
  str_replace("papers","paper")%>% 
  str_replace("relatives","relative")%>% 
  str_replace("girls","girl")%>% 
  str_replace("conditions","condition")%>% 
  str_replace("boarders","boarder")%>% 
  str_replace("heard","hear")%>% 
  str_replace("mothers","mother")%>% 
  str_replace("mcgurie","mcguire")%>% 
  str_replace("fathers","father")%>% 
  str_replace("living","live")%>% 
  str_replace("brought","bring")%>% 
  str_replace("helped","help")%>% 
  str_replace("lots","lot")%>% 
  str_replace("taught","teach")%>% 
  str_replace("helping","help")%>% 
  str_replace("songs","song")%>% 
  str_replace("sold","sell")%>% 
  str_replace("organized","organize")%>% 
  str_replace("organizations","organization")%>% 
  str_replace("played","play")%>% 
  str_replace("religions","religion")%>% 
  str_replace("foods","food")%>% 
  str_replace("families","family")%>% 
  str_replace("slovaks","slovak")%>% 
  str_replace("lives","live")

dat_bigrams$word1<-dat_bigrams$word1 %>% 
  str_replace("stories","story")%>% 
  str_replace("picnics","picnic")%>% 
  str_replace("peddlers","peddler")%>% 
  str_replace("lost","lose")%>% 
  str_replace("chickens","chicken")%>% 
  str_replace("fights","fight")%>% 
  str_replace("months","month")%>% 
  str_replace("sisters","sister")%>% 
  str_replace("wrote","write")%>% 
  str_replace("closed","close")%>% 
  str_replace("cows","cow")%>% 
  str_replace("laborers","laborer")%>% 
  str_replace("belonged","belong")%>% 
  str_replace("boarding","board")%>% 
  str_replace("unions","union")%>% 
  str_replace("mules","mule")%>% 
  str_replace("changed","change")%>% 
  str_replace("owned","own")%>% 
  str_replace("started","start") %>% 
  str_replace("moved","move") %>% 
  str_replace("mined","mining") %>% 
  str_replace("found","find")%>% 
  str_replace("games","game")%>% 
  str_replace("operators","operator")%>% 
  str_replace("operators","operator")%>% 
  str_replace("hometead","homestead")%>% 
  str_replace("kids","kid")%>% 
  str_replace("kid","children")%>% 
  str_replace("customs","custom")%>% 
  str_replace("children","child")%>% 
  str_replace("running","run")


dat_bigrams$word2<-dat_bigrams$word2 %>% 
  str_replace("stories","story")%>% 
  str_replace("picnics","picnic")%>% 
  str_replace("peddlers","peddler")%>% 
  str_replace("lost","lose")%>% 
  str_replace("chickens","chicken")%>% 
  str_replace("fights","fight")%>% 
  str_replace("months","month")%>% 
  str_replace("sisters","sister")%>% 
  str_replace("wrote","write")%>% 
  str_replace("closed","close")%>% 
  str_replace("cows","cow")%>% 
  str_replace("laborers","laborer")%>% 
  str_replace("belonged","belong")%>% 
  str_replace("boarding","board")%>% 
  str_replace("unions","union")%>% 
  str_replace("mules","mule")%>% 
  str_replace("changed","change")%>% 
  str_replace("owned","own")%>% 
  str_replace("started","start") %>% 
  str_replace("moved","move") %>% 
  str_replace("mined","mining") %>% 
  str_replace("found","find")%>% 
  str_replace("games","game")%>% 
  str_replace("operators","operator")%>% 
  str_replace("operators","operator")%>% 
  str_replace("hometead","homestead")%>% 
  str_replace("kids","kid")%>% 
  str_replace("kid","children")%>% 
  str_replace("customs","custom")%>% 
  str_replace("children","child")%>% 
  str_replace("running","run")

#top bigrams
dat_bigrams_count <- dat_bigrams %>% count(word1, word2, sort = TRUE) 
top50bigramscranton<-dat_bigrams_count %>% top_n(50)
top50bigramscranton


## Sentiment analysis

#Tagging with bing
get_sentiments("nrc")
#more help here: https://rpubs.com/cliex159/860352
wordsbysentiment <- dattidy %>% inner_join(get_sentiments("bing")) %>% count(word,sentiment) %>% group_by(sentiment) %>% top_n(50) %>% ungroup() %>% mutate(word_ordered=fct_reorder(word,n))

wordsbysentiment

#plot this
ggplot(wordsbysentiment, aes(word_ordered,n)) +geom_col() + facet_wrap(~sentiment, scales="free") +coord_flip() + labs(title="Sentiment in Scranton interviews (Bing lexicon)", x="Words",y="Count")

#Tagging with afinn

get_sentiments("afinn")
wordsbysentimentAFINN <- dattidy %>% inner_join(get_sentiments("afinn")) %>% count(word,value) %>% top_n(20) %>% ungroup() %>% mutate(word_ordered=fct_reorder(word,n))


ggplot(wordsbysentimentAFINN, aes(word_ordered,value)) +geom_col() +coord_flip() + labs(title="Sentiment in Scranton interviews (AFINN lexicon)", x="Words",y="AFINN value")

### Tagging based on custom lexicon
coal_lex_scran <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/SentimentAnalysis/top50scranton_ANNOTATED.csv")

#Collapse community and community 2
coal_lex_scran<-coal_lex_scran %>% mutate(COMMUNITY=ifelse(COMMUNITY=="Y", COMMUNITY, COMMUNITY2))

coal_lex_scran<-coal_lex_scran %>% mutate(WORK=ifelse(WORK=="Y", WORK, WORK2))

#remove extra columns
coal_lex_scran<-coal_lex_scran %>% select(!c(WORK2, COMMUNITY2))

#Convert from wide to long format
coal_lex_scran_long <- coal_lex_scran %>% pivot_longer(!c(X,word,n),names_to = "sentiment", values_to="count")

#remove rows where a word is not tagged with particular sentiment
coal_lex_scran_long<-coal_lex_scran_long%>% filter(count!="")

### Now join the scranton words with sentiment

scrantonwordsbylex <- dattidy %>% inner_join(coal_lex_scran_long) %>% count(word,sentiment) %>% group_by(sentiment) %>% ungroup() %>% mutate(word_ordered=fct_reorder(word,n))
scrantonwordsbylex

#plot this
ggplot(scrantonwordsbylex, aes(word_ordered,n)) +geom_col() + facet_wrap(~sentiment, scales="free") +coord_flip() + labs(title="Sentiment in Scranton interviews", x="Words",y="Count") + theme_tufte(base_size=20)


## Bigram tagging
### Tagging based on custom lexicon
coal_bigramlex_scran <- read.csv("https://raw.githubusercontent.com/maddiebrown/OralHistories/main/SentimentAnalysis/top50bigramscranton_ANNOTATED.csv")



#Convert from wide to long format
coal_bigramscran_long <- coal_bigramlex_scran %>% pivot_longer(!c(X,word1,word2,n),names_to = "sentiment", values_to="count")

#remove rows where a word is not tagged with particular sentiment
coal_bigramscran_long<-coal_bigramscran_long%>% filter(count!="")


### Now join the scranton bigram with sentiment
dat_bigram_subset <- dat_bigrams %>% select(word1,word2)
#looking at words associated with ice as a double check
#dat_bigrams %>% filter(word1=="ice")
scrantonbigrambylex <- dat_bigram_subset %>% inner_join(coal_bigramscran_long) %>% filter(count!="") %>% group_by(word1,word2,sentiment) %>% summarize(count=sum(count=="Y"), n=max(n))
scrantonbigrambylex

#make new column of merged words
scrantonbigrambylex$bigram <- paste(scrantonbigrambylex$word1, scrantonbigrambylex$word2, sep=" ")

scrantonbigrambylex

ggplot(scrantonbigrambylex, aes(fct_reorder(bigram,n),n)) +geom_col() + facet_wrap(~sentiment, scales="free") +coord_flip() + labs(title="Tagged Bigrams in Scranton interviews", x="Words",y="Count") + theme_tufte(base_size = 20)
