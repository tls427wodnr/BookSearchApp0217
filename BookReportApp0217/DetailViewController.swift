//
//  DetailViewController.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/18/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var bookItem: BookItem?
    
    var detailViewImage = UIImageView()
    var detailViewTitle = UILabel()
    var detailViewAuthor = UILabel()
    var detailViewDescription = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    func setupUI(){
        configureImage(imageURL: bookItem?.image ?? "")
        detailViewImage.translatesAutoresizingMaskIntoConstraints = false
        detailViewImage.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            detailViewImage.heightAnchor.constraint(equalToConstant: 300),
        ])
        
        detailViewTitle.text = bookItem?.title
        detailViewTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        detailViewTitle.numberOfLines = 0
        detailViewTitle.lineBreakMode = .byWordWrapping
        
        detailViewAuthor.text = bookItem?.author
        detailViewAuthor.font = UIFont.systemFont(ofSize: 17)
        
        detailViewDescription.text = bookItem?.description
        detailViewDescription.font = UIFont.systemFont(ofSize: 15)
        detailViewDescription.textColor = .gray
        detailViewDescription.numberOfLines = 0
        detailViewDescription.lineBreakMode = .byWordWrapping
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10)
         ])
                
        let stackView = UIStackView(arrangedSubviews: [detailViewImage, detailViewTitle, detailViewAuthor, detailViewDescription])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        ])
        
        stackView.setCustomSpacing(20, after: detailViewImage)
    }
    
    func configureImage(imageURL: String) {
        if let url = URL(string: imageURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.detailViewImage.image = image
                    }
                }
            }.resume()
        }
    }
}
