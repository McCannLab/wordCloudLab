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
  "qui", "within", "per", "vol", "well", "used", "use", "nat", "iew", "less",
  "usa", "iii", "fcl", "utc", "among", "web", "webs", "sci", "log"
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
docs %<>% tm_map(substit, from="networks", to="network")
docs %<>% tm_map(substit, from="lakes", to="lake")
docs %<>% tm_map(substit, from="lake", to="lakes")
docs %<>% tm_map(substit, from="fishes", to="fish")
docs %<>% tm_map(substit, from="communities", to= "community")
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
  freq = 500*c(1, 1, .3, .2, .2)
  )
## Combine the dataset / order and keeb the 500 more frequent words
dat <- rbind(datext, datdoc)


id <- which(dat$word == "mccann")
dat[id, "word"] <- "McCann"
dat[id, "freq"] <- 1000

id <- which(dat$word == "food")
dat[id, "word"] <- "foodwebs"
dat[id, "freq"] <- 2400

## Weird punctutation..
id <- which(!grepl("[[:alpha:]]", dat$word))
dat <- dat[-id, ]

##
dat <- dat[rev(order(dat$freq)),]
dat <- dat[1:800,]
head(dat)
saveRDS(dat, file = "data/corpusMcCann.rds")
