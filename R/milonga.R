#' Get milonga playlist info
#'
#' @param hrs Duration of milonga in hours.
#' @param tanda Number of songs per tanda.
#' @param cycle Number of tandas in a tanda-cycle. E.g., a TTVTTM structure means 6 tandas in a cycle.
#' @param song Average duration of songs in minutes.
#' @param cortina Average duration of cortina in seconds.
#' @param cortina_actual Average actual duration of cortina in seconds - in case you will only play part of the cortina song (e.g., 45 seconds of a 3 minutes song.
#' @param start Start time of the milonga, as an integer (e.g., 8.5 is 8:30).
#' @param AM Whether the milonga starts AM rather than PM
#' @param cumparsita_separate Is the Cumparsita an extra song separate from the last tanda?
#' @param chacarera Number of chacarera songs (not yet implemented).
#' @param songs_outside Number of songs outside of the milonga. For instance, warm-up songs before the start, or party songs after the end.
#' @param songs_outside_mins Average duration of songs outside of the milonga, in minutes.
#'
#' @return Number of songs in the playlist.
#' @export
#'
#' @examples
#' milonga() # sensible defaults
#' milonga(
#'   hrs = 5, tanda = 4,
#'   song = 2.7, cortina = 30, cortina_actual = 3.5,
#'   start = 11, AM = TRUE
#'   )
#' milonga(
#'   hrs = 3.5, tanda = 3, cycle = 5,
#'   song = 2.4, cortina = 30, cortina_actual = 3.5,
#'   start = 11, AM = TRUE,
#'   cumparsita_separate = TRUE,
#'   chacarera = 1,
#'   songs_outside = 8, songs_outside_mins = 3.1
#'   )

milonga <- function(
    hrs = 4,
    tanda = 3,
    cycle = 6,
    song = 2.5,
    cortina = 45,
    cortina_actual = cortina,
    start = 8,
    AM = FALSE,
    cumparsita_separate = FALSE,
    chacarera = 0,
    songs_outside = 0,
    songs_outside_mins = cortina_actual
) {

  # calculates for any hrs duration, tanda length, etc. how many songs your playlist can contain (e.g., Spotify shows the total nr of songs on top)
  # hrs (duration) is in hrs; tanda (length) is in nr of songs; song (durations) is in mins; and cortina (duration) is in seconds
  # with sensible default values (a milonga of 4 hours, with 3-song tandas, songs of 2.5 minutes, and cortinas of 45 seconds)

  hrs <- hrs*60 # all in mins
  cortina <- cortina/60 # all in mins
  cumparsita <- song

  tanda_mins <- tanda*song + cortina

  tandas <- (hrs - cumparsita*cumparsita_separate) %/% tanda_mins

  songs <- floor(tandas*tanda) + (tandas - 1) + cumparsita_separate # tandas - 1 because a cortina is added to every tanda except the last one

  hrs_actual <- floor(tandas*tanda)*song + (tandas - 1)*cortina + cumparsita*cumparsita_separate

  songs_mins <- floor(tandas*tanda)*song + (tandas - 1)*cortina_actual + cumparsita*cumparsita_separate

  songs_playlist <- songs + songs_outside
  songs_mins_playlist <- songs_mins + songs_outside*songs_outside_mins

  today <- as.POSIXct('2022-01-01 12:00:00 EST')
  if (AM) {
    today <- as.POSIXct('2022-01-01 00:00:00 EST')
  }
  schedulei <- today + 3600*start
  schedule <- paste0("  - Cycle 1: ", format(schedulei, format = "%I:%M %p"))
  for (i in 1:(floor(tandas/cycle)-1)) {
    schedulei <- schedulei + 60*cycle*tanda_mins
    schedule <- paste0(schedule, "\n  - Cycle " , i+1, ": ", format(schedulei, format = "%I:%M %p"))
  }

  message(

    "Milonga:",
    "\n- ", round(hrs/60, 1), " hrs minus ", round(hrs - hrs_actual, 1), " mins of slack (because of fitting tandas in time frame) = ", round(hrs_actual, 1), " mins",
    "\n- ", songs, " songs: ",
    "\n  - ", floor(tandas*tanda), " danced songs of ", round(song, 1), " mins = ", round(floor(tandas*tanda)*song, 1), " mins",
    "\n  - ", tandas - 1, " cortinas of ", round(cortina*60, 1), " secs (of a ", round(cortina_actual, 1), " mins song) = ", round((tandas - 1)*cortina, 1), " mins",
    "\n  - ", cumparsita_separate*1, " song extra for cumparsita",
    "\n- ", tandas, " tandas of ", round(tanda_mins, 1), " mins, where a tanda is:",
    "\n  - ", round(tanda, 1), " danced songs of ", round(song, 1), " mins = ", round(tanda*song, 1), " mins",
    "\n  - 1 cortina of ", round(cortina*60, 1), " secs (of a ", round(cortina_actual, 1), " mins song)",
    "\n- ", round(tandas/cycle, 1), " cycles of ", cycle, " tandas:\n",
    schedule,

    "\n\nOutside milonga (before and after): ",
    "\n- ", songs_outside, " songs = ", round(songs_outside*songs_outside_mins, 1), " mins",

    "\n\nPlaylist:",
    "\n- ", songs_playlist, " songs (", floor(tandas*tanda), " danced songs, excluding cortinas)",
    "\n- ", floor(songs_mins_playlist/60), " hrs and ", floor(((songs_mins_playlist/60)%%1)*60), " mins (or ", round(songs_mins_playlist, 1), " mins = ", round(songs_mins_playlist - hrs_actual, 1), " mins longer than milonga)"
  )

  invisible(songs_playlist)
}

