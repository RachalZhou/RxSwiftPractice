//
//  NewsItem.swift
//  RxDemo
//
//  Created by 周日朝 on 2020/6/2.
//  Copyright © 2020 ZRC. All rights reserved.
//

import Foundation

struct NewsItem {
    var title: String
    var imgsrc: String
    var replyCount: String
    var source: String
    var imgnewextra: [Imgnewextra]?
}

struct Imgnewextra {
    var imgsrc: String
}
