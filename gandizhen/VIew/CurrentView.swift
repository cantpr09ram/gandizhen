//
//  CurrentView.swift
//  gandizhen
//
//  Created by \u8b19 on 4/24/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct CurrentView: View {
    @ObservedObject var viewModel = HistoryViewModel()
    @StateObject var locationDataManager = LocationDataManager()
    @State private var cameraPosition: MapCameraPosition = .automatic
    var body: some View {
        ScrollView {
            switch locationDataManager.locationManager.authorizationStatus {
                case .authorizedWhenInUse:  // Location services are available.
                // Insert code here of what should happen when Location services are authorized
                VStack {
                    if (viewModel.earthquakes.count > 1 ) {
                        VStack (alignment: .leading){
                            Text("\(viewModel.earthquakes[0].EarthquakeInfo.OriginTime)")
                                .font(.title)
                                .fontWeight(.bold)
                            Divider()
                            
                            LazyHStack(spacing: 6){
                                VStack(alignment: .trailing) {
                                    Text("\(String(format: "%.0f", viewModel.earthquakes[0].EarthquakeInfo.EarthquakeMagnitude.MagnitudeValue))")
                                        .font(.system(size: 50))
                                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text("\(viewModel.earthquakes[0].EarthquakeInfo.EarthquakeMagnitude.MagnitudeType)")
                                        .font(.caption)
                                        .fontWeight(.light)
                                }
                                Spacer()
                                    .frame(width: 30)
                                VStack (alignment: .trailing) {
                                    Text(String(format: "%.0f", viewModel.earthquakes[0].EarthquakeInfo.FocalDepth))
                                        .font(.system(size: 50))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text("深度")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .offset(x: -10)
                                }
                                Spacer()
                                    .frame(width: 30)
                                VStack (alignment: .trailing) {
                                    Text(String(format: "%.0f",
                                                distance(
                                                    centerlongitude: viewModel.earthquakes[0].EarthquakeInfo.Epicenter.EpicenterLatitude,
                                                    centerlatitude: viewModel.earthquakes[0].EarthquakeInfo.Epicenter.EpicenterLongitude,
                                                    nowlongitude: locationDataManager.locationManager.location?.coordinate.longitude.magnitude ?? 0.0,
                                                    nowlatitude: locationDataManager.locationManager.location?.coordinate.latitude.magnitude ?? 0.0
                                                )
                                            )
                                    )
                                        .font(.system(size: 50))
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                    Text("KM")
                                        .font(.caption)
                                        .fontWeight(.light)
                                        .offset(x: -10)
                                }
                            }
                            .padding(EdgeInsets(top: -10, leading: 10, bottom: 0, trailing: 20))
                            
                        }
                        .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                        
                       
                            Map(){
                                Marker("", coordinate: CLLocationCoordinate2D(latitude: viewModel.earthquakes[0].EarthquakeInfo.Epicenter.EpicenterLatitude, longitude: viewModel.earthquakes[0].EarthquakeInfo.Epicenter.EpicenterLongitude))
                                Marker("hi", coordinate: CLLocationCoordinate2D(latitude: (locationDataManager.locationManager.location?.coordinate.latitude.magnitude ?? 0.0), longitude: (locationDataManager.locationManager.location?.coordinate.longitude.magnitude ?? 0.0)))
                            }
                            .padding(EdgeInsets(top: 0, leading: 10, bottom: 5, trailing: 10))
                            .frame(height: 400)
                    }
                }
                case .restricted, .denied:  // Location services currently unavailable.
                // Insert code here of what should happen when Location services are NOT authorized
                    Text("Current location data was restricted or denied.")
                case .notDetermined:        // Authorization not determined yet.
                    Text("Finding your location...")
                    ProgressView()
                default:
                    ProgressView()
            }
        }
        .padding()
        .onAppear{
            viewModel.fetchAndUpdateData()
        }
    }
}

func distance (centerlongitude: Double, centerlatitude: Double, nowlongitude: Double, nowlatitude: Double) -> Double{
    let location1 = CLLocation(latitude: centerlatitude, longitude: centerlatitude)
    let location2 = CLLocation(latitude: nowlatitude, longitude: nowlongitude)
    print(location1.distance(from: location2))
    return location1.distance(from: location2) / 1000  // returns distance in meters
}

#Preview {
    CurrentView()
}
