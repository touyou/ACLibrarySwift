//
//  SegTree.swift
//  
//
//  ref: https://github.com/atcoder/ac-library/blob/master/atcoder/segtree.hpp
//

import Foundation

public protocol Monoid {
    static var e: Self { get }
    static func ope(_ a: Self, _ b: Self) -> Self
}

public class SegTree<S: Monoid> {
    private var number: Int
    private var size: Int
    private var log: Int
    private var data: [S]

    public convenience init() {
        self.init([S]())
    }

    public convenience init(_ number: Int) {
        self.init(Array<S>(repeating: S.e, count: number))
    }

    public init(_ array: [S]) {
        self.number = array.count
        self.log = Internal.ceilPow2(number)
        self.size = 1 << log

        self.data = Array<S>(repeating: S.e, count: 2 * size)
        for i in 0 ..< number {
            data[size + i] = array[i]
        }
        for i in (1 ..< size).reversed() {
            update(at: i)
        }
    }

    public func set(at position: Int, _ value: S) {
        guard 0 <= position && position < number else {
            fatalError("Invalid position")
        }

        let position = position + size
        data[position] = value
        for i in 1 ... log {
            update(at: position >> i)
        }
    }

    public func get(at position: Int) -> S {
        guard 0 <= position && position < number else {
            fatalError("Invalid position")
        }

        return data[position + size]
    }

    public func prod(from l: Int, to r: Int) -> S {
        guard 0 <= l && l <= r && r <= number else {
            fatalError("Invalid arguments")
        }

        var smallL: S = S.e
        var smallR: S = S.e
        var l = l + size
        var r = r + size

        while l < r {
            if l & 1 {
                smallL = S.ope(smallL, data[l])
                l += 1
            }
            if r & 1 {
                r -= 1
                smallR = S.ope(data[r], smallR)
            }

            l >>= 1
            r >>= 1
        }
        return S.ope(smallL, smallR)
    }

    public func allProd() -> S {
        return data[1]
    }

    // TODO: maxRight, minLeft

    private func update(at k: Int) {
        data[k] = S.ope(data[2 * k], data[2 * k + 1])
    }
}
