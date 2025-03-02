//
//  BookListView.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/17/25.
//

import UIKit

final class BookListView: UIView {
    
    private var bookViewModel: BookViewModel
        
    private let tableView = UITableView()

    init(frame: CGRect, viewModel: BookViewModel) {
        self.bookViewModel = viewModel
        super.init(frame: frame)
        configureTableView()
        
        bookViewModel.onBooksUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        addSubview(tableView)
        tableView.rowHeight = 100
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        tableView.backgroundColor = .systemGray6
    }
    
    func getTableView() -> UITableView {
        return tableView
    }
}



