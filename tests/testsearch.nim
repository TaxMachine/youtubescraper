# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import youtube_scraper

suite "youtube_scraper":
  test "getVideos":
    var vids = getVideos("nim programming language")
    check vids.len > 0

  test "getVideos with options":
    var vids = getVideos("nim programming language", SearchOptions.soUploadDate)
    check vids.len > 0

  test "getVideo":
    var vid = getVideoInfo("IONW4WEaOCM")
    check vid.title == "fbft lag exploit"

  test "getChannel":
    var channel = getChannelInfo("@taxmachine5264")
    check channel.name == "TaxMachine"

  test "getChannelVideos":
    var channelvids = getChannelVideos("@taxmachine5264")
    check channelvids.len > 0