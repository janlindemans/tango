
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tango

<!-- badges: start -->
<!-- badges: end -->

The tango package helps tango DJ preparing for milongas. You tell it the
specs of your milonga (duration, format, etc.), and it will give you an
overview of things like number of songs, start times for cycles, etc.
Things that may be useful for preparing playlists.

## Installation

You can install the development version of tango from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("janlindemans/tango")
```

## Example

If you’re a DJ and are preparing a playlist, one thing you will want to
know is how many songs you should add to your playlist, given the
duration of the milonga. For instance, if the milonga lasts for 4 hours,
how many songs do you need in your playlist? That’s what
`tango::milonga()` helps you with.

Say you are DJing a 5-hours milonga, with tandas of 4 songs and cortinas
of 45 seconds. This is what you do:

``` r
library(tango)
milonga(hrs = 5, tanda = 4, cortina = 45)
#> Milonga:
#> - 5 hrs minus 10.5 mins of slack (because of fitting tandas in time frame) = 289.5 mins
#> - 134 songs: 
#>   - 108 danced songs of 2.5 mins = 270 mins
#>   - 26 cortinas of 45 secs (of a 0.8 mins song) = 19.5 mins
#>   - 0 song extra for cumparsita
#> - 27 tandas of 10.8 mins, where a tanda is:
#>   - 4 danced songs of 2.5 mins = 10 mins
#>   - 1 cortina of 45 secs (of a 0.8 mins song)
#> - 4.5 cycles of 6 tandas:
#>   - Cycle 1: 08:00 PM
#>   - Cycle 2: 09:04 PM
#>   - Cycle 3: 10:09 PM
#>   - Cycle 4: 11:13 PM
#> 
#> Outside milonga (before and after): 
#> - 0 songs = 0 mins
#> 
#> Playlist:
#> - 134 songs (108 danced songs, excluding cortinas)
#> - 4 hrs and 49 mins (or 289.5 mins = 0 mins longer than milonga)
```

Now you can easily see how many songs you’ll need in your playlist, or
the total duration you’ll need to fill. It’s handy when filling your
playlist.

Notice that `tango::milonga()` filled in some default values for
variables you left blank: for instance, it assumed you’re starting at 8
PM. Maybe it doesn’t matter when it starts, but sometimes it’s handy to
track how the cycles will fit the development of the evening. As the
T-shirt says: 10 PM Di Sarli, 11 PM Troilo, 1 AM Pugliese (and D’Arienzo
at any time).

On defaults: If you run `tango::milonga()` raw, you’ll see what all the
defaults are:

``` r
milonga()
#> Milonga:
#> - 4 hrs minus 1.5 mins of slack (because of fitting tandas in time frame) = 238.5 mins
#> - 115 songs: 
#>   - 87 danced songs of 2.5 mins = 217.5 mins
#>   - 28 cortinas of 45 secs (of a 0.8 mins song) = 21 mins
#>   - 0 song extra for cumparsita
#> - 29 tandas of 8.2 mins, where a tanda is:
#>   - 3 danced songs of 2.5 mins = 7.5 mins
#>   - 1 cortina of 45 secs (of a 0.8 mins song)
#> - 4.8 cycles of 6 tandas:
#>   - Cycle 1: 08:00 PM
#>   - Cycle 2: 08:49 PM
#>   - Cycle 3: 09:39 PM
#>   - Cycle 4: 10:28 PM
#> 
#> Outside milonga (before and after): 
#> - 0 songs = 0 mins
#> 
#> Playlist:
#> - 115 songs (87 danced songs, excluding cortinas)
#> - 3 hrs and 58 mins (or 238.5 mins = 0 mins longer than milonga)
```

Pretty default, I’d say.

But you can make it very tailor-made. For instance, a shorter milonga of
3 hours and a half, starting at 11 AM, with shorter tandas, a TTVTM
structure (`cycle = 5`), 2 chacarera songs, a separate cumparsita, 8
“party” songs played outside of the milonga, and some other specs:

``` r
milonga(
  hrs = 3.5, tanda = 3, cycle = 5,
  song = 2.4, cortina = 30, cortina_actual = 3.5, 
  cumparsita_separate = TRUE, chacarera = 1, 
  start = 11, AM = TRUE,
  songs_outside = 8, songs_outside_mins = 3.1
  )
#> Milonga:
#> - 3.5 hrs minus 7.9 mins of slack (because of fitting tandas in time frame) = 202.1 mins
#> - 104 songs: 
#>   - 78 danced songs of 2.4 mins = 187.2 mins
#>   - 25 cortinas of 30 secs (of a 3.5 mins song) = 12.5 mins
#>   - 1 song extra for cumparsita
#> - 26 tandas of 7.7 mins, where a tanda is:
#>   - 3 danced songs of 2.4 mins = 7.2 mins
#>   - 1 cortina of 30 secs (of a 3.5 mins song)
#> - 5.2 cycles of 5 tandas:
#>   - Cycle 1: 11:00 AM
#>   - Cycle 2: 11:38 AM
#>   - Cycle 3: 12:17 PM
#>   - Cycle 4: 12:55 PM
#>   - Cycle 5: 01:34 PM
#> 
#> Outside milonga (before and after): 
#> - 8 songs = 24.8 mins
#> 
#> Playlist:
#> - 112 songs (78 danced songs, excluding cortinas)
#> - 5 hrs and 1 mins (or 301.9 mins = 99.8 mins longer than milonga)
```

That’s it!
