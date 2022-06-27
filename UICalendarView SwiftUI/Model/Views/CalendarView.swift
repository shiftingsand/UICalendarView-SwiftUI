//
//  CalendarView.swift
//  UICalendarView SwiftUI
//
//  Created by Chris Wu on 6/27/22.
//

import SwiftUI

struct CalendarView : UIViewRepresentable {
    let interval : DateInterval
    @ObservedObject var allData : AllData
    @Binding var dateSelected : DateComponents?
    @Binding var showSheet : Bool
    
    func makeCoordinator() -> Coordinator {
        // Create an instance of Coordinator
        Coordinator(self, allData: _allData, dateSelected: $dateSelected, showSheet: $showSheet)
    }
    
    func makeUIView(context: Context) -> some UICalendarView {
        let view = UICalendarView()
        
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        // https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-modifiers-for-a-uiviewrepresentable-struct
        
        // If an element was removed, we'll tell the calendar to update the relevant cell and set the element to nil on the model so we don't try to do this again inadvertently
        if let removedData = allData.changedData {
            uiView.reloadDecorations(forDateComponents: [removedData.dateStuff], animated: true)
            allData.changedData = nil
        }
    }
}
