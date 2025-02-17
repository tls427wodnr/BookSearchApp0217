//
//  Model.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/17/25.
//

import Foundation

struct BookResponse: Codable {
    let items: [BookItem]
}

struct BookItem: Codable {
    let title: String
    let image: String
    let author: String
    let publisher: String
    let description: String
}
