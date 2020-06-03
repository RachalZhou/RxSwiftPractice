//
//  DateEx.swift
//  RxDemo
//
//  Created by 周日朝 on 2020/6/2.
//  Copyright © 2020 ZRC. All rights reserved.
//

import Foundation

extension Date {
    var timestamp: Int {
        return Int(self.timeIntervalSince1970)
    }
}
