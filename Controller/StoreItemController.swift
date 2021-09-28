//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by Eric Davis on 28/09/2021.
//

import Foundation
import UIKit

struct SearchResponse: Codable {
    let results: [StoreItem]
}

class StoreItemController {
    
    func fetchItems(matching query: [String: String],
                    completion: @escaping (Result<[StoreItem], Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://itunes.apple.com/search")!
        urlComponents.queryItems = query.map { URLQueryItem(name: $0.key, value: $0.value)}
        
        let task = URLSession.shared.dataTask(with: urlComponents.url!) {
            (data, response, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let searchResponse = try jsonDecoder.decode(SearchResponse.self, from: data)
                    completion(.success(searchResponse.results))
                } catch {
                    completion(.failure(error))
                }
                
            }
        }.resume()

    }
    
    func fetchArtworkImage(using url: URL,
                           completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data,
               let image = UIImage(data: data) {
                print("data")
                completion(.success(image))
            } else if let error = error {
                print("failure")
                completion(.failure(error))
            }
        }.resume()
    }
    
}
