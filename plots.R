plot_one <- function(d, date_lim=NULL)
{
  require("ggplot2", quietly=TRUE)
  g <- ggplot(d,aes(x=time,y=price)) +
    geom_line() +
    ggtitle(unique(d$comment)[1])

  if (! is.null(date_lim))
    g <- g + xlim(date_lim[1],date_lim[2])

  g
}

options(width=150)
args <- commandArgs(trailingOnly = TRUE)
source(paste(args[3],"functions.R",sep="/"))

data <- read_data(fn_url = args[1],fn_data = args[2])
data$time <- as.POSIXct(data$time, origin="1970-01-01")


plots <- lapply(split(data,data$url), plot_one,
                date_lim = c(min(data$time), max(data$time)))
plots <- lapply(plots, ggplot2::ggplotGrob)
plots <- gridExtra::marrangeGrob(plots,
                                 nrow=2,
                                 ncol=2,
                                 top=NULL)
ggplot2::ggsave(paste(dirname(args[1]),"plots.pdf",sep="/"),
                plots,
                width = 10, height = 7)

