# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# can use CoffeeScript in this file: http://coffeescript.org/
#$('.btn btn-default').click ->
# console.log @id
# return
$ ->
  $('.link').click ->
    x = $(this).attr 'data-id'
    console.log x
    $('#yes').attr("href","/tournaments/" + x)
    return
  return
