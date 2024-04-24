//
//  HistoryData.swift
//  gandizhen
//
//  Created by \u8b19 on 4/24/24.
//
// source = https:// scweb.cwa.gov.tw/zh-tw/earthquake/limit

import Foundation
import Combine

class HistoryViewModel: ObservableObject {
    @Published var earthquakes: [Earthquake] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchAndUpdateData() {
        let urlString = "https://opendata.cwa.gov.tw/api/v1/rest/datastore/E-A0015-001?limit=100&format=JSON"
        guard let url = URL(string: urlString) else {
            self.errorMessage = "Invalid URL"
            return
        }
        var apikey = "YOUR_API_KEY"
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue(apikey, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"

        self.isLoading = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
                guard let data = data, error == nil else {
                    self.errorMessage = "Network error: \(String(describing: error))"
                    return
                }

                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                    self.errorMessage = "HTTP error status: \(httpResponse.statusCode)"
                    return
                }

                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(EarthquakeData.self, from: data)
                    print("hi")
                    self.earthquakes = result.records.Earthquake
                    print(self.earthquakes)
                    self.errorMessage = nil
                } catch {
                    self.errorMessage = "Error decoding JSON: \(error)"
                }
            }
        }.resume()
    }
}

