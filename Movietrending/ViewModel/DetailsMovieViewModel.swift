import Foundation

final class DetailsMovieViewModel {
    var movieID: Int
    var movieImage: URL?
    var movieTitle: String
    var movieDescription: String
    
    init(movie: Movie) {
        self.movieID = movie.id
        self.movieTitle = movie.name ?? movie.title ?? ""
        self.movieDescription = movie.overview
        self.movieImage = makeImageURL(movie.backdropPath)
    }
    
    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstants.shared.imageServer)\(imageCode)")
    }
}
