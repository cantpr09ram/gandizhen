//
//  ContentView.swift
//  gandizhen
//
//  Created by \u8b19 on 4/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            CurrentView()
                .tabItem {
                    Label("Now", systemImage: "figure.walk.motion.trianglebadge.exclamationmark")
                }
            HistoryView()
                .badge("!")
                .tabItem {
                    Label("History", systemImage: "calendar")
                }
        }
    }
}

#Preview {
    ContentView()
}
