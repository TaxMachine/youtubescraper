# Youtube Scraper

This is a Nim project that provides methods for interacting with YouTube videos and channels. The project includes types such as SearchOptions, Video, and Channel for representing search options, video information, and channel information respectively.

## Todo

- [ ] Add support for retrieving video comments
- [ ] Add support for retrieving channel playlists
- [ ] Add support for retrieving shorts
- [ ] Add support for retrieving live streams

## Installation

To use this project, you need to have Nim installed on your system. You can install Nim by following the instructions on the official Nim [website](https://nim-lang.org/install.htm)

Once Nim is installed, you can install this project using Nimble, the Nim package manager, by running the following command:

```bash
nimble install youtubescraper
```

## Usage

Here are some examples of how to use the methods provided by this project:

### Method: getVideos(keyword: string): seq[Video]

This method searches for videos on YouTube based on a given keyword and returns a sequence of Video objects representing the search results.

```nim
import youtubescraper

# Search for videos with the keyword "example"
let keyword = "example"
let videos = getVideos(keyword)
for video in videos:
    echo "Title: ", video.title
    echo "URL: ", video.url
    echo "Description: ", video.description
    echo "Duration: ", video.duration
    echo "Views: ", video.views
    echo "Upload Date: ", video.uploadDate
    echo "Channel: ", video.channel
    echo "Thumbnail: ", video.thumbnail
    echo "Channel URL: ", video.channelUrl
    echo ""
```

### Method: getVideos(keyword: string, options: SearchOptions): seq[Video]

This method searches for videos on YouTube based on a given keyword and search options, and returns a sequence of Video objects representing the search results. The SearchOptions parameter allows you to specify the sorting order of the search results.

```nim
import youtubescraper

# Search for videos with the keyword "example" sorted by view count
let keyword = "example"
let options = SearchOptions.soViewCount
let videos = getVideos(keyword, options)
for video in videos:
    echo "Title: ", video.title
    echo "URL: ", video.url
    echo "Description: ", video.description
    echo "Duration: ", video.duration
    echo "Views: ", video.views
    echo "Upload Date: ", video.uploadDate
    echo "Channel: ", video.channel
    echo "Thumbnail: ", video.thumbnail
    echo "Channel URL: ", video.channelUrl
    echo ""
```

### Method: getVideoInfo(videoId: string): Video

This method retrieves information about a specific YouTube video based on its video ID, and returns a Video object representing the video information.

```nim
import youtubescraper

# Get information about a specific video with the video ID "1234567890"
let videoId = "1234567890"
let video = getVideoInfo(videoId)
echo "Title: ", video.title
echo "URL: ", video.url
echo "Description: ", video.description
echo "Duration: ", video.duration
echo "Views: ", video.views
echo "Upload Date: ", video.uploadDate
echo "Channel: ", video.channel
echo "Thumbnail: ", video.thumbnail
echo "Channel URL: ", video.channelUrl
echo ""
```

### Method: getChannelVideos(channelId: string): seq[Video]

This method retrieves the videos uploaded by a specific YouTube channel based on its channel ID, and returns a sequence of Video objects representing the channel's videos.

```nim
import youtubescraper

# Get videos uploaded by a specific channel with the channel ID "abcdefghijklmno"
let channelId = "abcdefghijklmno"
let videos = getChannelVideos(channelId)
for video in videos:
echo "Title: ", video.title
echo "URL: ", video.url
echo "Description: ", video.description
echo "Duration: ", video.duration
echo "Views: ", video.views
echo "Upload Date: ", video.uploadDate
echo "Channel: ", video.channel
echo "Thumbnail: ", video.thumbnail
echo "Channel URL: ", video.channelUrl
echo ""
```

### Method: `getChannelInfo(channelId: string): Channel`

This method retrieves information about a specific YouTube channel based on its channel ID, and returns a `Channel` object representing the channel information.

```nim
import youtubescraper

# Get information about a specific channel with the channel ID "abcdefghijklmno"
let channelId = "abcdefghijklmno"
let channel = getChannelInfo(channelId)
echo "Name: ", channel.name
echo "Channel ID: ", channel.channelId
echo "Subscribers: ", channel.subscribers
echo "Description: ", channel.description
echo "Banner: ", channel.banner
echo "Avatar: ", channel.avatar
```
