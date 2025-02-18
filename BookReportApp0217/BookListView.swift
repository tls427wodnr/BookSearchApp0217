//
//  BookListView.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/17/25.
//

import UIKit

protocol BookListViewDelegate: AnyObject {
    func loadMoreBooks()
}

class BookListView: UIView {
    weak var delegate: BookListViewDelegate? 
    private var books: [BookItem] = []
    private let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureTableView() {
        addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
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
    
    func updateBooks(_ books: [BookItem]) {
        self.books = books
        tableView.reloadData()
    }
}

extension BookListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomTableViewCell
        cell.set(imageURL: books[indexPath.row].image, title: books[indexPath.row].title, author: books[indexPath.row].author)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(books[indexPath.row].title)")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // contentOffset.y가 contentSize.height - frame.height 이상이면 스크롤이 바닥에 닿았음을 의미
        // 끝에서 더 내렸을 때 작동하려면 contentSize.height - frame.height에다 추가 거리까지 고려해야 함
        if tableView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height + 150){
            delegate?.loadMoreBooks()
        }
    }
}
