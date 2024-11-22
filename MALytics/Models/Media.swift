import Foundation

struct Media: Decodable, Hashable {
    enum CodingKeys: String, CodingKey {
        case id, title, genres, recommendations, status, studios, rank, popularity
        case images = "main_picture"
        case mediaType = "media_type"
        case description = "synopsis"
        case rating = "mean"
        case episodes = "num_episodes"
        case startDate = "start_date"
        case endDate = "end_date"
        case relatedAnimes = "related_anime"
        case moreImages = "pictures"
    }
    
    let id: Int
    let title: String
    let images: Images
    let description: String?
    let rating: Double?
    let mediaType: String?
    let status: String?
    let episodes: Int?
    let genres: [Genre]?
    let startDate: String?
    let endDate: String?
    let recommendations: [MediaNode]?
    let studios: [Studio]?
    let relatedAnimes: [MediaNode]?
    let rank: Int?
    let popularity: Int?
    let moreImages: [Images]?
    
    init(id: Int, title: String, images: Images, description: String? = nil, rating: Double? = nil, status: String? = nil, genres: [Genre]? = nil, recommendations: [MediaNode]? = nil, startDate: String? = nil, endDate: String? = nil, mediaType: String? = nil, episodes: Int? = nil, studios: [Studio]? = nil, relatedAnimes: [MediaNode]? = nil, rank: Int? = nil, popularity: Int? = nil, moreImages: [Images]? = nil) {
        self.id = id
        self.title = title
        self.images = images
        self.description = description
        self.rating = rating
        self.status = status
        self.genres = genres
        self.recommendations = recommendations
        self.startDate = startDate
        self.endDate = endDate
        self.mediaType = mediaType
        self.episodes = episodes
        self.studios = studios
        self.relatedAnimes = relatedAnimes
        self.rank = rank
        self.popularity = popularity
        self.moreImages = moreImages
    }
}
