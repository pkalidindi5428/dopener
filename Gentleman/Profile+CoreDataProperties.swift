//
//  Profile+CoreDataProperties.swift
//  Gentleman
//
//  Created by Prasant Kalidindi on 4/16/19.
//  Copyright © 2019 Prasant Kalidindi. All rights reserved.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var distance: Int16
    @NSManaged public var speed: Int16

}
