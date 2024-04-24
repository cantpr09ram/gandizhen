//
//  EarthquakeDetail.swift
//  gandizhen
//
//  Created by \u8b19 on 4/24/24.
//

import SwiftUI
import MapKit

struct EarthquakeDetail: View {
    var earthquake: Earthquake
    @State private var cameraPosition: MapCameraPosition = .automatic
    var body: some View {
        ScrollView {
            VStack (alignment: .leading){
                Text("\(earthquake.EarthquakeInfo.OriginTime)")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Divider()
                Text("\(String(format: "%.0f", earthquake.EarthquakeInfo.EarthquakeMagnitude.MagnitudeValue))")
                    .font(.system(size: 80))
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Text("\(earthquake.EarthquakeInfo.EarthquakeMagnitude.MagnitudeType)")
                    .font(.caption)
                    .fontWeight(.light)
                Text("\(earthquake.EarthquakeInfo.Epicenter.Location)")
                    .font(.caption2)
                
                HStack{
                    VStack (alignment: .leading, spacing: 6) {
                        Text(String(format: "%.1f", earthquake.EarthquakeInfo.FocalDepth))
                            .font(.system(size: 40))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Text("深度")
                            .font(.caption)
                            .fontWeight(.light)
                    }
                    Divider()
                    VStack(alignment: .leading, spacing: 6){
                        Text("\(earthquake.EarthquakeInfo.Epicenter.EpicenterLatitude)")
                            .font(.headline)
                        Text("\(earthquake.EarthquakeInfo.Epicenter.EpicenterLongitude)")
                            .font(.headline)
                    }
                    .padding(.leading, 20)
                }
            }
            .padding(EdgeInsets(top: -10, leading: 20, bottom: 5, trailing: 20))
            
            Map(position: $cameraPosition){
                Marker("", coordinate: CLLocationCoordinate2D(latitude: earthquake.EarthquakeInfo.Epicenter.EpicenterLatitude, longitude: earthquake.EarthquakeInfo.Epicenter.EpicenterLongitude))
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
            .frame(height: 350)
            .onAppear {
                let center  = CLLocationCoordinate2D(latitude: earthquake.EarthquakeInfo.Epicenter.EpicenterLatitude, longitude: earthquake.EarthquakeInfo.Epicenter.EpicenterLongitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
                let centerRegion = MKCoordinateRegion(center: center, span: span)
                cameraPosition = .region(centerRegion)
            }
            
            VStack(alignment: .leading) {
                Text("Intensity")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                //Text("\(earthquake.Intensity.ShakingArea.count)")
                List(earthquake.Intensity.ShakingArea) { shakingarea in
                    Text("\(shakingarea.AreaDesc)")
                }
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 5, trailing: 20))
        }
    }
}

#Preview {
    HistoryView()
}
