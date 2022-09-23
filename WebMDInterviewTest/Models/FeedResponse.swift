import Foundation

/**
 Create a model that will represent the top-level structure of the data.json file (i.e will hold the list of feed items).
 */

struct FeedResponse: Codable {
    let items: [FeedItem]
}
