//
//  Tag.swift
//  
//
//  Created by Adrian Kirk on 19/01/2022.
//

import Foundation
import SwiftUI

extension TagView {
    public class Tag: ObservableObject, Identifiable, Hashable {
        @Published public var id: String
        @Published public var name: String
        @Published public var color: Color
        @Published public var isSelected: Bool

        public init(id: String, name: String, color: Color, isSelected: Bool) {
            self.id = id
            self.name = name
            self.color = color
            self.isSelected = isSelected
        }

        /// Only using the `id` property as the hash. Need to keep the dictionary
        /// key the same when toggling `isSelected`.
        public func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }

        public static func == (lhs: TagView.Tag, rhs: TagView.Tag) -> Bool {
            lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.color == rhs.color &&
            lhs.isSelected == rhs.isSelected
        }
    }
}
