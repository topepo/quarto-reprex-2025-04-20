require(tidymodels)
require(scales)
require(gt)
require(gtExtras)
require(glue)
require(patchwork)


# ------------------------------------------------------------------------------

light_bg <- "#fcfefe" # from aml4td.scss
dark_bg <- "#222"


# ------------------------------------------------------------------------------
# ggplot stuff

theme_transparent <- function(...) {

  ret <- ggplot2::theme_bw(...)

  transparent_rect <- ggplot2::element_rect(fill = "transparent", colour = NA)
  ret$panel.background  <- transparent_rect
  ret$plot.background   <- transparent_rect
  ret$legend.background <- transparent_rect
  ret$legend.key        <- transparent_rect

  ret$legend.position <- "top"

  ret
}

log_2_breaks <- scales::trans_breaks("log2", function(x) 2^x)
log_2_labs   <- scales::trans_format("log2", scales::math_format(2^.x))

dk_text <- ggplot2::element_text(color = "#adb5bd")
dk_rect <- ggplot2::element_rect(fill = "transparent", color = "#adb5bd")

dk_thm <- 
  ggplot2::theme_dark() +
  ggplot2::theme(
    text = dk_text,
    legend.background = dk_rect,
    legend.box.background = dk_rect,
    panel.background = dk_rect,
    plot.background = ggplot2::element_rect(fill = "transparent", color = NA),
    strip.background = dk_rect
  )

dk_gif_thm <- 
  ggplot2::theme_dark() +
  ggplot2::theme(
    text = dk_text,
    legend.background = dk_rect,
    legend.box.background = dk_rect,
    panel.background = dk_rect,
    plot.background = ggplot2::element_rect(fill = dark_bg, color = NA),
    strip.background = dk_rect
  )

# ------------------------------------------------------------------------------
# formatting for package names

pkg <- function(x) {
  cl <- match.call()
  x <- as.character(cl$x)
  paste0('<span class="pkg">', x, '</span>')
}

pkg_chr <- function(x) {
  paste0('<span class="pkg">', x, '</span>')
}

# ------------------------------------------------------------------------------
# Misc options for chunks and printing

set_options <- function() {
  options(digits = 4, width = 84)
  options(dplyr.print_min = 6, dplyr.print_max = 6)
  options(cli.width = 85)
  options(crayon.enabled = FALSE)
  options(pillar.advice = FALSE, pillar.min_title_chars = Inf)
  invisible(NULL)
}

# ------------------------------------------------------------------------------

knitr::opts_chunk$set(
  comment = "#>",
  collapse = TRUE,
  fig.align = 'center',
  fig.path = "../figures/",
  fig.width = 10,
  fig.height = 6,
  out.width = "95%",
  dev = 'svg',
  dev.args = list(bg = "transparent"),
  tidy = FALSE,
  echo = FALSE
)

r_comp <- function(stub) {
  glue::glue(
    '<a href="https://tidymodels.aml4td.org/chapters/[stub]">{{< fa brands r-project size=Large >}}</a>',
    .open = "[", .close = "]"
  )
}

# ------------------------------------------------------------------------------
# From recipes::names0 and used in shinylive chunks; see https://github.com/aml4td/website/pull/80

names_zero_padded <- function(num, prefix = "x", call = rlang::caller_env()) {
  rlang:::check_number_whole(num, min = 1, call = call)
  ind <- format(seq_len(num))
  ind <- gsub(" ", "0", ind)
  paste0(prefix, ind)
}
