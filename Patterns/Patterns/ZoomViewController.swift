//
//  ZoomViewController.swift
//  Patterns
//
//  Created by Pierre Larose on 11/4/14.
//  Copyright (c) 2014 Pierre Larose. All rights reserved.
//

import UIKit

class ZoomViewController: UIViewController, UIScrollViewDelegate {

    var image: UIImage? = nil
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Roll Tide...
        

        self.scrollView.minimumZoomScale = 1
        self.scrollView.maximumZoomScale = 50
        self.scrollView.delegate = self
        self.imageView.image = self.image!
    }
    
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }

}
