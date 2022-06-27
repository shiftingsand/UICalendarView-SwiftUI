//
//  ContentView.swift
//  UICalendarView SwiftUI
//
//  Created by Chris Wu on 6/27/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var allData : AllData
    @State var dateSelected : DateComponents?
    @State var showSheet = false
    
    var body: some View {
        CalendarView(interval: .init(
            start: Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: Date())))!, end: .now
        ), allData: allData, dateSelected: $dateSelected, showSheet: $showSheet)
        .sheet(isPresented: $showSheet) {
            TheSheet(dateSelected: $dateSelected)
                .presentationDetents([.medium, .large])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
