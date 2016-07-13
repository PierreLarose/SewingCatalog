//
//  ViewController.swift
//  Patterns
//
//  Created by Pierre Larose on 10/27/14.
//  Copyright (c) 2014 Pierre Larose. All rights reserved.
//

import UIKit
import CoreData

class PatternsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var patterns : [Pattern] = []
    
    var selectedPattern : Pattern? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        //createTestPatterns()
    }
    
    override func viewWillAppear(animated: Bool) {
        let context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        let request = NSFetchRequest(entityName: "Pattern")
        
        let results = try? context.executeFetchRequest(request)
        
        if results != nil {
            self.patterns = results! as! [Pattern]
        }
        
        self.tableView.reloadData()
    }
    
    func createTestPatterns() {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        
        var pattern = NSEntityDescription.insertNewObjectForEntityForName("Pattern", inManagedObjectContext: context) as! Pattern
        pattern.name = "The Pantz"
        pattern.frontImage = UIImageJPEGRepresentation(UIImage(named: "examplePattern.jpg")!, 1)!
        pattern.backImage = UIImageJPEGRepresentation(UIImage(named: "examplePatternBack.jpg")!, 1)!
        do {
            try context.save()
        } catch _ {
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patterns.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let pattern = self.patterns[indexPath.row]
        cell.textLabel!.text = pattern.name
        cell.imageView!.image = UIImage(data: pattern.frontImage)
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedPattern = self.patterns[indexPath.row]
        self.performSegueWithIdentifier("patternDetailSegue", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "patternDetailSegue" {
            let detailViewController = segue.destinationViewController as! PatternDetailViewController
            detailViewController.pattern = self.selectedPattern
        }
    }
}

