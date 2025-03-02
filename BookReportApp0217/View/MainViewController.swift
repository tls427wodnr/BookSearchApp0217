//
//  ViewController.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/17/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    private let bookViewModel = BookViewModel()
    private var bookListView: BookListView!
    private let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupBookListView()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
    }
    
    private func setupBookListView() {
        bookListView = BookListView(frame: view.bounds, viewModel: bookViewModel)
        view.addSubview(bookListView)
        bookListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bookListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookListView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        let tableView = bookListView.getTableView()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        bookViewModel.resetSearch(clearPage: true)
        bookViewModel.fetchBooks(query: searchText, start: 1)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        bookViewModel.resetSearch(clearQuery: true, clearPage: true, clearBooks: true)
        searchBar.resignFirstResponder()
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookViewModel.getBooks().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let books = bookViewModel.getBooks()
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.set(imageURL: books[indexPath.row].image, title: books[indexPath.row].title, author: books[indexPath.row].author)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let books = bookViewModel.getBooks()
        let detailVC = DetailViewController()
        detailVC.detailViewModel = DetailViewModel(bookItem: books[indexPath.row])
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableView = bookListView.getTableView()
        if tableView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 150){
            bookViewModel.loadMoreBooks()
        }
    }
}
