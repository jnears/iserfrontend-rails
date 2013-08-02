init_page = () ->
  $("html").removeClass("no-js")
  prevent_widows()
  toggle_grid()
  build_in_page_menu()

$(document).on 'ready page:change', ->
  init_page()
  $('#loading').hide()

$(document).on 'page:fetch', (e) ->
  $('#loading').show()

build_in_page_menu = () ->
  if $('nav.guide').length == 0
    guide_nav = $("<nav />").attr("class","nav guide")
    $('h2').each (i, element) =>
      $(element).attr('id',$(element).text().replace(/[^A-Za-z0-9]+\s+/g, '-').toLowerCase())
      guide_nav.append('<li><a href="#' + $(element).attr('id') + '">' + $(element).html() + '</a></li>')
    guide_nav.find("li").wrapAll("<ul />")
    $('aside[role=aside]').prepend(guide_nav)

prevent_widows = () ->
  $("h1,h2,h3,h4,h5,h6").each (i, element) =>
    wordArray = $(element).find('*').last().text().split(" ")
    if wordArray.length > 2
      wordArray[wordArray.length-2] += "&nbsp;" + wordArray.pop()
      $(element).find('*').last().html(" " + wordArray.join(" "))

toggle_grid = () ->
  $('a#show-grid').on 'click', (e) =>
    $('html').toggleClass("grid")
    return false
