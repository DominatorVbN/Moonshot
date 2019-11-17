//
//  Missions.swift
//  Moonshot
//
//  Created by dominator on 11/11/19.
//  Copyright © 2019 dominator. All rights reserved.
//

import Foundation

struct CrewRole: Codable{
    let name: String
    let role: String
}
struct Mission: Codable, Identifiable{
    let id: Int
    let crew: [CrewRole]
    let description: String
    let launchDate: Date?
    
    var displayName: String {
        "Apollo \(id)"
    }
    
    var image: String {
        "apollo\(id)"
    }
    
    var formattedDate: String{
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else {
            return "N/A"
        }
    }
}
