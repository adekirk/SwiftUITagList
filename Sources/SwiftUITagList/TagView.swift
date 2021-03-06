//
//  TagView.swift
//
//
//  Created by Adrian Kirk on 19/01/2022.
//

import SwiftUI

public struct TagView: View {
    @ObservedObject var tag: Tag
    @State var hiddenTrigger: Bool = false

    private let selectedImage = "checkmark.circle"
    private let clearImage = "circle"

    public init(tag: Tag) {
        self.tag = tag
    }

    public var body: some View {
        HStack {
            Image(systemName: tag.isSelected ? selectedImage : clearImage)
                .frame(width: 20)

            Text(tag.name)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(tag.color.opacity(tag.isSelected ? 1.0 : 0.4))
        .foregroundColor(.white)
        .cornerRadius(8)
        .onTapGesture {
            tag.isSelected.toggle()
            self.hiddenTrigger.toggle()
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @StateObject var clear = TagView.Tag(id: "1", name: "Clear", color: .red, isSelected: false)
        @StateObject var selected = TagView.Tag(id: "2", name: "Selected", color: .blue, isSelected: true)

        var body: some View {
            VStack(alignment: .leading, spacing: 20) {
                TagView(tag: clear)
                TagView(tag: selected)
            }
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
}
