# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  accountTypes = ->
    $('#transfer_to_account').empty()
    accounts = ['Credit']
    from_account  = $("#transfer_from_account option:not(:selected)").text()
    accounts.splice(0, 0, from_account)
    $.each accounts, (index, value) ->
      $('#transfer_to_account').append('<option value=' + value.toLowerCase() + '_balance>' + value + '</option>')
  $(document).ready(accountTypes)
  $('#transfer_from_account').on('change', accountTypes)

#  addTransferHistory = ->
#    date = $("#transfer_date_2i option:selected").text() + $("#transfer_date_3i option:selected").text() + $("#transfer_date_1i option:selected").text()
#    $('#history').append('<tr><td>' + date + '</td></tr>')
#  $("form input:submit").click(addTransferHistory)

$(document).ready(ready)
$(document).on('page:load', ready)