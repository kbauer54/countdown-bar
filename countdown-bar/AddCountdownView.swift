//
//  AddCountdownView.swift
//  countdown-bar
//
//  Created by Kolbe Bauer on 2/27/26.
//

internal import SwiftUI

struct AddCountdownView: View {
    @EnvironmentObject var store: CountdownStore
    @Environment(\.dismiss) var dismiss

    @State private var name = ""
    @State private var date = Date().addingTimeInterval(86400)

    var body: some View {
        VStack(spacing: 20) {
            Text("New Countdown")
                .font(.title2.bold())

            TextField("Name (e.g. Vacation)", text: $name)
                .textFieldStyle(.roundedBorder)

            DatePicker("Target Date", selection: $date, displayedComponents: [.date, .hourAndMinute])
                .labelsHidden()

            HStack {
                Button("Cancel") { dismiss() }
                    .keyboardShortcut(.escape)
                Spacer()
                Button("Add") {
                    let c = Countdown(name: name, targetDate: date)
                    store.add(c)
                    dismiss()
                }
                .keyboardShortcut(.return)
                .disabled(name.isEmpty)
            }
        }
        .padding(24)
        .frame(width: 320)
        .onAppear {
            NSApp.activate(ignoringOtherApps: true)
        }
    }
}
