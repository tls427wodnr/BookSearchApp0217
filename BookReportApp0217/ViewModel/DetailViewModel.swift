//
//  DetailViewModel.swift
//  BookReportApp0217
//
//  Created by tlswo on 3/2/25.
//

import UIKit

final class DetailViewModel {
    
    private var bookItem: BookItem?

    init(bookItem: BookItem? = nil) {
        self.bookItem = bookItem
    }
    
    var title: String {
        return bookItem?.title ?? "Default Title"
    }
    
    var author: String {
        return bookItem?.author ?? "Default Author"
    }
    
    var description: String {
        return bookItem?.description ?? "Default Description"
    }
    
    func fetchImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageURL = bookItem?.image, let url = URL(string: imageURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
