import Foundation

struct MusicListDTO: Codable {
    var resultCount: Int
    var items: [MusicItemDTO]
    
    enum CodingKeys: String, CodingKey {
        case resultCount = "resultCount"
        case items = "results"
    }
}
