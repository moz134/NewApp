//
//  WebService.swift
//  NewsApp
//
//  Created by md mozammil on 21/05/22.
//

import Foundation

 public protocol WebServiceDelegate {
    func actionSuccess(data: ListNewsModel)
}

 public class WebService {
    
    
    var apiKey = "54654983129a4b95bc2643454fcc0743"
    
    
    var delegate: WebServiceDelegate?
    
    
    public init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    
    
    
     func performFetchTopHeadlines(pageIndex: Int) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?page=\(pageIndex)&language=en&apiKey=\(apiKey)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print(data)
                let response = try? JSONDecoder().decode(ResponseModel.self, from: data)
                
                if let response = response {
                    print(response)
                    
                    var newsModel: [NewsDataModel] = []
                    if let aritcles = response.articles {
                        for item in aritcles {
                            newsModel.append(NewsDataModel(title: item.title, imageUrl: item.urlToImage ?? "", sourceName: item.source.name, urlToExpand: item.url ?? "", description: item.description ?? "not found"))
                        }
                        let listNewsMode = ListNewsModel(totalPages: response.totalResults, newsDataModel: newsModel)
                        self.delegate?.actionSuccess(data: listNewsMode)
                    }
                }
            }
        }.resume()
        
    }
    
    
    func performFetchTopHeadlinesWithCountry(country: String) {
        let url = URL(string: "https://newsapi.org/v2/top-headlines?language=en&country=\(country)&apiKey=\(apiKey)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print(data)
                let response = try? JSONDecoder().decode(ResponseModel.self, from: data)
                
                if let response = response {
                    print(response)
                    var newsModel: [NewsDataModel] = []
                    if let aritcles = response.articles {
                        for item in aritcles {
                            newsModel.append(NewsDataModel(title: item.title, imageUrl: item.urlToImage ?? "", sourceName: item.source.name, urlToExpand: item.url ?? "", description: item.description ?? "not found"))
                        }
                        let listNewsMode = ListNewsModel(totalPages: response.totalResults, newsDataModel: newsModel)
                        self.delegate?.actionSuccess(data: listNewsMode)
                    }
                }
            }
        }.resume()
        
    }
    
    
    func performFetchByChannels(sources: String) {
        let sourceString = String(sources.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "WION")
        let url = URL(string: "https://newsapi.org/v2/top-headlines?language=en&sources=\(sourceString)&apiKey=\(apiKey)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                print(data)
                let response = try? JSONDecoder().decode(ResponseModel.self, from: data)
                
                if let response = response {
                    print(response)
                    var newsModel: [NewsDataModel] = []
                    if let aritcles = response.articles {
                        for item in aritcles {
                            newsModel.append(NewsDataModel(title: item.title, imageUrl: item.urlToImage ?? "", sourceName: item.source.name, urlToExpand: item.url ?? "", description: item.description ?? "not found"))
                        }
                        let listNewsMode = ListNewsModel(totalPages: response.totalResults, newsDataModel: newsModel)
                        self.delegate?.actionSuccess(data: listNewsMode)
                    }
                }
            }
        }.resume()
        
    }
    
    
     func performSearchNews(searchText: String, pageIndex: Int) {
         if !searchText.isEmpty {
             let url = URL(string: "https://newsapi.org/v2/everything?q=\(searchText)&page=\(pageIndex)&language=en&apiKey=\(apiKey)")!
             
             URLSession.shared.dataTask(with: url) { data, response, error in
                 if let error = error {
                     print(error.localizedDescription)
                 } else if let data = data {
                     print(data)
                     let response = try? JSONDecoder().decode(ResponseModel.self, from: data)
                     
                     if let response = response {
                         print(response)
                         var newsModel: [NewsDataModel] = []
                         if let aritcles = response.articles {
                             for item in aritcles {
                                 newsModel.append(NewsDataModel(title: item.title, imageUrl: item.urlToImage ?? "", sourceName: item.source.name, urlToExpand: item.url ?? "", description: item.description ?? "not found"))
                             }
                             let listNewsMode = ListNewsModel(totalPages: response.totalResults, newsDataModel: newsModel)
                             self.delegate?.actionSuccess(data: listNewsMode)
                         }
                     }
                 }
             }.resume()
         }
        
        
    }
    
    
    
}
