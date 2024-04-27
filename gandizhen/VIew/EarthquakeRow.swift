//
//  EarthquakeRow.swift
//  gandizhen
//
//  Created by \u8b19 on 4/24/24.
//

import SwiftUI

struct EarthquakeRow: View {
    var earthquake: Earthquake
    
    var body: some View {
        HStack {
            AsyncImage(
                url: URL(string: earthquake.ShakemapImageURI),
              content: { image in
                  image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                }, placeholder: {
                  Color.gray
                }
            )
              .frame(width: 100, height: 100)
              .mask(RoundedRectangle(cornerRadius: 10))
            VStack (alignment: .leading){
                Text("\(earthquake.id)")
                Text("\(earthquake.EarthquakeInfo.OriginTime)")
                    .font(.caption2)
                Text(String(format: "Depth : %.1f", earthquake.EarthquakeInfo.FocalDepth))
                    .font(.caption2)
                Text("\(earthquake.EarthquakeInfo.Epicenter.Location)")
                    .font(.caption2)
                
            }
            Spacer()
            Text("\(String(format: "%.0f", earthquake.EarthquakeInfo.EarthquakeMagnitude.MagnitudeValue))")
                .font(.system(size: 60))
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    HistoryView()
}
