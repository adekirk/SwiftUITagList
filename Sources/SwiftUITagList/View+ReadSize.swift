//
//  File.swift
//  
//
//  Created by Adrian Kirk on 19/01/2022.
//

import SwiftUI

extension View  {
    /// Read the size of the current view.
    ///
    /// See: https://www.fivestars.blog/articles/flexible-swiftui/
    ///
    /// Usage:
    ///  ```
    ///    @State var viewWidth: CGFloat = .zero
    ///
    ///    ZStack {
    ///        Color.clear
    ///            .frame(height: 1)
    ///            .readSize { size in
    ///                availableWidth = size.width
    ///            }
    ///
    ///    // More view stuff here...
    ///    }
    ///
    /// - Parameter onChange: Handle size change here.
    /// - Returns: Size of the current view.
    public func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background {
            GeometryReader { geo in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geo.size)
            }
        }
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

private struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) { }
}
