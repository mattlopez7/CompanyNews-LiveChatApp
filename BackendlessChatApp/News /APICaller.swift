//
//  APICaller.swift
//  Lordstown Motors News
//
//  Created by Matthew Lopez on 8/5/21.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL  = URL(string: "https://newsapi.org/v2/everything?qInTitle=Lordstown&sortBy=publishedAt&language=en&apiKey=002181879cda40b9801e5ee69bb8d14a")
        static let searchURLString = "https://newsapi.org/v2/everything?language=en&sortBy=publishedAt&apiKey=002181879cda40b9801e5ee69bb8d14a&q=" //insert (&q=) at the end for search feature
            //Spaces for search bar dosen't work
    }
    
    private init() {}
    
    public func getTopStories(completion: @escaping (Result<[Article], Error>) -> Void){
        guard let url = Constants.topHeadlinesURL else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))

                }
            }
        }
        task.resume()
    }
    
    public func search(with query: String, completion: @escaping (Result<[Article], Error>) -> Void){
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlstring = Constants.searchURLString + query
        guard let url = URL(string: urlstring) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print("Articles: \(result.articles.count)")
                    completion(.success(result.articles))
                }
                catch {
                    completion(.failure(error))

                }
            }
        }
        task.resume()
    }
}

//Models

struct APIResponse: Codable {
    let articles : [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String

}

struct Source: Codable {
    let name: String
}


