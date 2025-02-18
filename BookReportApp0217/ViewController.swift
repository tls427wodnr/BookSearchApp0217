//
//  ViewController.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/17/25.
//

import UIKit

class ViewController: UIViewController, BookListViewDelegate {
    
    private var myBooks: [BookItem] = []
    private let bookListView = BookListView()
    private let searchController = UISearchController(searchResultsController: nil)
    private var currentPage = 1
    private var currentQuery: String = ""
    private var isLoading = false
    
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
        view.addSubview(bookListView)
        bookListView.delegate = self
        bookListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bookListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookListView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchBooks(query: String, start: Int) {
        guard !isLoading else { return }
        isLoading = true
        currentQuery = query
        BookAPIManager.shared.fetchBooksAPI(query: query, start: start) { [weak self] books in
            guard let self = self, let books = books else {
                self?.isLoading = false
                return
            }
            
            DispatchQueue.main.async {
                if start == 1 {
                    self.myBooks = books
                } else {
                    self.myBooks.append(contentsOf: books)
                }
                self.bookListView.updateBooks(self.myBooks)
                self.isLoading = false
            }
        }
    }
    
    func loadMoreBooks() {
        guard !isLoading else { return }
        currentPage += 1
        fetchBooks(query: currentQuery, start: 1 + (currentPage - 1) * 30)
     }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        fetchBooks(query: searchText, start: 1)
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.myBooks.removeAll()
        self.currentQuery = ""
        self.currentPage = 1
        self.bookListView.updateBooks([])
        searchBar.resignFirstResponder()
    }
}
