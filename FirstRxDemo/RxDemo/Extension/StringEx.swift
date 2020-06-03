//
//  StringEx.swift
//  RxDemo
//
//  Created by 周日朝 on 2020/6/2.
//  Copyright © 2020 ZRC. All rights reserved.
//

import Foundation

extension String {
    var legalUrlString: String? {
        if self.hasPrefix("http") {
            return self.replacingOccurrences(of: "http", with: "https")
        }
        return nil
    }
}
