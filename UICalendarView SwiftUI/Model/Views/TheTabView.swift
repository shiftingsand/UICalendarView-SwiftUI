//
//  TheTabView.swift
//  firstChart
//
//  Created by Chris Wu on 6/13/22.
//

import SwiftUI

enum TabName {
    case record, history, reports, more, calendar
}

struct TheTabView: View {
    @State private var selectedTab : TabName = TabName.calendar
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ContentView()
                .tabItem {
                    Label("Calendar", systemImage: "calendar")
                }.tag(TabName.calendar)
            Text("More")
                .tabItem {
                    Label("More", systemImage: "questionmark.app")
                }.tag(TabName.more)
        }
    }
}

struct TheTabView_Previews: PreviewProvider {
    static var previews: some View {
        TheTabView()
    }
}
