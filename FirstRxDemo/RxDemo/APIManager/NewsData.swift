//
//  NewsData.swift
//  RxDemo
//
//  Created by 周日朝 on 2020/6/2.
//  Copyright © 2020 ZRC. All rights reserved.
//

import RxCocoa
import RxSwift
import Moya
import Alamofire
import SwiftyJSON

class NewsData: NSObject {
    
    static let shared = NewsData()
    private let provider = MoyaProvider<NewsMoya>()
    
    func getNews(_ offset: String) -> Observable<[NewsSection]> {
        
        return Observable<[NewsSection]>.create { observable in
            
            self.provider.request(.news(offset), callbackQueue: DispatchQueue.main) { response in
                
                switch response {
                case let .success(result):
                    let newsItems = self.parse(result.data)
                    observable.onNext(newsItems)
                    observable.onCompleted()
                    
                case let .failure(error):
                    observable.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    func parse(_ data: Any) -> [NewsSection] {
        guard let json = JSON(data)["T1348649079062"].array else { return [] }
        var items: [NewsItem] = []
        json.forEach {
            guard !$0.isEmpty else { return }
            var imgnewextras: [Imgnewextra] = []
            if let imgUrls = $0["imgnewextra"].array {
                imgUrls.forEach {
                    let imgUrl = Imgnewextra(imgsrc: $0["imgsrc"].string ?? "")
                    imgnewextras.append(imgUrl)
                }
            }
            let item = NewsItem(title: $0["title"].string ?? "",
                                imgsrc: $0["imgsrc"].string ?? "",
                                replyCount: $0["replyCount"].string ?? "",
                                source: $0["source"].string ?? "",
                                imgnewextra: imgnewextras)
            items.append(item)
        }
        return [NewsSection(header: "1", items: items)]
    }
}

enum NewsMoya {
    case news(_ input: String)
}

extension NewsMoya: TargetType {
    
    var headers: [String : String]? {
        return ["Content-Type": "text/plain"]
    }
    var baseURL: URL {
        return URL(string: "https://c.m.163.com")!
    }
    
    var path: String {
        return "/dlist/article/dynamic"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .news(offset):
            let params = ["from": "T1348649079062",
                          "devId": "H71eTNJGhoHeNbKnjt0%2FX2k6hFppOjLRQVQYN2Jjzkk3BZuTjJ4PDLtGGUMSK%2B55",
                          "version": "54.6",
                          "spever": "false",
                          "net": "wifi",
                          "ts": "\(Date().timestamp)",
                          "sign": "BWGagUrUhlZUMPTqLxc2PSPJUoVaDp7JSdYzqUAy9WZ48ErR02zJ6%2FKXOnxX046I",
                          "encryption": "1",
                          "canal": "appstore",
                          "offset": offset,
                          "size": "10",
                          "fn": "3"]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
