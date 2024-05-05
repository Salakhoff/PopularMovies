import Foundation

final class MainMovieCellViewModel {
    var id: Int
    var title: String
    var descrition: String
    var rating: String
    var imageURL: URL?
    
    init(movie: Movie) {
        self.id = movie.id
        self.title = movie.title ?? movie.name ?? ""
        self.descrition = movie.overview
        self.rating = "\(movie.voteAverage.roundToTenths())/10"
        self.imageURL = makeImageURL(movie.posterPath)
    }
    
    private func makeImageURL(_ imageCode: String) -> URL? {
        URL(string: "\(NetworkConstants.shared.imageServer)\(imageCode)")
    }
}
