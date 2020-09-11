//
//  FenwickTree.swift
//  
//
//  ref: https://github.com/atcoder/ac-library/blob/master/atcoder/fenwicktree.hpp
//

import Foundation

public class FenwickTree<T: UnsignedInteger> {
    private var number: Int
    private var data: [T]

    public convenience init() {
        self.init(0)
    }

    public init(_ number: Int) {
        self.number = number
        self.data = Array<T>(repeating: 0, count: number)
    }

    public func add(at position: Int, _ value: T) {
        guard 0 <= position && position < number else {
            fatalError("Invalid position")
        }

        var position = position + 1
        while position <= number {
            data[position - 1] += value
            position += position & -position
        }
    }

    public func sum(from l: Int, to r: Int) -> T {
        guard 0 <= l && l <= r && r <= number else {
            fatalError("Invalid arguments")
        }

        return sum(to: r) - sum(to: l)
    }

    private func sum(to r: Int) -> T {
        var result: T = 0
        var right: Int = r

        while right > 0 {
            result += data[right - 1]
            right += right & -right
        }
        return result
    }
}
