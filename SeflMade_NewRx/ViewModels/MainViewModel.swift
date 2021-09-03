//
//  MainViewModel.swift
//  SeflMade_NewRx
//
//  Created by 김우성 on 2021/09/03.
//

import Foundation
import RxSwift

final class MainViewModel {
    
    let title = "Uno's News"
    
    // 프로토콜로 프로퍼티 타입을 채택
    private let articleService: APIService
    
    init(articleService: APIService) {
        self.articleService = articleService
    }
    
    /// ViewModel 옵저버블을 리턴하는 메소드
    /// - API에서 받은 데이터를 각 cell에 전달할 예정
    func fetchArticles() -> Observable<[CellViewModel]> {
        articleService.fetchNews().map { // API에서 받아온 데이터
            $0.map { // 데이터 전체를 개별적으로 접근하여 CellViewModel 구성에 맞게 재정의
                CellViewModel(article: $0)
            }
        }
    }
}


