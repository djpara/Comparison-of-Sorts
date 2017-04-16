//
//  TopView.swift
//  Comparison of Sorts
//
//  Created by David Para on 4/14/17.
//  Copyright © 2017 ParaD. All rights reserved.
//

import UIKit

class TopView: UIView {

    var topLst: [Rect] = []
    
    // OVERRIDES
    override func draw(_ rect: CGRect) {
        // Drawing code
        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(UIColor.white.cgColor)
            context.setFillColor(UIColor.red.cgColor)
            context.setLineWidth(1)
            
            let size = topLst.count
            
            for r in 0 ..< size {
                let x = Double(r) * topLst[r].width
                topLst[r].setX(x)
                context.stroke(topLst[r].r!)
                context.fill(topLst[r].r!)
            }
        }
    }
    
    // CREATE
    func createList(size: Int) {
        topLst.removeAll()
        
        for n in 1 ... size {
            let r = Rect(value: Double(n), of: Double(size))
            topLst.append(r)
        }
        
        shuffle(&topLst)
    }
    
    // SHUFFLE
    func shuffle(_ a: inout [Rect]) {
        let N = a.count
        for i in 0 ..< N {
            let r = Int(arc4random_uniform(UInt32(i+1)))
            swap(a: &a[i], b: &a[r])
        }
    }
    
    // SORT
    // Insertion
    func insertionSort() {
        let n = topLst.count
        
        for i in 1..<n {
            let key = self.topLst[i]
            var j = i-1
            
            while j >= 0 && self.topLst[j] > key {
                self.topLst[j+1] = self.topLst[j]
                j = j-1
                
            }
            self.topLst[j+1] = key
            DispatchQueue.main.async {
                self.setNeedsDisplay()
            }
            usleep(100_000)
        }
        
    }
    
    // Selection
    func selectionSort() {
        let n = topLst.count
        
        for i in 0..<n {
            var min = i
            for j in i+1..<n {
                if self.topLst[j] < self.topLst[min] {
                    min = j
                }
            }
            
            if min != i {
                self.swap(a: &self.topLst[i], b: &self.topLst[min])
                DispatchQueue.main.async {
                    self.setNeedsDisplay()
                }
                usleep(105_000)
            }
        }
        
    }
    
    // Quick
    func quickSort(left l: Int, right r: Int) {
        var i = l
        var j = r
        let p = self.topLst[((l + r)/2)+1]
        while i <= j {
            while self.topLst[i] < p {
                i += 1
            }
            while self.topLst[j] > p {
                j -= 1
            }
            if i <= j {
                if self.topLst[i] != self.topLst[j] {
                    self.swap(a: &self.topLst[i], b: &self.topLst[j])
                    DispatchQueue.main.async {
                        self.setNeedsDisplay()
                    }
                    usleep(40_000)
                }
                i += 1
                j -= 1
            }
        }
        
        if l < j {
            self.quickSort(left: l, right: j)
        }
        if i < r {
            self.quickSort(left: i, right: r)
        }
    }
 
    
    // Merge
    func mergeSort(left l: Int, right r: Int) {
        var i, j, k: Int
        var m: Int
        var n1: Int
        var n2: Int
        var L: [Rect] = []
        var R: [Rect] = []
        
        if l < r {
            
            m = l + (r - l)/2
            
            mergeSort(left: l, right: m)
            mergeSort(left: m + 1, right: r)
            
            n1 = m - l + 1
            n2 = r - m
            
            for _ in 0 ..< n1 {
                L.append(Rect(value: 1, of: 1))
            }
            
            for _ in 0 ..< n2 {
                R.append(Rect(value: 1, of: 1))
            }
            
            for i in 0 ..< n1 {
                L[i] = topLst[l + i]
            }
            for j in 0 ..< n2 {
                R[j] = topLst[m + 1 + j]
            }
            
            i = 0
            j = 0
            k = l
            
            while i < n1 && j < n2 {
                if L[i] <= R[j] {
                    topLst[k] = L[i]
                    i += 1
                } else {
                    topLst[k] = R[j]
                    j += 1
                }
                DispatchQueue.main.async {
                    self.setNeedsDisplay()
                }
                usleep(1_250)
                k += 1
            }
            
            while i < n1 {
                topLst[k] = L[i]
                DispatchQueue.main.async {
                    self.setNeedsDisplay()
                }
                usleep(1_250)
                i += 1
                k += 1
            }
            
            while j < n2 {
                topLst[k] = R [j]
                DispatchQueue.main.async {
                    self.setNeedsDisplay()
                }
                usleep(1_250)
                j += 1
                k += 1
            }
        }
    }
    
    // SWAP
    func swap (a: inout Rect, b: inout Rect) {
        (a, b) = (b, a)
    }

    
}
