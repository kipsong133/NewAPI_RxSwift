//
//  ArticleService.swift
//  SeflMade_NewRx
//
//  Created by 김우성 on 2021/09/03.
//

import Foundation
import Alamofire
import RxSwift

enum APIError: Error {
    case invaildURL
}

protocol APIService {
    
    func fetchNews() -> Observable<[Article]>
}

class ArticleService: APIService {
    
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            // 옵저버블을 생성하여, API에서 받아온 데이터를 처리한다.
            self.fetchNews { (error, articles) in
                // 에러 발생
                if let error = error {
                    observer.onError(error) // 에러이벤트 방출
                }
                
                // 정상적으로 데이터를 수신한 경우
                if let articles = articles {
                    observer.onNext(articles) // 넥스트이벤트 방출
                }
                
                // 옵저버블 종료
                observer.onCompleted()
            }
            // 리소스 제거
            return Disposables.create()
        }
    }
    
    /// 일반적인 Alamofire를 활용한 fetch 메소드
    private func fetchNews(
        completion: @escaping (Error?, [Article]?) -> Void) {
        
        // URL String
        let urlStr = "https://newsapi.org/v2/everything?q=tesla&from=2021-08-03&sortBy=publishedAt&apiKey=26a16161dbef4ae58e5e29d924166c41"
    
        // String -> URL
        guard let url = URL(string: urlStr) else {
            // url이 유효하지 않는 경우
            return completion(APIError.invaildURL, nil)
        }
        
        // GET Method
        AF.request(url,
                   method: HTTPMethod.get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .responseDecodable(of: ArticleResponse.self) { response in
                // 에러가 발생한 경우
                if let error = response.error {
                    return completion(error, nil)
                }
                
                // 에러가 발생하지 않은 경우
                if let article = response.value?.articles {
                    return completion(nil, article)
                }
            }
    }
    
}

