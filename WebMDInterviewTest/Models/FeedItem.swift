import Foundation

/**
 Create a model that will represent the feed item from the data.json file.
 */

struct FeedItem: Codable {
    let title, itemDescription: String
    let imageURL: String?
    let detail: String

    enum CodingKeys: String, CodingKey {
        case title
        case itemDescription = "description"
        case imageURL = "image_url"
        case detail
    }
}
