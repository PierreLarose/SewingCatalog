//
//  Pattern.swift
//  Patterns
//
//  Created by Pierre Larose on 11/4/14.
//  Copyright (c) 2014 Pierre Larose. All rights reserved.
//

import Foundation
import CoreData

class Pattern: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var frontImage: NSData
    @NSManaged var backImage: NSData

}
