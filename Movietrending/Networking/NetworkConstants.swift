import Foundation

final class NetworkConstants {
    
    static let shared = NetworkConstants()
    
    private init() {}
    
    var accesToken: String {
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1Y2E4ZDdlYTI2NzY2ZDk3MDUwNWQxZDgyZjRkNTI4YiIsInN1YiI6IjY2MzM0MDU3ODNlZTY3MDEyNDQwNWE0NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.RdSGq9mYCY0_ldajVIa5DmYBewyXbDplRCiECi7XoO8"
    }
    
    var server: String {
        "https://api.themoviedb.org/3"
    }
    
    var imageServer: String {
        "https://image.tmdb.org/t/p/w500/"
    }
}
