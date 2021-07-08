//
//  ViewController.swift
//  Core Graphics
//
//  Created by Harbros47 on 14.01.21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var drawingView: UIIntroductionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        drawingView?.setNeedsDisplay()
    }
}
