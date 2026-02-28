//
//  MenuBarLabel.swift
//  countdown-bar
//
//  Created by Kolbe Bauer on 2/27/26.
//

internal import SwiftUI

struct MenuBarLabel: View {
    @EnvironmentObject var store: CountdownStore

    var nearest: Countdown? {
        store.countdowns.first { !$0.isExpired }
    }

    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "timer")
            if let c = nearest {
                Text(c.formattedTimeRemaining)
                    .font(.system(size: 12, weight: .medium, design: .monospaced))
            }
        }
    }
}
