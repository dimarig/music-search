import Foundation

struct MusicItemDTO: Codable {
    var artistName: String
    var collectionName: String
    var trackName: String
    var artworkUrl100: String?
    var trackExplicitness: String
    
    enum CodingKeys: String, CodingKey {
        case artistName = "artistName"
        case collectionName = "collectionName"
        case trackName = "trackName"
        case artworkUrl100 = "artworkUrl100"
        case trackExplicitness = "trackExplicitness"
    }
}
