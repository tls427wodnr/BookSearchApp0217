//
//  DetailViewController.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/18/25.
//

import UIKit

class DetailViewController: UIViewController {
    
    var detailViewModel: DetailViewModel!
    
    var detailViewImage = UIImageView()
    var detailViewTitle = UILabel()
    var detailViewAuthor = UILabel()
    var detailViewDescription = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        loadImage()
        setupUI()
    }
    
    func setupUI(){
        detailViewImage.translatesAutoresizingMaskIntoConstraints = false
        detailViewImage.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            detailViewImage.heightAnchor.constraint(equalTo: detailViewImage.widthAnchor),
        ])
        detailViewTitle.text = detailViewModel.title
        detailViewTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        detailViewTitle.numberOfLines = 0
        detailViewTitle.lineBreakMode = .byWordWrapping
        
        detailViewAuthor.text = detailViewModel.author
        detailViewAuthor.font = UIFont.systemFont(ofSize: 17)
        
        detailViewDescription.text = detailViewModel.description
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
    
    func loadImage() {
        detailViewModel.fetchImage { [weak self] image in
            self?.detailViewImage.image = image ?? UIImage(systemName: "photo")
        }
    }

}
