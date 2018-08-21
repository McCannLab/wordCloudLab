# library(devtools)
# devtools::install_github("lchiffon/wordcloud2")
library(wordcloud2)
# library(htmlwidgets)
# library(webshot)

img_bg <- paste0("img/", c(
  "Coregonus-hoyi.png",
  "lake_trout_reusable.png",
  "walleye_reusable.png",
  "white_sucker_reusable.png",
  "yellow_perch_reusable.png"
  )
)

# vc_col <- rep(c(rep(1, 10), "#2a8abf")
vc_col <- rainbow(24)

## Creating the wordcloud


### NB: there is an issue with the use of mask, so you need to refresh one time
### to get wordcloud... which I guess prevent webshot from
### working well...
dat <- readRDS("data/corpusMcCann.rds")[-c(1,2),]
wc_aut <- wordcloud2(dat, figPath = img_bg[2], size = 2,
  color = vc_col, length = 700), backgroundColor="white")
# wc_aut <- wordcloud2(dat, figPath="img/LakeTrout.png", size = 2,
#   color=rep(c(rep(1, 10), "#b55fa7"), length = 700), backgroundColor="white")
wc_aut

## save
# saveWidget(wc_aut, file = "wordCloudMcCann.html", selfcontained = TRUE)
# webshot("wordCloudMcCann.html", "fig/ourWordcloud.png", delay = 5)
