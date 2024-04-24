//
//  HistoryVIew.swift
//  gandizhen
//
//  Created by \u8b19 on 4/24/24.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel = HistoryViewModel()

    var body: some View {
        HStack {
            NavigationSplitView {
//                if viewModel.isLoading {
//                    ProgressView()
//                } else if let errorMessage = viewModel.errorMessage {
//                    Text(errorMessage)
//                } else if viewModel.earthquakes.isEmpty {
//                    Text("No data available")
//                } else {
//
//                }
                List(viewModel.earthquakes) { earthquake in
                    NavigationLink {
                        EarthquakeDetail(earthquake: earthquake)
                    } label: {
                        EarthquakeRow(earthquake: earthquake)
                    }
                }
                .navigationTitle("History")
                
            } detail: {
                Text("Select a Landmark")
            }
        }
        .onAppear{
            viewModel.fetchAndUpdateData()
        }
    }
}


#Preview {
    HistoryView()
}
