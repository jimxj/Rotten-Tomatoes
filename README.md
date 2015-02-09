
## Rotten Tomatoes

This is a movies app displaying box office and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: 13 hours

### Features

#### Required

- [ ] User can view a list of movies. Poster images load asynchronously.
- [ ] User can view movie details by tapping on a cell.
- [ ] User sees loading state while waiting for the API.
- [ ] User sees error message when there is a network error: http://cl.ly/image/1l1L3M460c3C
- [ ] User can pull to refresh the movie list.

#### Optional

- [ ] For the larger poster, load the low-res first and switch to high-res when complete.
- [ ] All images should be cached in memory and disk.
- [ ] Add a tab bar for Box Office and DVD.
- [ ] Add a search bar: pretty simple implementation of searching against the existing table view data.
- [ ] Wipe left/right in detail view to navigate to previous/next movie

### Walkthrough
![Demo](demo.gif)

Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
