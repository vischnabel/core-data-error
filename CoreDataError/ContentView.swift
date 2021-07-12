//
//  ContentView.swift
//  CoreDataError
//
//  Created by Vinícius Marinho Schnabel on 12/07/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @FetchRequest(entity: Messages.entity(), sortDescriptors: []) var messages: FetchedResults<Messages>
    @ObservedObject var viewModel: ViewModel
    
    private var message: Messages? {
        messages.first
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Text(message?.chat?.title ?? "Chat Title")
                .font(.largeTitle)
            Text(message?.text ?? "Message Text")
                .font(.headline)
            Button("Update Chat Title") {
                viewModel.updateChatTitle(of: messages.first)
            }
            Text(viewModel.error?.localizedDescription ?? "")
                .foregroundColor(.red)
        }
        .padding()
    }
}

class ViewModel: ObservableObject {
    @Published var error: NSError?
        
    func updateChatTitle(of message: Messages?) {
        guard
            let message = message,
            let managedObjectContext = message.managedObjectContext
        else {
            return
        }
        
        let messageId = message.objectID
        
        let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        backgroundContext.parent = managedObjectContext
        
        backgroundContext.perform { [weak self] in
            guard
                let backgroundMessage = backgroundContext.object(with: messageId) as? Messages,
                let backgroundChat = backgroundMessage.chat else {
                return
            }

            backgroundChat.title = "Updated Title"
            
            do {
                try backgroundContext.save()
            } catch let error {
                self?.error = error as NSError
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel())
    }
}
