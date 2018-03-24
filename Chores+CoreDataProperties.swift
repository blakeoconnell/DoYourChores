//
//  Chores+CoreDataProperties.swift
//  DoYourChores
//
//  Created by Blake O'Connell on 11/16/17.
//  Copyright © 2017 Blake O'Connell. All rights reserved.
//

import Foundation
import CoreData


extension Chores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chores> {
        return NSFetchRequest<Chores>(entityName: "Chores")
    }

    @NSManaged public var name: String?
    @NSManaged public var userAssigned: String?
    @NSManaged public var sessions: Session?

}
