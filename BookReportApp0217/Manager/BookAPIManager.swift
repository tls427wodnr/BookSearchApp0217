//
//  BookAPIManager.swift
//  BookReportApp0217
//
//  Created by tlswo on 2/17/25.
//

import Foundation

final class BookAPIManager {
    
    static let shared = BookAPIManager()
    
    private init() {}
    
    func fetchBooksAPI(query: String, start: Int ,completion: @escaping ([BookItem]?) -> Void) {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        let urlString = "https://openapi.naver.com/v1/search/book.json?query=\(encodedQuery)&display=30&start=\(start)"
        let clientID = ""
        let clientSecret = ""
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue(clientID, forHTTPHeaderField: "X-Naver-Client-Id")
            request.addValue(clientSecret, forHTTPHeaderField: "X-Naver-Client-Secret")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("에러 발생: \(error.localizedDescription)")
                    completion(nil)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("응답 오류: \(response.debugDescription)")
                    completion(nil)
                    return
                }
                
                if let data = data {
                    do {
                        let decodeData = try JSONDecoder().decode(BookResponse.self, from: data)
                        completion(decodeData.items)
                    } catch {
                        print("JSON 파싱 에러: \(error.localizedDescription)")
                        completion(nil)
                    }
                }
            }
            
            task.resume()
        } else {
            print("URL 생성 실패")
            completion(nil)
            return
        }
    }
}
