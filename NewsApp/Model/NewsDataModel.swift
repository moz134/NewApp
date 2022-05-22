//
//  NewsDataModel.swift
//  NewsApp
//
//  Created by md mozammil on 21/05/22.
//

import Foundation


public struct ListNewsModel {
    var totalPages: Int
    var newsDataModel: [NewsDataModel]
}


public struct NewsDataModel: Hashable {
    
    var title: String
    var imageUrl: String
    var sourceName: String
    var urlToExpand: String
    var description: String
}

public struct NewsErrorModel {
    let errorCode: String
    let errorMessage: String
    
}
