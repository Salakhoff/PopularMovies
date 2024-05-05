import Foundation

enum NetworkError: Error {
    case badURL
    case badData
    case badResponse
    case badRequest
    case badDecode
    case badEncode
    case unknown(String)
}
