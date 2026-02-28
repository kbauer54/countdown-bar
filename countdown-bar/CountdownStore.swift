//
//  CountdownStore.swift
//  countdown-bar
//
//  Created by Kolbe Bauer on 2/27/26.
//

import Foundation
import Combine
internal import SwiftUI

class CountdownStore: ObservableObject {
    @Published var countdowns: [Countdown] = [] {
        didSet { save() }
    }

    private let key = "countdowns"

    init() { load() }

    func add(_ countdown: Countdown) {
        countdowns.append(countdown)
        countdowns.sort { $0.targetDate < $1.targetDate }
    }

    func delete(at offsets: IndexSet) {
        countdowns.remove(atOffsets: offsets)
    }

    private func save() {
        let data = try? JSONEncoder().encode(countdowns)
        UserDefaults.standard.set(data, forKey: key)
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let saved = try? JSONDecoder().decode([Countdown].self, from: data)
        else { return }
        countdowns = saved
    }
}
