//
//  NewsViewModel.swift
//  RxDemo
//
//  Created by 周日朝 on 2020/6/2.
//  Copyright © 2020 ZRC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class NewsViewModel: NSObject {
    
    private var offset = BehaviorRelay(value: "")
    
    func transform(input: (BehaviorRelay<String>), dependence: (NewsData)) -> Driver<[NewsSection]> {
        self.offset = input
        return offset.asObservable()
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMap(dependence.getNews(_:))
            .asDriver(onErrorJustReturn: [])
    }
}
