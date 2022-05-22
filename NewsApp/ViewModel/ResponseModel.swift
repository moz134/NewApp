//
//  ResponseModel.swift
//  NewsApp
//
//  Created by md mozammil on 21/05/22.
//

import Foundation

struct ResponseModel: Decodable {
    let status: String
    let totalResults: Int
    let articles: [Articles]?
}

struct Articles: Decodable {
    let source: Source
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    
}


struct Source: Decodable {
    let id: String?
    let name: String
}


struct ErrorResponseMode: Decodable {
    let status: String
    let message: String
}
