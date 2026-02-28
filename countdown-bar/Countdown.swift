//
//  Countdown.swift
//  countdown-bar
//
//  Created by Kolbe Bauer on 2/27/26.
//

import Foundation

struct Countdown: Identifiable, Codable {
    var id = UUID()
    var name: String
    var targetDate: Date
    
    var timeRemaining: TimeInterval {
        targetDate.timeIntervalSinceNow
    }
    
    var isExpired: Bool {
        timeRemaining <= 0
    }
    
    var formattedTimeRemaining: String {
        guard !isExpired else {
            return "Expired"
        }
        let days = Int(timeRemaining) / 86400
        let hours = (Int(timeRemaining) % 86400) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60
        let seconds = Int(timeRemaining) % 60
        
        if days > 0 { return "\(days)d \(hours)h \(minutes)m"}
        if hours > 0 { return "\(hours)h \(minutes)m \(seconds)s"}
        return "\(minutes)m \(seconds)s"
    }
}
