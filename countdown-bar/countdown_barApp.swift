//
//  countdown_barApp.swift
//  countdown-bar
//
//  Created by Kolbe Bauer on 2/27/26.
//

internal import SwiftUI

@main
struct CountdownBarApp: App {
    @StateObject private var store = CountdownStore()

    var body: some Scene {
        MenuBarExtra {
            MenuBarView()
                .environmentObject(store)
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "timer")
                if let nearest = store.countdowns.first(where: { !$0.isExpired }) {
                    Text(nearest.formattedTimeRemaining)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                }
            }
        }
        .menuBarExtraStyle(.window)
    }
}
