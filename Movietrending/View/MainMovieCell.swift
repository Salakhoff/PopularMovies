import UIKit
import SDWebImage

final class MainMovieCell: UITableViewCell {
    
    static var identifier: String {
        "MainMovieCell"
    }
    
    // MARK: Outlets
    
    private let backgroundMovieView = UIView()
    private let movieImageView = UIImageView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let movieRatingLabel = UILabel()
    private let labelsStackView = UIStackView()
    
    // MARK: Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        embedViews()
        setupAppearance()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.descriptionLabel.text = ""
        self.movieRatingLabel.text = ""
        self.movieImageView.image = nil
    }
    
    func configure(viewModel: MainMovieCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.descrition
        self.movieRatingLabel.text = viewModel.rating
        self.movieImageView.sd_setImage(with: viewModel.imageURL)
    }
}

// MARK: - EmbedViews

private extension MainMovieCell {
    func embedViews() {
        backgroundMovieView.translatesAutoresizingMaskIntoConstraints = false
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieRatingLabel.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundMovieView.addSubview(movieImageView)
        backgroundMovieView.addSubview(labelsStackView)
        backgroundMovieView.addSubview(movieRatingLabel)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(descriptionLabel)
        
        contentView.addSubview(backgroundMovieView)
    }
}

// MARK: - SetupAppearance

private extension MainMovieCell {
    func setupAppearance() {
        backgroundMovieView.backgroundColor = .systemGray5
        backgroundMovieView.layer.cornerRadius = 10
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.layer.cornerRadius = 10
        movieImageView.clipsToBounds = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        descriptionLabel.font = UIFont.systemFont(ofSize: 15)
        
        descriptionLabel.numberOfLines = 5
        titleLabel.numberOfLines = 0
        
        movieRatingLabel.font = UIFont.systemFont(ofSize: 13)
        movieRatingLabel.textAlignment = .right
        
        labelsStackView.axis = .vertical
        labelsStackView.distribution = .equalSpacing
    }
}

// MARK: - SetupLayout

private extension MainMovieCell {
    func setupLayout() {
        NSLayoutConstraint.activate([
            backgroundMovieView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundMovieView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundMovieView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backgroundMovieView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            backgroundMovieView.heightAnchor.constraint(equalToConstant: 150),
            
            movieImageView.topAnchor.constraint(equalTo: backgroundMovieView.topAnchor, constant: 3),
            movieImageView.leadingAnchor.constraint(equalTo: backgroundMovieView.leadingAnchor, constant: 3),
            movieImageView.bottomAnchor.constraint(equalTo: backgroundMovieView.bottomAnchor, constant: -3),
            movieImageView.widthAnchor.constraint(equalTo: movieImageView.heightAnchor, multiplier: 0.7),
            
            labelsStackView.topAnchor.constraint(equalTo: backgroundMovieView.topAnchor, constant: 3),
            labelsStackView.trailingAnchor.constraint(equalTo: backgroundMovieView.trailingAnchor, constant: -5),
            labelsStackView.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 10),
            labelsStackView.bottomAnchor.constraint(equalTo: movieRatingLabel.topAnchor),
            
            movieRatingLabel.trailingAnchor.constraint(equalTo: backgroundMovieView.trailingAnchor, constant: -10),
            movieRatingLabel.leadingAnchor.constraint(equalTo: backgroundMovieView.leadingAnchor, constant: 3),
            movieRatingLabel.bottomAnchor.constraint(equalTo: backgroundMovieView.bottomAnchor, constant: -3)
        ])
    }
}

