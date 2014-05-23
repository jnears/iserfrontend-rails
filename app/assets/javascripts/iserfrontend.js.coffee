init_page = () ->
  $("html").removeClass("no-js")
  prevent_widows()
  toggle_grid()
  build_in_page_menu()
  scroll_to_anchor()
  dimissable()
  focus_first()
  toggle_dropdown()
  activate_datetime_pickers()
  shrink_to_fit()

$(document).on 'page:change', ->
  init_page()
  $('#loading').fadeOut("fast")

$(document).on 'page:fetch', (e) ->
  $('#loading').fadeIn("fast")

$(window).on 'load', ->
  if $('img').length > 0
    $('img').baseline(27)

$(document).on 'click', '.search-toggle', (event) ->
  $(this).toggleClass('active')
  $('form[role=search]').toggle()
  $('form[role=search] input[type=search]:first').focus()
  return false

$(window).resize ->
  shrink_to_fit()

shrink_to_fit = () ->
  if $('.hero').length > 0
    $('header[role=banner]').css('border-bottom', 'none')
    $('.hero').css('height', $(window).height())

activate_datetime_pickers = () ->
  if $('.datepicker').length > 0
    $('.datepicker').datetimepicker pickTime: false, language: 'EN'
  if $('.timepicker').length > 0
    $('.timepicker').datetimepicker pickDate: false, language: 'EN', pickSeconds: false
  if $('.datetimepicker').length > 0
    $('.datetimepicker').datetimepicker language: 'EN', pickSeconds: false

build_in_page_menu = () ->
  if $('nav.guide').length == 0
    guide_nav = $("<nav />").attr("class","nav guide scrollable")
    guide_nav.append("<h5 class=\"info\">On this page</h5>")
    guide_nav.append("<li><a href=\"#top\">Top ^</a>")
    $('.section-heading').each (i, e) =>
      $(e).attr('id',$(e).text().replace(/[^A-Za-z0-9]+/g, '-').toLowerCase())
      guide_nav.append('<li><a href="#' + $(e).attr('id') + '">' + $(e).html() + '</a></li>')
    guide_nav.find("li").wrapAll("<ol />")
    guide_nav.append("<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.")
    $('aside[role=aside]').append(guide_nav)

prevent_widows = () ->
  $("h1,h2,h3,h4,h5,h6").each (i, e) =>
    if $(e).find('*').size() >= 1
      wordArray = $(e).find('*').last().text().split(/\s+/)
    else
      wordArray = $(e).text().split(/\s+/)
    wordArray = $.grep(wordArray, (n) ->
      n
    )
    if wordArray.length > 2
      wordArray[wordArray.length-2] += "&nbsp;" + wordArray.pop()
    if $(e).find('*').size() >= 1
      $(e).find('*').last().html(" " + wordArray.join(" "))
    else
      $(e).html(" " + wordArray.join(" "))

toggle_grid = () ->
  $('a#show-grid').on 'click', (event) =>
    $('html').toggleClass("grid")
    event.preventDefault()

toggle_dropdown = () ->
  $(document).on 'click', 'li.dropdown > a', (event) ->
    $('li.dropdown ol').hide()
    $(this).next().show()
    event.preventDefault()
  $(document).on 'click', 'body', (event) ->
    console.dir($(event.target).parents())
    unless $(event.target).parents().not(':has(.dropdown)')
      console.log("closing")
      $('li.dropdown ol').hide()

scroll_to_anchor = () ->
  $('.scrollable a[href^=#]').on 'click', (e) =>
    console.log($(e.target).attr('href'))
    event.preventDefault()
    $("html, body").animate({ scrollTop: $($(e.target).closest("a").attr('href')).offset().top - 27}, 400)

dimissable = () ->
  $('*[data-dismiss]').on 'click', (e) =>
    $(e.target).parent().hide()
    event.preventDefault()

focus_first = () ->
  if $('form.focus-first').length > 0
    $("form.focus-first input:not([type=hidden]), form.focus-first textarea").first().focus()

$(document).keydown (e) ->
  if e.which is 27
    $(".close").click() if $('.close').length == 1
    window.location = $(".cancel").attr('href') if $('.cancel').length > 0
  if $(window).scrollTop() < $(window).height()
    if e.which is 32
      if $('a[data-scrolldown]').length > 0
        event.preventDefault()
        $('html, body').animate({scrollTop: $('#content').offset().top - 27}, 400)
