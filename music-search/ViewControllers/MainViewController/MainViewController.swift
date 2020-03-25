import UIKit
import Foundation
import AwaitKit

class MainViewController: UIViewController {
    
    private let contentView = MainView()
    private let viewModel = MusicListModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Let's find some music"
        contentView.musicTableView.register(MusicTableViewCell.self, forCellReuseIdentifier: MusicTableViewCell.identifier)
        contentView.musicTableView.delegate = self
        contentView.musicTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "iTunes search"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        _ = self.viewModel.searchResultList.asObservable().bind { musicList in
            DispatchQueue.main.async {
                self.contentView.musicTableView.reloadData()
            }
        }
    }
    
    func searchMusicForSearchText(searchText: String) {
        if isFiltering {
            async {
                try? await(self.viewModel.loadResults(query: searchText))
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchResultList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell") as! MusicTableViewCell
        let musicItem = viewModel.searchResultList.value[indexPath.row]
        cell.setup(musicItem: musicItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}

extension MainViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        searchMusicForSearchText(searchText: searchBar.text!)
    }
}
