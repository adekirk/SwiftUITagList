//
//  TagListView.swift
//  
//
//  Created by Adrian Kirk on 19/01/2022.
//

import SwiftUI

public struct TagListView<Content: View>: View {


    @State private var widths: [TagView.Tag: CGFloat] = [:]
    @State private var availableWidth: CGFloat = 0

    @Binding var tags: [TagView.Tag]

    let spacing: CGFloat
    let content: (Binding<TagView.Tag>) -> Content

    public init(tags: Binding<[TagView.Tag]>, spacing: CGFloat, content: @escaping (Binding<TagView.Tag>) -> Content) {
        self._tags = tags
        self.spacing = spacing
        self.content = content
    }

    public var body: some View {
        ZStack(alignment: .leading) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }

            VStack(alignment: .leading, spacing: spacing) {
                ForEach(computeRows(width: availableWidth), id: \.self) { row in
                    HStack(spacing: spacing) {
                        ForEach(row, id: \.self) { tag in
                            content($tags.first(where: { $0.id == tag.id })!)
                                .fixedSize()
                                .readSize { size in
                                    widths[tag] = size.width
                                }
                        }
                    }
                }
            }
        }
    }

    /// Splits the elements into rows based on the available row width and individual element width.
    /// Wrapping on to new rows as necessary.
    func computeRows(width: CGFloat) -> [[TagView.Tag]] {
        var rows: [[TagView.Tag]] = [[]]
        var currentRow = 0
        var remainingWidth = width

        for tag in tags {
            let tagWidth = widths[tag, default: width]

            // If room on the current row append to row, else start a new row.
            if remainingWidth - tagWidth + spacing >= 0 {
                rows[currentRow].append(tag)
            } else {
                currentRow += 1
                rows.append([tag])
                remainingWidth = width
            }

            remainingWidth -= (tagWidth + spacing)
        }

        return rows
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }

    struct PreviewWrapper: View {
        @State var tags: [TagView.Tag] = [
            .init(id: "1", name: "HR", color: .yellow, isSelected: false),
            .init(id: "2", name: "Marketing", color: .orange, isSelected: false),
            .init(id: "1", name: "HR", color: .yellow, isSelected: false),
            .init(id: "1", name: "HR", color: .yellow, isSelected: false),
            .init(id: "3", name: "Management", color: .red, isSelected: false),
            .init(id: "4", name: "Sales", color: .green, isSelected: false),
            .init(id: "5", name: "Training", color: .blue, isSelected: false),
        ]
        let spacing: CGFloat = 16

        var body: some View {
            VStack {
                Text("Tags")
                Divider()
                TagListView(tags: $tags, spacing: spacing) { item in
                    TagView(tag: item)
                }
                Divider()
                Spacer()
            }
            .padding()
        }
    }
}
