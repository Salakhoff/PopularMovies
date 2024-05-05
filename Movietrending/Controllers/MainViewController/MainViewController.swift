import UIKit

final class MainViewController: UIViewController {
    
    // MARK: Properties
    
    /// viewModel у MainViewController
    let viewModel = MainViewModel()
    /// Массив для хранения данных, которые используюся в ячейке
    var cellDataSource: [MainMovieCellViewModel] = []
    
    // MARK: Outlets
    
    let moviesTableView = UITableView()
    private let activityIndicatorView = UIActivityIndicatorView()
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedViews()
        setupAppearance()
        setupLayout()
        setupBehaviour()
        registerCell()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.getData()
    }
    
    /// Делаем так, что View является подписчиком для ViewModel. Т.е подписываемся.
    func bindViewModel() {
        viewModel.isLoading.bind { [weak self] isLoading in
            guard let self, let isLoading else { return }
            
            DispatchQueue.main.async {
                isLoading ? self.activityIndicatorView.startAnimating() : self.activityIndicatorView.stopAnimating()
            }
        }
        
        viewModel.cellDataSource.bind { [weak self] movies in
            guard let self, let movies else { return }
            self.cellDataSource = movies
            self.reloadTableView()
        }
    }
    
    func presentDetailsViewController(movieID: Int) {
        guard let movie = viewModel.retriveMovie(with: movieID) else {
            return
        }
        
        let detailsViewModel = DetailsMovieViewModel(movie: movie)
        let detailsController = DetailsMovieViewController(viewModel: detailsViewModel)
        self.navigationController?.pushViewController(detailsController, animated: true)
    }
}

// MARK: - EmbedViews

private extension MainViewController {
    func embedViews() {
        moviesTableView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(moviesTableView)
        view.addSubview(activityIndicatorView)
        moviesTableView.separatorStyle = .none
    }
}

// MARK: - SetupAppearance

private extension MainViewController {
    func setupAppearance() {
        title = "Популярное"
        
        view.backgroundColor = .white
        
        moviesTableView.backgroundColor = .clear
    }
}

// MARK: - SetupLayout

private extension MainViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            moviesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            moviesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            moviesTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            moviesTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
