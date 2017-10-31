$ ->
  wrapper = $('#js-player-wrapper')
  player = wrapper.find('#js-player')
  now_playing = wrapper.find('.now-playing')
  listeners = wrapper.find('.listeners')
  bitrate = wrapper.find('.bitrate')

  updateMetaData = ->
    url = 'http://localhost:35689/json.xsl'
    mount = '/stream'

    $.ajax
      type: 'GET'
      url: url
      async: true
      jsonpCallback: 'parseMusic'
      contentType: "application/json"
      dataType: 'jsonp'
      success: (data) ->
        mount_stat = data[mount]
        now_playing.text mount_stat.title
        listeners.text mount_stat.listeners
        bitrate.text mount_stat.bitrate
      error: (e) -> console.error(e)

  player.append '<source src="http://localhost:35689/stream">'
  player.get(0).play()
  setInterval updateMetaData, 5000
