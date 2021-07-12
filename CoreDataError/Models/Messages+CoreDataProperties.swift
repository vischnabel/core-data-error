//
//  Messages+CoreDataProperties.swift
//  CoreDataError
//
//  Created by Vinícius Marinho Schnabel on 12/07/21.
//
//

import Foundation
import CoreData


extension Messages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Messages> {
        return NSFetchRequest<Messages>(entityName: "Messages")
    }

    @NSManaged public var chatId: String?
    @NSManaged public var text: String?

}

extension Messages : Identifiable {

}
