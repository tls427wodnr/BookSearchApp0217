//
//  ViewController.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/17/25.
//

import UIKit

class ViewController: UIViewController {
    
    private var myBooks: [BookItem] = []
    private let bookListView = BookListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        setupBookListView()
        fetchBooks(query: "코딩")
    }
    
    private func setupBookListView() {
        view.addSubview(bookListView)
        bookListView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bookListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bookListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bookListView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bookListView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func fetchBooks(query: String) {
        BookAPIManager.shared.fetchBooksAPI(query: query) { [weak self] books in
            guard let self = self, let books = books else { return }
            
            DispatchQueue.main.async {
                self.myBooks = books
                self.bookListView.updateBooks(books)
            }
        }
    }
}

