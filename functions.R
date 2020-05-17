read_data <- function(fn_url, fn_data)
{
  url <- read.csv(fn_url, header = FALSE)
  data <- read.csv(fn_data, header = FALSE)

  colnames(data) <- c("url","time","price")
  colnames(url) <- c("url","comment")

  data <- data[!is.na(data$price),]
  data <- merge(data, url, by="url")
  data <- data[order(data$time),]

  data
}
