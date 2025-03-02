//
//  CustomTableViewCell.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/18/25.
//

import UIKit

final class CustomTableViewCell: UITableViewCell {
    var bookImage = UIImageView()
    var bookTitle = UILabel()
    var bookAuthor = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(bookImage)
        addSubview(bookTitle)
        addSubview(bookAuthor)
        
        configureBookImage()
        configureBookTitle()
        configureBookAuthor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(imageURL: String, title: String, author: String) {
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.bookImage.image = image
                    }
                }
            }.resume()
        }
        bookTitle.text = title
        bookAuthor.text = author
    }
    
    private func configureBookImage() {
        bookImage.layer.cornerRadius = 10
        bookImage.clipsToBounds = true
        
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        bookImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        bookImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        bookImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        bookImage.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func configureBookTitle() {
        bookTitle.numberOfLines = 0
        bookTitle.adjustsFontSizeToFitWidth = true
        
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        bookTitle.topAnchor.constraint(equalTo: bookImage.topAnchor, constant: 5).isActive = true
        bookTitle.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 10).isActive = true
        bookTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
    }
    
    private func configureBookAuthor() {
        bookAuthor.numberOfLines = 0
        bookAuthor.adjustsFontSizeToFitWidth = true
        
        bookAuthor.translatesAutoresizingMaskIntoConstraints = false
        bookAuthor.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 5).isActive = true
        bookAuthor.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 10).isActive = true
        bookAuthor.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        bookAuthor.bottomAnchor.constraint(equalTo: bookImage.bottomAnchor).isActive = true
    }
    
}
