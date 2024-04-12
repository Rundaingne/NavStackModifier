//
//  Item.swift
//  Test
//
//  Created by Erich Kumpunen on 4/10/24.
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
