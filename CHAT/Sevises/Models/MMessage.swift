//
//  MMassage.swift
//  CHAT
//
//  Created by Никита Егоров on 17.12.2020.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct MMessage: Hashable, MessageType {
    
    
    var sender: SenderType
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    
    
    let content: String
//    let senderId: String
//    let senderUsername: String
    var sentDate: Date
    let id: String?
    
    var kind: MessageKind {
        return .text(content)
    }
    
    init(user: MUser, content: String) {
        self.content = content
//        senderId = user.id
//        senderUsername = user.username
        sender = Sender(senderId: user.id, displayName: user.username)
        sentDate = Date()
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil }
        guard let senderId = data["senderID"] as? String else { return nil }
        guard let senderName = data["senderName"] as? String else { return nil }
        guard let content = data["content"] as? String else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
//        self.senderId = senderId
//        self.senderUsername = senderName
        sender = Sender(senderId: senderId, displayName: senderName)
        self.content = content
        
        
    }
    
    var representation: [String : Any] {
        var rep: [String : Any] = [
            "created" : sentDate,
            "senderID" : sender.senderId,
            "senderName": sender.displayName,
            "content": content
        ]
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    

    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
    
}

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
}
