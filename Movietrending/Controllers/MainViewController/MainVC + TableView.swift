import UIKit

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MainMovieCell.identifier,
            for: indexPath
        )as? MainMovieCell else {
            return UITableViewCell()
        }
        
        cell.configure(viewModel: cellDataSource[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.numberOfSection()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true )
        
        let movieID = cellDataSource[indexPath.row].id
        DispatchQueue.main.async {
            self.presentDetailsViewController(movieID: movieID)
        }
    }
}

// MARK: - SetupBehaviour

extension MainViewController {
    /// Устанавливаются делегаты
    func setupBehaviour() {
        moviesTableView.dataSource = self
        moviesTableView.delegate = self
    }
}

// MARK: - RegisterCell

extension MainViewController {
    /// Регистрация ячейки
    func registerCell() {
        moviesTableView.register(
            MainMovieCell.self,
            forCellReuseIdentifier: MainMovieCell.identifier
        )
    }
}

extension MainViewController {
    /// Обновляет таблицу
    func reloadTableView() {
        DispatchQueue.main.async {
            self.moviesTableView.reloadData()
        }
    }
}

