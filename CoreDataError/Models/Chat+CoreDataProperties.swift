//
//  Chat+CoreDataProperties.swift
//  CoreDataError
//
//  Created by Vinícius Marinho Schnabel on 12/07/21.
//
//

import Foundation
import CoreData


extension Chat {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chat> {
        return NSFetchRequest<Chat>(entityName: "Chat")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?

}

extension Chat : Identifiable {

}
