//
//  CellViewModel.swift
//  SeflMade_NewRx
//
//  Created by 김우성 on 2021/09/03.
//

import Foundation

// 메소드를 사용하지 않을 것이므로 구조체로 선언
struct CellViewModel {
    
    private let article: Article
    
    var imageURL: String? {
        article.urlToImage
    }
    
    var title: String? {
        article.title
    }
    
    var description: String? {
        article.description
    }
    
    init(article: Article) {
        self.article = article
    }
}
