//
//  DateComponentsExtensions.swift
//  UICalendarView SwiftUI
//
//  Created by Chris Wu on 6/27/22.
//

import Foundation

extension DateComponents {
    func sameDate(source: DateComponents) -> Bool {
        if let lhs = self.date,
           let rhs = source.date,
           Calendar.current.startOfDay(for: lhs) == Calendar.current.startOfDay(for: rhs) {
            return true
        } else {
            return false
        }
    }
}
