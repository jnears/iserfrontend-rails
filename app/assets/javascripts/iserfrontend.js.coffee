#filter results based on query
filter = (selector, query) ->
  query = $.trim(query) #trim white space
  query = query.replace(RegExp(" ", "g"), "|") #add OR for regex
  $(selector).each ->
    (if ($(this).text().search(new RegExp(query, "i")) < 0) then $(this).hide().removeClass("visible") else $(this).show().addClass("visible"))
    return
  return

init_page = () ->
  # Turbolinks.enableTransitionCache()
  $("html").removeClass("no-js")
  prevent_widows()
  toggle_grid()
  build_in_page_menu()
  scroll_to_anchor()
  dimissable()
  focus_first()
  toggle_dropdown()
  toggle()
  activate_datetime_pickers()
  shrink_to_fit()
  selectable()
  dynamic_add()
  dynamic_remove()
  prevent_inline_form_submission()
  load_the_twitters()
  local_nav_toggler()
  match_component_heights()
  embed()
  handheld_nav()
  reset_handheld_nav()
  dropdown_menu()
  advanced_search()
  ie_fixes()
  ga_track_audio()
  ga_track_downloads()
  hide_facets()
  show_authors()
  if $('.tab-nav').length > 0
    tabs()

$(document).on 'page:restore', ->
  updateTwitterValues()

# $(document).on 'page:load', ->
#   unless window.location.hash
#     window.scrollTo 0, 0

$(document).on 'ready', ->
  if $('html').hasClass("lt-ie9")
    init_page()

$(document).on 'page:change', ->
  init_page()
  $('#loading').fadeOut("fast")

$(document).on 'page:fetch', (e) ->
  $('#loading').fadeIn("fast")

# $(window).on 'load', ->
#   if $('img').length > 0
#     $('img').baseline(27)

$(document).on 'click', '.search-toggle', (event) ->
  $(this).toggleClass('active')
  $('form[role=search]').toggle()
  $('form[role=search] input[type=search]:first').focus()
  event.preventDefault()

$(window).resize ->
  shrink_to_fit()

$(document).on 'click', '.toggler', (event) ->
  $(event.target).closest('li').children('ul').toggleClass('open')
  $(event.target).toggleClass('fa fa-plus-circle')
  $(event.target).toggleClass('fa fa-minus-circle')
  event.preventDefault()

match_component_heights = () ->
  if $('.components').length > 0
    $('.components').children(".span1").matchHeight false
  return

local_nav_toggler = () ->
    $('nav.local .active').closest('ul').removeClass('open').addClass('open')
    $('nav.local .active').parents().children('ul').removeClass('open').addClass('open')
  if !$('body').hasClass('euromod')
    $('nav.local ul.open').prev().removeClass('fa-minus fa-plus-circle')
    $('nav.local ul.open').prev().addClass('fa-minus-circle')

toggle = () ->
  $(".toggle").unbind('click')
  $('.toggle').on 'click', (e) ->
    $( this ).toggleClass('active')
    $(e.target).next('.toggle-panel').slideToggle(500)
    event.preventDefault()

updateTwitterValues = () ->
  if $('article.tweet').length > 0
    $('article.tweet').each (i, e) =>
      $.get "/tweet/" + $(e).attr('data-tweet-id') + ".json", (data) ->
        console.log(data.tweet)
        $(e).html(data.tweet)
        load_the_twitters()
        return
    return

load_the_twitters = () ->
  if $('*[class^="twitter-"]').length > 0
    if (typeof (twttr) == 'undefined')
      $.getScript 'https://platform.twitter.com/widgets.js', (data, textStatus, jqxhr) ->
        twttr.events.bind "loaded", (event) ->
          $('i.fa-spin').fadeOut()
          return
        return
    else
      if (typeof (twttr.widgets) != 'undefined')
        twttr.widgets.load()
        twttr.events.bind "loaded", (event) ->
          $('i.fa-spin').fadeOut()
          return
        return


prevent_inline_form_submission = () ->
  $("form.inline-search").submit ->
    event.preventDefault()

dynamic_add = () ->
  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    $(this).prev().find($('div.collapse')).removeClass('collapse').addClass('in')
    $(this).prev().find($('*[data-collapse]')).text('hide')
    event.preventDefault()

dynamic_remove = () ->
  $('form').on 'click', '.remove_fields', (event) ->
    if $(this).closest("fieldset.property").hasClass("newrecord")
      $(this).closest("fieldset.property").remove();
    else
      $(this).prev("input[type=hidden]").val("1");
      $(this).closest("fieldset.property").hide();
    event.preventDefault()

shrink_to_fit = () ->
  if $('.hero').length > 0
    $('header[role=banner]').css('border-bottom', 'none')
    $('.hero').css('height', $(window).height())
  if $('.half-hero').length > 0
    $('header[role=banner]').css('border-bottom', 'none')
    $('.half-hero').css('height', $(window).height() / 1.5 )
  if $('.third-hero').length > 0
    $('header[role=banner]').css('border-bottom', 'none')
    $('.third-hero').css('height', $(window).height() / 3 )
  if $('.main-banner').length > 0
    $('header[role=banner]').css('border-bottom', 'none')

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
    guide_nav.append("<li><a href=\"#top\">Top ^</a>")
    $('.section-heading').each (i, e) =>
      $(e).attr('id',$(e).text().replace(/[^A-Za-z0-9]+/g, '-').toLowerCase())
      guide_nav.append('<li><a href="#' + $(e).attr('id') + '">' + $(e).html() + '</a></li>')
    guide_nav.find("li").wrapAll("<ol />")
    $('aside[role=aside]').append(guide_nav)

