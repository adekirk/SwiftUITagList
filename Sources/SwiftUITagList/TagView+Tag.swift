//
//  Tag.swift
//  
//
//  Created by Adrian Kirk on 19/01/2022.
//

import Foundation
import SwiftUI

extension TagView {
    public struct Tag: Identifiable, Hashable {
        public var id: String
        public var name: String
        public var color: Color
        public var isSelected: Bool

        public init(id: String, name: String, color: Color, isSelected: Bool) {
            self.id = id
            self.name = name
            self.color = color
            self.isSelected = isSelected
        }
    }
}
