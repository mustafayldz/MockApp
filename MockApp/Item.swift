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
    var id = UUID()
    var timestamp: Date
    var imageData: Data?
    
    init(timestamp: Date, imageData: Data? = nil) {
        self.timestamp = timestamp
        self.imageData = imageData
    }
}
