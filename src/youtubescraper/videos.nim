import
  std/[strutils, httpclient, json, uri],
  constants

proc fetchVids(url: string): JsonNode =
  let
    client = newHttpClient()
    response = client.request(url, HttpGet)
    data = response.body
    startstring = "var ytInitialData = "
    endstring = ";</script>"
    start = data.find(startstring)
    endpos = data.find(endstring, start)
    json = data.substr(start + startstring.len, endpos - 1)
  return json.parseJson()

proc getViews(view: string): int =
  return if match(view, re"\d"): replace(view, re"\D", "").parseInt else: 0

proc getSubscribers(subs: string): int =
  return if match(subs, re"\d"): replace(subs, re"\D", "").parseInt else: 0

proc getVideos*(url: string): seq[Video] =
  let
    videos = fetchVids(SEARCH_URL & encodeUrl(url))["contents"]["twoColumnSearchResultsRenderer"]["primaryContents"]["sectionListRenderer"]["contents"][0]["itemSectionRenderer"]["contents"]
  for video in videos.getElems():
    try:
      var vid = video["videoRenderer"]
      result.add(
        Video(
          title: vid["title"]["runs"][0]["text"].getStr(),
          url: VIDEO_URL & vid["videoId"].getStr(),
          videoId: vid["videoId"].getStr(),
          duration: vid["lengthText"]["simpleText"].getStr(),
          views: getViews(vid["viewCountText"]["simpleText"].getStr()),
          channel: vid["ownerText"]["runs"][0]["text"].getStr(),
          channelUrl: CHANNEL_URL & vid["ownerText"]["runs"][0]["navigationEndpoint"]["commandMetadata"]["webCommandMetadata"]["url"].getStr(),
          uploadDate: vid["publishedTimeText"]["simpleText"].getStr(),
          thumbnail: vid["thumbnail"]["thumbnails"][0]["url"].getStr()
        )
      )
    except:
      discard

proc getVideos*(url: string, options: SearchOptions): seq[Video] =
  let
    videos = fetchVids(SEARCH_URL & encodeUrl(url) & VideoOptions[(int)options])["contents"]["twoColumnSearchResultsRenderer"]["primaryContents"]["sectionListRenderer"]["contents"][0]["itemSectionRenderer"]["contents"]
  for video in videos.getElems():
    try:
      var vid = video["videoRenderer"]
      result.add(
        Video(
          title: vid["title"]["runs"][0]["text"].getStr(),
          url: VIDEO_URL & vid["videoId"].getStr(),
          videoId: vid["videoId"].getStr(),
          duration: vid["lengthText"]["simpleText"].getStr(),
          views: getViews(vid["viewCountText"]["simpleText"].getStr()),
          channel: vid["ownerText"]["runs"][0]["text"].getStr(),
          channelUrl: CHANNEL_URL & vid["ownerText"]["runs"][0]["navigationEndpoint"]["commandMetadata"]["webCommandMetadata"]["url"].getStr(),
          uploadDate: vid["publishedTimeText"]["simpleText"].getStr(),
          thumbnail: vid["thumbnail"]["thumbnails"][0]["url"].getStr()
        )
      )
    except:
      discard

proc getVideoInfo*(videoId: string): Video =
  let
    vid = fetchVids(VIDEO_URL & videoId)["engagementPanels"][1]["engagementPanelSectionListRenderer"]["content"]["structuredDescriptionContentRenderer"]["items"]
  try:
    result = Video(
      title: vid[0]["videoDescriptionHeaderRenderer"]["title"]["runs"][0]["text"].getStr(),
      url: VIDEO_URL & videoId,
      views: getViews(vid[0]["videoDescriptionHeaderRenderer"]["views"]["simpleText"].getStr()),
      channel: vid[0]["videoDescriptionHeaderRenderer"]["channel"]["simpleText"].getStr(),
      channelUrl: CHANNEL_URL & vid[0]["videoDescriptionHeaderRenderer"]["channelNavigationEndpoint"]["commandMetadata"]["webCommandMetadata"]["url"].getStr(),
      uploadDate: vid[0]["videoDescriptionHeaderRenderer"]["publishDate"]["simpleText"].getStr(),
      thumbnail: vid[0]["videoDescriptionHeaderRenderer"]["channelThumbnail"]["thumbnails"][0]["url"].getStr(),
      description: vid[1]["expandableVideoDescriptionBodyRenderer"]["attributedDescriptionBodyText"]["content"].getStr()
    )
  except Exception:
    discard

proc getChannelVideos*(channelId: string): seq[Video] =
  let
    videos = fetchVids(CHANNEL_URL & "/" & channelId & "/videos")
  for video in videos["contents"]["twoColumnBrowseResultsRenderer"]["tabs"][1]["tabRenderer"]["content"]["richGridRenderer"]["contents"].getElems():
    try:
      var vid = video["richItemRenderer"]["content"]["videoRenderer"]
      result.add(
        Video(
          title: vid["title"]["runs"][0]["text"].getStr(),
          url: VIDEO_URL & vid["videoId"].getStr(),
          duration: vid["lengthText"]["simpleText"].getStr(),
          views: getViews(vid["viewCountText"]["simpleText"].getStr()),
          channel: videos["header"]["c4TabbedHeaderRenderer"]["title"].getStr(),
          channelUrl: CHANNEL_URL & "/" & channelId,
          uploadDate: vid["publishedTimeText"]["simpleText"].getStr(),
          thumbnail: vid["thumbnail"]["thumbnails"][0]["url"].getStr()
        )
      )
    except:
      discard

proc getChannelInfo*(channelId: string): constants.Channel =
  let
    channel = fetchVids(CHANNEL_URL & "/" & channelId)
  result = constants.Channel(
    name: channel["header"]["c4TabbedHeaderRenderer"]["title"].getStr(),
    channelId: channel["metadata"]["channelMetadataRenderer"]["externalId"].getStr(),
    subscribers: getSubscribers(channel["header"]["c4TabbedHeaderRenderer"]["subscriberCountText"]["simpleText"].getStr()),
    avatar: channel["header"]["c4TabbedHeaderRenderer"]["avatar"]["thumbnails"][0]["url"].getStr(),
    banner: channel["header"]["c4TabbedHeaderRenderer"]["banner"]["thumbnails"][0]["url"].getStr(),
    description: channel["metadata"]["channelMetadataRenderer"]["description"].getStr(),
    videos: getChannelVideos(channelId)
  )
