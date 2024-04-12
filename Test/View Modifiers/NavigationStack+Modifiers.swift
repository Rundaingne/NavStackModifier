//
//  NavigationStack+Modifiers.swift
//  SNSwiftUI
//
//  Created by Erich Kumpunen on 4/12/24.
//  Copyright © 2024 SimpleNexus, LLC. All rights reserved.
//

import Foundation
import SwiftUI

struct NavigationStackModifier< T: View, U: View>: ViewModifier {
    var navTitle: String
    var navTitleColor: Color
    var displayMode: NavigationBarItem.TitleDisplayMode
    var leadingNavToolbarView: () -> T
    var trailingNavToolbarView: () -> U
    
    func body(content: Content) -> some View {
        NavigationStack {
            content
                .setNavBarColor(navTitleColor)
                .navigationTitle(navTitle)
                .navigationBarTitleDisplayMode(displayMode)
                .setNavToolbar(leading: leadingNavToolbarView, trailing: trailingNavToolbarView)
        }
        .tint(.clear)
    }
}

struct NavigationBarTitleColor: ViewModifier {
    var color: Color
    func body(content: Content) -> some View {
        content
            .onAppear {
                let coloredAppearance = UINavigationBarAppearance()
                coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor(color)]
                coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(color)]
                UINavigationBar.appearance().standardAppearance = coloredAppearance
                UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
            }
    }
}

struct NavigationBarToolbar<T: View, U: View>: ViewModifier {
    var leadingView: () -> T
    var trailingView: () -> U
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    leadingView()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    trailingView()
                }
            }
    }
}

extension View {
    
    public func setFullNav< T: View, U: View>(navTitle: String = "", navTitleColor: Color = .white, displayMode: NavigationBarItem.TitleDisplayMode = .inline, _ leadingView: @escaping () -> T,  trailingView: @escaping() -> U) -> some View {
        modifier(NavigationStackModifier(navTitle: navTitle, navTitleColor: navTitleColor, displayMode: displayMode, leadingNavToolbarView: leadingView, trailingNavToolbarView: trailingView))
    }
    
    public func setNavToolbar<T: View, U: View>(leading: @escaping () -> T, trailing: @escaping () -> U) -> some View {
        modifier(NavigationBarToolbar(leadingView: leading, trailingView: trailing))
    }
    
    func setNavBarColor(_ color: Color) -> some View {
        return self.modifier(NavigationBarTitleColor(color: color))
    }
}
