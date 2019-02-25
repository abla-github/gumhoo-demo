# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('#post_picture').on 'change', ->
    size_in_megabytes = this.files[0].size/1024/1024
    if size_in_megabytes > 3
      alert "Maximum file size is 3MB. Please choose a smaller file."
      
  $(".comment-delete").on 'click', ->
    id = $(this).attr "data-comment-id"
    deleteComment(id)
        
$(document).on 'page:change', ->
  $grid = $('.grid')
  if $grid.length
    $grid.imagesLoaded ->
      $('#spinner').addClass 'hide'
      $('.grid').removeClass 'hide'
      $grid.masonry itemSelector: '.grid-item', columnWidth: '.grid-sizer', percentPosition: true, gutter: 5

deleteComment = (id) ->
  $.ajax({
    url: "/comments/#{ id }",
    type: 'DELETE',
    success: (result) ->
      $(".comment-#{ result }").remove();
  }) if confirm("Are you sure to delete it?")