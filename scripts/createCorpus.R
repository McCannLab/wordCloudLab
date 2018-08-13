## Packages
library(tm)
library(magrittr)

## Text Mining
# Text mining reference: http://onepager.togaware.com/TextMiningO.pdf
# the bash code below should be executed in your terminal when a new publication
# is added in the dropbox folder:
docs <- Corpus(
  DirSource(
    directory = "pdf/",
    pattern="*.txt")
    )

###################
# inspect(docs[1])
# getTransformations()
stopwords_pers <-  c(
  "hence", "since", "university", "can", "also", "null", "using", "may",
  "first", "will", "one", "two", "three", "fig", "tab", "eqn", "therefore",
  "gravel", "des", "although", "aij", "clearly", "lett",
  "res", "thuiller", "biol", "les", "une", "que", "dans", "son", "etre", "est",
  "qui", "within", "per", "vol", "well", "used", "use"
  )
docs %<>% tm_map(content_transformer(tolower))
docs %<>% tm_map(removeNumbers)
docs %<>% tm_map(removePunctuation)
docs %<>% tm_map(removeWords, stopwords("english"))
docs %<>% tm_map(removeWords, stopwords_pers)
substit <- content_transformer(function(x, from, to) gsub(from, to, x))
docs %<>% tm_map(substit, from="species distribution model ", to = "sdm ")
docs %<>% tm_map(substit, from="species distribution models ", to = "sdm ")
docs %<>% tm_map(substit, from="model ", to="models ")
docs %<>% tm_map(substit, from="probabilities", to="probability")
docs %<>% tm_map(substit, from="probabilistic", to="probability")
docs %<>% tm_map(substit, from="interactions", to="interaction")
docs %<>% tm_map(substit, from="theories", to="theory")
docs %<>% tm_map(substit, from="network ", to="networks ")
docs %<>% tm_map(substit, from="webs", to= "web")
# docs %<>% tm_map(substit, from="web", to= "food web")
docs %<>% tm_map(substit, from="distribution ", to="distributions ")
docs %<>% tm_map(substit, from="ecol ", to="ecology ")
docs %<>% tm_map(substit, from="SDMs", to="SDM")
###################
# cat("*Wourdcloud to be added* <br/><br/>")
dtm <- DocumentTermMatrix(docs)
freq <- colSums(as.matrix(dtm))
datdoc <- data.frame(word = names(freq), freq = freq)
datdoc <- datdoc[rev(order(datdoc$freq)), ]
datext <- data.frame(
  word = c("Dynamics", "theory", "ODE", "Mathematica", "Julia"),
  freq = 100*c(1, 1, .3, .1, .1)
  )
## Combine the dataset / order and keeb the 500 more frequent words
dat <- rbind(datext, datdoc)
dat <- dat[rev(order(dat$freq)),]
dat <- dat[1:700,]

id <- which(dat$word == "mccann")
dat[id, "word"] <- "Food Webs"

dat[which(dat$word == "food"), "word"] <- "Food Webs"
dat[which(dat$word == "web"), "freq"] <- 10

saveRDS(dat, file = "data/corpusMcCann.rds")
