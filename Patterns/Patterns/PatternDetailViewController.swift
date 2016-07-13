//
//  PatternDetailViewController.swift
//  Patterns
//
//  Created by Pierre Larose on 11/4/14.
//  Copyright (c) 2014 Pierre Larose. All rights reserved.
//

import UIKit

class PatternDetailViewController: UIViewController {

    var pattern : Pattern? = nil
    var tappedImage : UIImage? = nil
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationItem.title = self.pattern!.name
        self.frontImageView.image = UIImage(data: self.pattern!.frontImage)
        self.backImageView.image = UIImage(data: self.pattern!.backImage)
        
        let frontTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(PatternDetailViewController.frontTapped))
        self.frontImageView.addGestureRecognizer(frontTapRecognizer)
        
        let backTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(PatternDetailViewController.backTapped))
        self.backImageView.addGestureRecognizer(backTapRecognizer)
    }
    
    func frontTapped() {
        self.tappedImage = self.frontImageView.image
        self.performSegueWithIdentifier("zoomSegue", sender: self)
    }

    func backTapped() {
        self.tappedImage = self.backImageView.image
        self.performSegueWithIdentifier("zoomSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let zoomViewController = segue.destinationViewController as! ZoomViewController
        zoomViewController.image = self.tappedImage!
    }
}
