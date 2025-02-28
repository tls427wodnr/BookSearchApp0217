//
//  BookViewModel.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/28/25.
//

import Foundation

class BookViewModel {
    var onBooksUpdated: (() -> Void)?
    
    var currentPage = 1
    var currentQuery: String = ""
    private var isLoading = false
    
    private var books: [BookItem] = [] {
        didSet {
            onBooksUpdated?()
        }
    }
    
    func getBooks() -> [BookItem] {
        return books
    }
    
    func addBooks(books: [BookItem]) {
        self.books.append(contentsOf: books)
    }
    
    func setBooks(books: [BookItem]) {
        self.books = books
    }
    
    func clearBooks() {
        self.books = []
    }
    
    func fetchBooks(query: String, start: Int) {
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
                    self.setBooks(books: books)
                } else {
                    self.addBooks(books: books)
                }
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
