//
//  CreatePatternViewController.swift
//  Patterns
//
//  Created by Pierre Larose on 11/4/14.
//  Copyright (c) 2014 Pierre Larose. All rights reserved.
//

import UIKit
import CoreData

class CreatePatternViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var frontPicture = true
    @IBOutlet weak var frontImageView: UIImageView!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let frontTapRecognizer = UITapGestureRecognizer(target: self, action: "frontTapped")
        self.frontImageView.addGestureRecognizer(frontTapRecognizer)
        
        let backTapRecognizer = UITapGestureRecognizer(target: self, action: "backTapped")
        self.backImageView.addGestureRecognizer(backTapRecognizer)
    }
    
    func frontTapped() {
        self.frontPicture = true
        launchCamera()
    }
    
    func backTapped() {
        self.frontPicture = false
        launchCamera()
    }
    
    func launchCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let cameraViewController = UIImagePickerController()
            cameraViewController.sourceType = UIImagePickerControllerSourceType.Camera
            cameraViewController.delegate = self
            self.presentViewController(cameraViewController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        if self.frontPicture {
            self.frontImageView.image = image
        } else {
            self.backImageView.image = image
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveTapped(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var pattern = NSEntityDescription.insertNewObjectForEntityForName("Pattern", inManagedObjectContext: context) as! Pattern
        pattern.name = self.nameTextField.text!
        pattern.frontImage = UIImageJPEGRepresentation(self.frontImageView.image!, 1)!
        pattern.backImage = UIImageJPEGRepresentation(self.backImageView.image!, 1)!
        do {
            try context.save()
        } catch _ {
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
