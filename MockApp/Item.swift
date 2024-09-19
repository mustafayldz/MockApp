//
//  Item.swift
//  MockApp
//
//  Created by Mustafa yıldiz on 2024-09-19.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
