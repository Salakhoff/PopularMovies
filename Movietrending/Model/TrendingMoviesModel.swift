import Foundation

// MARK: - TrendingMoviesModel
struct TrendingMoviesModel: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

struct Movie: Decodable {
    let backdropPath: String
    let id: Int
    let originalTitle: String?
    let overview: String
    let posterPath: String
    let mediaType: MediaType
    let adult: Bool
    let title: String?
    let name: String?
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let firstAirDate: String?
    let originCountry: [String]?
}

enum MediaType: String, Decodable {
    case movie = "movie"
    case tv = "tv"
}

enum OriginalLanguage: String, Decodable {
    case en = "en"
    case fr = "fr"
    case ja = "ja"
}
