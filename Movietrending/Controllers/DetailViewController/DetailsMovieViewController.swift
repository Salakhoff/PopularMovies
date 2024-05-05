import UIKit
import SDWebImage

final class DetailsMovieViewController: UIViewController {
    
    // MARK: Outlets
    
    private let movieImageView = UIImageView()
    private var movieTitleLabel = UILabel()
    private let movieDescriptionLabel = UILabel()
    private let stackView = UIStackView()
    
    // MARK: Properties
    
    var viewModel: DetailsMovieViewModel
    
    // MARK: Init
    
    init(viewModel: DetailsMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        embedViews()
        setupAppearance()
        setupLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async {
            self.configure()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        movieImageView.image = nil
    }
    
    private func configure() {
        self.title = "Информация о фильме"
        
        movieTitleLabel.text = viewModel.movieTitle
        movieDescriptionLabel.text = viewModel.movieDescription
        movieImageView.sd_setImage(with: viewModel.movieImage)
    }
}

// MARK: - EmbedViews

private extension DetailsMovieViewController {
    func embedViews() {
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(movieTitleLabel)
        stackView.addArrangedSubview(movieDescriptionLabel)
        view.addSubview(movieImageView)
        view.addSubview(stackView)
    }
}

// MARK: - SetupAppearance

private extension DetailsMovieViewController {
    func setupAppearance() {
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        movieImageView.contentMode = .scaleAspectFill
        
        movieTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        movieDescriptionLabel.font = UIFont.systemFont(ofSize: 15)
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        
        movieTitleLabel.numberOfLines = 0
        movieDescriptionLabel.numberOfLines = 0
        
        movieTitleLabel.textAlignment = .center
        movieDescriptionLabel.textAlignment = .center
    }
}

// MARK: - SetupLayout

private extension DetailsMovieViewController {
    func setupLayout() {
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            
            stackView.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: movieImageView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: -10),
        ])
    }
}
