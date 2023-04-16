const
    USERAGENT* = "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)"
    SEARCH_URL* = "https://www.youtube.com/results?search_query="
    VIDEO_URL* = "https://www.youtube.com/watch?v="
    CHANNEL_URL* = "https://www.youtube.com"
    
    VideoOptions*: seq[string] = @[
        "&sp=CAI%253D",
        "&sp=CAASAhAB",
        "&sp=CAMSAhAB",
        "&sp=CAESAhAB"
    ]
    
type
    SearchOptions* = enum
        soUploadDate = 0, soRelevance, soViewCount, soRating

    Video* = object
        title*: string
        url*: string
        description*: string
        duration*: string
        views*: int
        uploadDate*: string
        channel*: string
        thumbnail*: string
        channelUrl*: string

    Channel* = object
        name*: string
        channelId*: string
        subscribers*: int
        videos*: seq[Video]
        description*: string
        banner*: string
        avatar*: string
