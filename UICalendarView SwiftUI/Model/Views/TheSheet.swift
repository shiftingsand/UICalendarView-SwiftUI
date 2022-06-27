//
//  TheSheet.swift
//  firstChart
//
//  Created by Chris Wu on 6/13/22.
//

import SwiftUI

struct TheSheet: View {
    @EnvironmentObject var allData : AllData
    @Environment(\.dismiss) var dismiss
    
    @Binding var dateSelected : DateComponents?
    
    var body: some View {
        NavigationView {
            ZStack {
                if let dateSelected,
                   let foundIndex = findTheIndex(dateSelected: dateSelected) {
                    let found = allData.calendarData[foundIndex]
                    VStack {
                        Text("\(found.emoji)")
                            .font(.system(size: 100))
                        if let dater = dateSelected.date {
                            Text("Date: \(dater.formatted(date: .long, time: .omitted))")
                        }
                        Text("Category: \(found.eventType.rawValue)")
                        Text("Note: \(found.note)")
                            .font(.largeTitle)
                            .bold()
                    }
                    .padding(.horizontal)
                } else {
                    Text("Empty")
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Label("Cancel", systemImage: "xmark.circle")
                    }
                    
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        Button {
                            if let foundIndex = findTheIndex(dateSelected: dateSelected) {
                                print("changing it")
                                let newEmojiChoices = ["🥵", "😎", "🤣", "🥶"]
                                let oldEmoji = allData.calendarData[foundIndex].emoji
                                var newEmoji = newEmojiChoices.randomElement()!
                                
                                while oldEmoji == newEmoji {
                                    newEmoji = newEmojiChoices.randomElement()!
                                }
                                
                                allData.calendarData[foundIndex].emoji = newEmoji
                                
                                // In addition to changing the element we also set it on the model so we can update the UI in the coordinator
                                allData.changedData = allData.calendarData[foundIndex]
                                
                                dismiss()
                            }
                        } label: {
                            Label("Change", systemImage: "pencil")
                        }
                        
                        Button {
                            print("push delete")
                            
                            if let foundIndex = findTheIndex(dateSelected: dateSelected) {
                                print("deleting it")
                                
                                // In addition to removing the element we also set it on the model so we can update the UI in the coordinator
                                allData.changedData = allData.calendarData.remove(at: foundIndex)
                                dismiss()
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    } label: {
                        Text("Menu")
                    }
                }
            }
        }
    }
    
    func findTheIndex(dateSelected : DateComponents?) -> Int? {
        var returnVal : Int? = nil
        
        if let dateSelected,
           let foundIndex = allData.calendarData.firstIndex(where: { oneData in
               if let lhsDate = oneData.dateStuff.date,
                  let rhsDate = dateSelected.date,
                  Calendar.current.startOfDay(for: lhsDate) == Calendar.current.startOfDay(for: rhsDate) {
                   return true
               } else {
                   return false
               }
           }) {
            returnVal = foundIndex
        }
        
        return returnVal
    }
}

//struct TheSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        TheSheet()
//    }
//}
