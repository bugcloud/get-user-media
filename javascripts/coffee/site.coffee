# setup cross browser functions
window.URL = window.URL || window.webkitURL
navigator.getUserMedia =
  navigator.getUserMedia ||
  navigator.webkitGetUserMedia ||
  navigator.mozGetUserMedia ||
  navigator.msGetUserMedia

_site = {}
_site.video = document.querySelector('video')
_site.getUserMediaCallback = (stream) ->
  _site.video.src = window.URL.createObjectURL(stream)
_site.setVideoFilter = (effectName, effectValue) ->
  $video = $(_site.video)
  filters = ['-webkit-filter', '-moz-filter', '-o-filter', '-ms-filter', 'filter']
  currentFilters = null
  for filter in filters
    if $video.css(filter) isnt 'none'
      currentFilters = $video.css filter
      break
  regExp = new RegExp("#{effectName}\\([\-0-9a-zA-Z\.]+\\)")
  filterValue = currentFilters.replace(regExp, "#{effectName}(#{effectValue})")

  console?.log filterValue

  $video.css
    '-webkit-filter': filterValue
    '-moz-filter': filterValue
    '-o-filter': filterValue
    '-ms-filter': filterValue
    'filter': filterValue

_site.getUserMediaFallBack = (e) ->
  alert "Your browser dosen't support 'navigator.getUserMedia'"
  console?.log e

unless navigator.getUserMedia
  _site.getUserMediaFallBack()
else
  navigator.getUserMedia {audio: true, video: true}, _site.getUserMediaCallback, _site.getUserMediaFallBack

$ ->
  $("#range-for-brightness").change () ->
    _site.setVideoFilter "brightness", $(this).val()
  $("#range-for-blur").change () ->
    _site.setVideoFilter "blur", "#{$(this).val()}px"
  $("#range-for-saturate").change () ->
    _site.setVideoFilter "saturate", "#{$(this).val()}"
  $("#range-for-hue-rotate").change () ->
    _site.setVideoFilter "hue-rotate", "#{$(this).val()}deg"
  $("#range-for-contrast").change () ->
    _site.setVideoFilter "contrast", "#{$(this).val()}%"
  $("#range-for-invert").change () ->
    _site.setVideoFilter "invert", "#{$(this).val()}%"
  $("#range-for-grayscale").change () ->
    _site.setVideoFilter "grayscale", "#{$(this).val()}%"
  $("#range-for-sepia").change () ->
    _site.setVideoFilter "sepia", "#{$(this).val()}%"
