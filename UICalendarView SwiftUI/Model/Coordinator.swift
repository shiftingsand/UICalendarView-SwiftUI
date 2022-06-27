//
//  Coordinator.swift
//  UICalendarView SwiftUI
//
//  Created by Chris Wu on 6/27/22.
//

import SwiftUI

class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    var parent: CalendarView
    @ObservedObject var allData : AllData
    @Binding var dateSelected : DateComponents?
    @Binding var showSheet : Bool
    
    // Your database implementation goes here.
    init(_ calendarStuff: CalendarView, allData : ObservedObject<AllData>, dateSelected: Binding<DateComponents?>, showSheet: Binding<Bool>) {
        parent = calendarStuff
        self._allData = allData
        self._dateSelected = dateSelected
        self._showSheet = showSheet
    }
    
    // Create and return calendar decorations here.
    @MainActor func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        guard let foundEvent = allData.calendarData.filter({ $0.dateStuff.sameDate(source: dateComponents)}).first else {
            return nil
        }
        
        if dateComponents.date ?? Date() > Date() {
            return nil
        } else {
            if .work == foundEvent.eventType || foundEvent.emoji.isEmpty {
                return .default(color: .systemMint)
            } else {
                return .customView {
                    let emoji = UILabel()
                    emoji.text = foundEvent.emoji
                    return emoji
                }
            }
        }
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        dateSelected = dateComponents
        
        if let dateComponents,
           let _ = allData.calendarData.first(where: { oneDay in
               oneDay.dateStuff.sameDate(source: dateComponents)
           }) {
            showSheet.toggle()
        }
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
}
