//
//  ListItem.swift
//  ios-list-detail-templates
//
//  Created by Edgar Allan Fojas on 13/9/19.
//  Copyright © 2019 Edgar Allan Fojas. All rights reserved.
//

import Foundation

protocol ListItemProtocol {
    var id: String { get }
    var image: String?  { get }
    var title: String { get }
    var isLiked: Bool { get }
    
    mutating func toggleLikeStatus()
}

struct ListItem: ListItemProtocol, Equatable {
    let id: String
    let image: String?
    let title: String
    var isLiked: Bool
    
    mutating func toggleLikeStatus() {
        isLiked = !isLiked
    }
    
    static func == (lhs: ListItem, rhs: ListItem) -> Bool {
        return lhs.id == rhs.id
    }
}
