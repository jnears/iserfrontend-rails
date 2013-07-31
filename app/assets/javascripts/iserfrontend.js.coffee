$('a#show-grid').on 'click', (e) =>
  $('html').toggleClass("grid")
  return false;

prevent_widows = () ->
  $("h1,h2,h3,h4,h5,h6").each (i, element) =>
    wordArray = $(element).find('*').last().text().split(" ")
    if wordArray.length > 2
      wordArray[wordArray.length-2] += "&nbsp;" + wordArray.pop()
      $(element).find('*').last().html(" " + wordArray.join(" "))

init_page = () ->
  $("html").removeClass("no-js")
  prevent_widows()

$(document).on 'ready page:change', ->
  init_page()
  $('#loading').hide()

$(document).on 'page:fetch', (e) ->
  $('#loading').show()
