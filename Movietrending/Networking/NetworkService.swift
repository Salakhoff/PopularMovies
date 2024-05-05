import Foundation

protocol NetworkProtocol {
    func fetchData<T: Decodable>(
        urlString: String,
        headers: [String: String]?,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

final class NetworkService: NetworkProtocol {
    
    private let decoder = JSONDecoder()
    
    private var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 250
        return URLSession(configuration: configuration)
    }
    
    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchData<T: Decodable>(
        urlString: String,
        headers: [String: String]?,
        completion: @escaping (Result<T,  NetworkError>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(.badURL))
        }
        
        var request = URLRequest(url: url)
        
        headers?.forEach{ key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        session.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                return completion(.failure(.badRequest))
            }
            
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.badResponse))
            }
            
            switch  response.statusCode {
            case 200...299:
                do {
                    let decodedData = try self.decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch let error {
                    print(error.localizedDescription)
                    completion(.failure(.badDecode))
                }
            case 400:
                completion(.failure(.badRequest))
            default:
                completion(.failure(.unknown("Нужно глянуть точнее что и как")))
            }
        }.resume()
    }
}
