//
//  UICalendarView_SwiftUIApp.swift
//  UICalendarView SwiftUI
//
//  Created by Chris Wu on 6/27/22.
//

import SwiftUI

@main
struct UICalendarView_SwiftUIApp: App {
    @StateObject var allData : AllData
    
    init() {
        self._allData = StateObject(wrappedValue: AllData())
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(allData)
        }
    }
}
