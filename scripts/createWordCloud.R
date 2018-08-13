# library(devtools)
# devtools::install_github("lchiffon/wordcloud2")
library(wordcloud2)
# library(htmlwidgets)
# library(webshot)

## Creating the wordcloud

### NB: there is an issue with the use of mask, so you need to refresh one time
### to get wordcloud... which I guess prevent webshot from
### working well...
data <- readRDS("data/corpusMcCann.rds")
wc_aut <- wordcloud2(dat, figPath="img/Coregonus-hoyi.png", size = 2,
  color=rep(c(rep(1, 10), "#2a8abf"), length = 700), backgroundColor="white")
wc_aut

## save
# saveWidget(wc_aut, file = "wordCloudMcCann.html", selfcontained = TRUE)
# webshot("wordCloudMcCann.html", "fig/ourWordcloud.png", delay = 5)
