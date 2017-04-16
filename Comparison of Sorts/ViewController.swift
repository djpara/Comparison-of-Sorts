//
//  ViewController.swift
//  Comparison of Sorts
//
//  Created by David Para on 4/10/17.
//  Copyright © 2017 ParaD. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // ENUM
    enum sortMethod {
        case insertion
        case selection
        case quick
        case merge
    }
    
    // VARIABLES
    var sortSize: Int = 16
    var topSortMethod: sortMethod = sortMethod.insertion
    var bottomSortMethod: sortMethod = sortMethod.insertion
    
    // OVERRIDES
    override func viewDidLoad() {
        super.viewDidLoad()
        sortSize = 16
        createList(size: sortSize)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // OUTLETS
    // Button
    @IBOutlet weak var sortButton: UIButton!
    
    // Indicator
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    // Segments
    @IBOutlet weak var sortSizeSegment: UISegmentedControl!
    @IBOutlet weak var topSortSegment: UISegmentedControl!
    @IBOutlet weak var bottomSortSegment: UISegmentedControl!
    
    // Views
    @IBOutlet weak var topDisplayView: TopView!
    @IBOutlet weak var bottomDisplayView: BottomView!
    
    // SORT PRESSED
    @IBAction func sortPressed(_ sender: UIButton) {
        disableButtons()

        let q = DispatchQueue.global(qos: .background)
        
        switch topSortMethod {
        case .insertion:
            q.async {
                self.topDisplayView.insertionSort()
            }
        case .selection:
            q.async {
                self.topDisplayView.selectionSort()
            }
        case .quick:
            q.async {
                self.topDisplayView.quickSort(left: 0, right: self.topDisplayView.topLst.count-1)
            }
        case .merge:
            q.async {
            self.topDisplayView.mergeSort(left: 0, right: self.topDisplayView.topLst.count-1)
            }
        }
        
        switch bottomSortMethod {
        case .insertion:
            q.async {
                self.bottomDisplayView.insertionSort()
            }
        case .selection:
            q.async {
                self.bottomDisplayView.selectionSort()
            }
        case .quick:
            q.async {
                self.bottomDisplayView.quickSort(left: 0, right: self.bottomDisplayView.bottomLst.count-1)
            }
        case .merge:
            q.async {
                self.bottomDisplayView.mergeSort(left: 0, right: self.bottomDisplayView.bottomLst.count-1)
            }
        }
        
        runCountDown()
    }
    
    // Disable buttons
    func disableButtons() {
        sortButton.isEnabled = false
        sortSizeSegment.isEnabled = false
        topSortSegment.isEnabled = false
        bottomSortSegment.isEnabled = false
        
        indicator.startAnimating()
    }
    
    // Enable buttons
    func enableButtons() {
        sortButton.isEnabled = true
        sortSizeSegment.isEnabled = true
        topSortSegment.isEnabled = true
        bottomSortSegment.isEnabled = true
        
        indicator.stopAnimating()
    }
    
    // Run countdown
    func runCountDown() {
        let q = DispatchQueue.global(qos: .background)
        q.async {
            for i in 0 ..< self.sortSize {
                usleep(100_000)
                if i == self.sortSize - 1 {
                    DispatchQueue.main.async {
                        self.enableButtons()
                    }
                }
            }
        }
    }
    
    // SEGMENTS PRESSED
    // Sort Size
    @IBAction func sortSizeSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            sortSize = 16
        case 1:
            sortSize = 32
        case 2:
            sortSize = 48
        case 3:
            sortSize = 64
        default:
            break
        }
        create()
    }
    
    // Top sort segment
    @IBAction func topSortSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            topSortMethod = sortMethod.insertion
        case 1:
            topSortMethod = sortMethod.selection
        case 2:
            topSortMethod = sortMethod.quick
        case 3:
            topSortMethod = sortMethod.merge
        default:
            break
        }
        create()
    }
    
    // Bottom sort segment
    @IBAction func bottomSortSegmentChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            bottomSortMethod = sortMethod.insertion
        case 1:
            bottomSortMethod = sortMethod.selection
        case 2:
            bottomSortMethod = sortMethod.quick
        case 3:
            bottomSortMethod = sortMethod.merge
        default:
            break
        }
        create()
    }
    
    // CREATE
    // New list and update
    func create() {
        createList(size: sortSize)
        topDisplayView.setNeedsDisplay()
        bottomDisplayView.setNeedsDisplay()
    }
    
    // New list
    func createList(size: Int) {
        topDisplayView.createList(size: size)
        bottomDisplayView.createList(size: size)
    }

}

