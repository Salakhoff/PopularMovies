import Foundation

final class MainViewModel {
    
    /// Элемент для подписки (статус Loading)
    var isLoading: Observable<Bool> = Observable(false)
    /// Элемент для подписки. (Массив Movie)
    var cellDataSource: Observable<[MainMovieCellViewModel]> = Observable(nil)
    /// Что мы получили с бека
    var dataSource: TrendingMoviesModel?
    
    private let networkService: NetworkProtocol = NetworkService()
    
    func numberOfSection() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        self.dataSource?.results.count ?? 0
    }
    
    func getData() {
        isLoading.value = true
        let urlString = NetworkConstants.shared.server + "/trending/all/week?language=ru-RU"
        networkService.fetchData(
            urlString: urlString,
            headers: ["Authorization": "Bearer \(NetworkConstants.shared.accesToken)"]) { 
                [weak self] (result: Result<TrendingMoviesModel, NetworkError>) in
                guard let self else { return }
                self.isLoading.value = false
                switch result {
                case .success(let data):
                    self.dataSource = data
                    mapCellData()
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
    }
    
    /// Передаем наблюдателю, что проищошли изменения
    func mapCellData() {
        self.cellDataSource.value = self.dataSource?.results.compactMap( { MainMovieCellViewModel(movie: $0) } )
    }
    
    /// Метод возвращает корректное наименование фильма. Может быть такое, что title нет, а name есть
    /// - Parameter movie: Структура, которая получена с бека
    /// - Returns: Какое-то значение с бека
    func getMovieTitle(_ movie: Movie) -> String {
        movie.title ?? movie.name ?? ""
    }
    
    func retriveMovie(with id: Int) -> Movie? {
        guard let movie = dataSource?.results.first(where: { $0.id == id }) else {
            return nil
        }
        
        return movie
    }
}
