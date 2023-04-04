//
//  MUser.swift
//  CHAT
//
//  Created by Никита Егоров on 25.11.2020.
//

import UIKit

import UIKit

struct MUser: Hashable, Decodable {
    var username: String
    var avatarStringURL: String
    var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        return lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercaseedFilter = filter.lowercased()
        return username.lowercased().contains(lowercaseedFilter)
    }
    
}

