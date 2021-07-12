//
//  Messages+CoreDataClass.swift
//  CoreDataError
//
//  Created by Vinícius Marinho Schnabel on 12/07/21.
//
//

import Foundation
import CoreData

@objc(Messages)
public class Messages: NSManagedObject {

    var chat: Chat? {
        let chatValues = value(forKey: "chat")
        
        let chats = chatValues as? [Chat]
        
        return chats?.first
    }
    
}
