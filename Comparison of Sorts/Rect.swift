//
//  Rect.swift
//  Comparison of Sorts
//
//  Created by David Para on 4/15/17.
//  Copyright © 2017 ParaD. All rights reserved.
//

import Foundation
import UIKit

struct Rect : Comparable {
    
    var v = 0.0, x = 0.0, y = 0.0, width = 0.0, height = 0.0
    var r: CGRect? = nil
    
    init (value: Double, of n: Double) {
        self.v = value
        self.width = 336.0/n
        self.height = -(value*(200.0/n))
        self.r = CGRect(x: self.x, y: self.y, width: self.width, height: self.height)
    }
    
    static func < (lhs: Rect, rhs: Rect) -> Bool {
        return lhs.v < rhs.v
    }
    
    static func == (lhs: Rect, rhs: Rect) -> Bool {
        return lhs.v == rhs.v
    }
    
    mutating func setX(_ x: Double) {
        self.r?.origin = CGPoint(x: x, y: 200)
    }
    
    }
