//
//  Article.swift
//  SeflMade_NewRx
//
//  Created by 김우성 on 2021/09/03.
//

import Foundation

// API로부터 받는 데이터 구조
struct ArticleResponse: Codable {
    
    let status: String?
    let totalResults: Int
    let articles: [Article]
}

// API로부터 받은 데이터 "상세" 구조
struct Article: Codable {
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
}


