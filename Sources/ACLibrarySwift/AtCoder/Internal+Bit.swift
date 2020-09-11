//
//  Internal+Bit.swift
//  
//
//  Created by 藤井陽介 on 2020/09/11.
//

import Foundation

extension Internal {
    static func ceilPow2(_ number: Int) -> Int {
        var x: UInt64 = 0
        while (1 << x) < UInt64(number) {
            x += 1
        }
        return Int(x)
    }

    static func bitScanForward(_ number: UInt64) -> Int {
        var x: UInt64 = 0
        while number & (1 << x) == 0 {
            x += 1
        }
        return Int(x)
    }
}
