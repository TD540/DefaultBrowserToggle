//
//  HoverButton.swift
//  DefaultBrowserToggle
//
//  Created by thomas on 03/01/2024.
//

import SwiftUI

struct MenuBarButton<Label: View>: View {
    var action: () -> Void
    @ViewBuilder var label: () -> Label

    @State private var isHovering = false

    var body: some View {
        Button(action: action, label: label)
            .buttonStyle(RoundedRectButtonStyle(isHovering: isHovering))
            .onHover { over in
                isHovering = over
            }
    }
}

struct RoundedRectButtonStyle: ButtonStyle {
    var isHovering: Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(4)
            .background(isHovering ? Color.accentColor.cornerRadius(3) : Color.clear.cornerRadius(3))
            .foregroundColor(isHovering ? Color.white : Color.primary)
    }
}

#Preview {
    MenuBarButton {} label: {
        Text("Firefox")
    }
}
