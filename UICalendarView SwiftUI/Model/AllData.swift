//
//  AllData.swift
//  firstChart
//
//  Created by Chris Wu on 6/12/22.
//

import Foundation

enum EventType : String, Identifiable {
    case party, work, wuNone, themePark
    
    var id : String {
        return self.rawValue
    }
}

struct MyData {
    let eventType : EventType
    var emoji : String
    let dateStuff : DateComponents
    var note : String
    
    init(eventType: EventType, emoji: String, dateStuff: DateComponents, note: String) {
        self.eventType = eventType
        self.emoji = emoji
        self.dateStuff = dateStuff
        self.note = note
    }
    
    init(eventType: EventType, emoji: String, dateStuff: DateComponents) {
        self.eventType = eventType
        self.emoji = emoji
        self.dateStuff = dateStuff
        self.note = ""
    }
}

@MainActor
final class AllData : ObservableObject {
    @Published var calendarData = [MyData]()
    @Published var changedData: MyData?
    
    init() {
        self.calendarData = populateDatabase2()
    }

    func populateDatabase2() -> [MyData] {
        var returnVals = [MyData]()
        var component = DateComponents()
        component.timeZone = TimeZone.current
        component.month = 6
        component.day = 2
        component.year = 2022
        component.calendar = Calendar(identifier: .gregorian)
        
        returnVals.append(MyData(eventType: .party, emoji: "🐢", dateStuff: component, note: "Turtles know how to party!"))
        
        print("i made a date of \(String(describing: component.date))")
        
        component.day = 7
        returnVals.append(MyData(eventType: .party, emoji: "🧋", dateStuff: component, note: "All boba all the time!"))

        component.day = 5
        returnVals.append(MyData(eventType: .work, emoji: "", dateStuff: component, note: "Work is work."))
        
        component.day = 10
        returnVals.append(MyData(eventType: .themePark, emoji: "🎡", dateStuff: component, note: "Go to Disney World!"))
        
        return returnVals
    }
}
