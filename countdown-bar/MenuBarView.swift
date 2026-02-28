//
//  MenuBarView.swift
//  countdown-bar
//
//  Created by Kolbe Bauer on 2/27/26.
//

internal import SwiftUI
import Combine

struct MenuBarView: View {
    @EnvironmentObject var store: CountdownStore
    @State private var showingAdd = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var tick = false

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("Countdowns")
                    .font(.headline)
                    .padding(.leading)
                Spacer()
                Button(action: { showingAdd = true }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.plain)
                .padding(.trailing)
            }
            .padding(.vertical, 10)

            Divider()

            if store.countdowns.isEmpty {
                Text("No countdowns yet.")
                    .foregroundColor(.secondary)
                    .padding()
            } else {
                ForEach(store.countdowns) { countdown in
                    CountdownRow(countdown: countdown)
                    Divider()
                }
            }

            Divider()

            Button("Quit CountdownBar") {
                NSApplication.shared.terminate(nil)
            }
            .padding(10)
        }
        .frame(width: 300)
        .onReceive(timer) { _ in tick.toggle() }
        .sheet(isPresented: $showingAdd) {
            AddCountdownView()
                .environmentObject(store)
        }
    }
}

struct CountdownRow: View {
    let countdown: Countdown

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(countdown.name)
                    .font(.system(size: 13, weight: .semibold))
                Text(countdown.targetDate.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Text(countdown.formattedTimeRemaining)
                .font(.system(size: 12, design: .monospaced))
                .foregroundColor(countdown.isExpired ? .red : .green)
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}
