//
//  NewsSection.swift
//  RxDemo
//
//  Created by 周日朝 on 2020/6/2.
//  Copyright © 2020 ZRC. All rights reserved.
//

import Foundation
import RxDataSources

struct NewsSection {
    var header: String?
    var items: [NewsItem]
}

extension NewsSection: SectionModelType {
    init(original: NewsSection, items: [NewsItem]) {
        self = original
        self.items = items
    }
}
