//
//  CurrentView.swift
//  gandizhen
//
//  Created by \u8b19 on 4/24/24.
//

import SwiftUI

struct CurrentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Current")
        }
        .padding()
    }
}

#Preview {
    CurrentView()
}