prevent_widows = () ->
  unless getResponsive() is 'handheld'
    $("h1, h2.home-banner").each (i, e) =>
      t = $.trim($(e).justtext()).replace(/\s([^\s]*)$/,'\xa0'+'$1')
      cache = $(e).children()
      $(e).text(t).append cache
      $(e).find('*').each (i, e) =>
        t = $.trim($(e).justtext()).replace(/\s([^\s]*)$/,'\xa0'+'$1')
        cache = $(e).children()
        $(e).text(t).append cache

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
    unless $(event.target).parents().not(':has(.dropdown)')
      $('li.dropdown ol').hide()

scroll_to_anchor = () ->
  $('.scrollable a[href^=#]').on 'click', (e) =>
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
        unless $('input#sq').is(":focus")
          event.preventDefault()
          $('html, body').animate({scrollTop: $('#content').offset().top - 27}, 400)

jQuery.fn.justtext = ->
  $(this).clone().children().remove().end().text()

getResponsive = () ->
  tag = window.getComputedStyle(document.body, ":after").getPropertyValue("content")
  tag = tag.replace(/"/g, "") # Firefox bugfix
  tag

embed = () ->
  $(".embed").on 'click', (event) ->
    $( this ).toggleClass('active')
    $(this).closest('.social-toolbar').find('.embed-modal').toggle()
    $(this).closest('.social-toolbar').find('.embed-modal-text').select()
    event.preventDefault()

handheld_nav = () ->
  $("#handheld-btn").click ->
    $(this).toggleClass "active"
    if $("#handheld-btn").hasClass("closed")
      $(this).removeClass "closed"
      $(this).addClass "open"
      $("#page-wrap").animate({left:'70%'}, 200)
    else if $("#handheld-btn").hasClass("open")
      $(this).removeClass "open"
      $(this).addClass "closed"
      $("#page-wrap").animate({left:'0'}, 200)
    event.preventDefault()
    return

reset_handheld_nav = () ->
  $(window).on "resize", ->
    if $("#handheld-btn").hasClass("open") and $(window).width() > 768
      $("#handheld-btn").removeClass "open"
      $("#handheld-btn").addClass "closed"
      $("#page-wrap").animate({left:'0'}, 500)
    return

dropdown_menu = () ->
  $(".dropdown-menu-panel i.remove").remove();
  $(".dropdown-menu-toggler").on 'click', (e) ->
    $(e.target).children('.fa').toggleClass('fa-minus-circle','fa-plus-circle')
    $(e.target).closest('.fa').toggleClass('fa-minus-circle','fa-plus-circle')
    $(e.target).closest('.dropdown-menu-wrapper').find('.dropdown-menu-panel').toggle()
    e.preventDefault()

ie_fixes = () ->
  if $('html').hasClass("lt-ie9")
    svgeezy.init(false, 'png') #unless Modernizr.svg

advanced_search = () ->
  if $("#advanced-search-panel").hasClass("open")
    $("#advanced-search-panel").show()
    $("#advanced-search-panel").children('.fa').class('fa-angle-down')
    $("#advanced-search-button").css( 'margin-bottom', 0)

  $("#advanced-search-button").on 'click', (e) ->
    $(this).toggleClass "active"
    $(e.target).children('.fa').toggleClass('fa-angle-right fa-angle-down')
    $("#advanced-search-panel").toggle()
    if $(this).hasClass("active")
      $(e.target).next().find('form input[type=search]:first-of-type').focus()

ga_track_audio = () ->
  $("audio").on "play", (e) ->
    $title = $("h1").text()
    $title = $title.replace("ISER Podcast Series", " - ISER Podcast Series")
    ga "send", "event", "Podcast", e.type, $title
    return

ga_track_downloads = () ->
  $title = $("h1").text()
  $('*[data-ga-tracking="download"] a').each ->
    $(this).click (e) ->
      $linkText = $(this).text()
      $title = $title + " - " + $linkText
      $href = $(this).attr('href')
      ga "send", "event", $title, "Download", $href
      return
    return

hide_facets = () ->
  $('nav.facets ol').each ->
    $(this).find('li:gt(9)').hide()
    if $(this).children('li').length <= 10
      $(this).parent('nav.facets').parent('aside').children('.expand').hide()
    return
  $('.expand').unbind('click')
  $('.expand').click (e) ->
    $(this).parent('aside').find('nav.facets ol li:gt(9)').slideToggle()
    if $(this).text() == '+ Show more' then $(this).text('- Show less') else $(this).text('+ Show more')
    e.preventDefault()
    false


show_authors = () ->
  $('div.authors ol').each ->
    if $(this).children('li').length >= 8
      $(this).find('li:gt(3)').hide()
      $(this).parent('div').append '<a class="show-hide" href="">(more)</a>'
  $('.show-hide').unbind ('click')
  $('.show-hide').click (e) ->
    $('div.authors ol').find('li:gt(3)').toggle()
    if $(this).text() == '(more)'
      $(this).text '(less)'
    else
      $(this).text '(more)'
    e.preventDefault()
    false


tabs = () ->
  $('ul.tab-nav li:first a').addClass('active');
  $('.tab-nav li').on 'click', (e) =>
    target = $(e.target)
    target.parent().parent().next().children(".tab-panel").hide()
    target.parent().parent().find("li a").removeClass("active")
    target.addClass("active")
    $("#"+ target.attr('href').split('#')[1]).show()
    return false

selectable = () ->
  $('#selector').change ->
    $('.selectable').hide()
    $('.selected').hide()
    $('#' + $(this).val()).show()
    return