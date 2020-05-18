#!/usr/bin/env Rscript -f

report <- function(data) {
  data <- split(data, list(data$url, data$comment), drop=TRUE)

  report <-
    do.call(rbind,
            lapply(data, function(d)
            {
              data.frame(
                "comment"=unique(d$comment)[1],
                "url"=unique(d$url)[1],
                "min"=round(min(d$price),2),
                "max"=round(max(d$price),2),
                "mean"=round(mean(d$price),2),
                "ndays"=round((max(d$time) - min(d$time))/60/60/24),
                "ecdf"=round(ecdf(d$price)(tail(d$price,1)),2),
                "spread"=round((max(d$price) - min(d$price))/max(d$price),2),
                "last"=round(tail(d$price,1),2))
            }))
  report <- as.data.frame(report)
  rownames(report) <- 1:nrow(report)

  report$message <- ""

  report$message[report$last < report$max] <- "!"
  report$message[report$last < report$mean] <- "!!"
  report$message[report$last < report$mean] <- "!!"
  report$message[abs(report$last - report$min) < .Machine$double.eps^0.5 &
                   abs(report$max - report$min) > .Machine$double.eps^0.5] <- "!!!"
  report$message[abs(report$max - report$min) < .Machine$double.eps^0.5] <- "*"

  report[,c("comment","message","ecdf","ndays","spread",
            "min","mean","max","last","url")]
}

options(width=150)
args <- commandArgs(trailingOnly = TRUE)
source(paste(args[3],"functions.R",sep="/"))

data <- read_data(fn_url = args[1],fn_data = args[2])
print(report(data))
