//
//  DataModel.swift
//  gandizhen
//
//  Created by \u8b19 on 4/24/24.
//

import Foundation

import Foundation

// Define Earthquake related structures
struct EarthquakeData: Codable {
    let success: String
    let result: Result
    let records: Records
}

struct Result: Codable {
    let resource_id: String
    let fields: [Field]
}

struct Field: Codable {
    let id: String
    let type: String
}

struct Records: Codable {
    let datasetDescription: String
    let Earthquake: [Earthquake]
}

struct Earthquake: Codable, Identifiable {
    var id: Int
    let ReportType, ReportColor, ReportContent: String
    let ReportImageURI, Web, ShakemapImageURI : String
    let EarthquakeInfo: EarthquakeInfo
    let Intensity: Intensity
    
    enum CodingKeys: String, CodingKey {
        case id = "EarthquakeNo"  // Mapping 'EarthquakeNo' from JSON to 'id' property
        case ReportType = "ReportType"
        case ReportColor = "ReportColor"
        case ReportContent = "ReportContent"
        case ReportImageURI = "ReportImageURI"
        case Web = "Web"
        case EarthquakeInfo = "EarthquakeInfo"
        case Intensity = "Intensity"
        case ShakemapImageURI = "ShakemapImageURI"
    }
}

struct EarthquakeInfo: Codable {
    let OriginTime: String
    let Source: String
    let FocalDepth: Double
    let Epicenter: Epicenter
    let EarthquakeMagnitude: EarthquakeMagnitude
}

struct Epicenter: Codable {
    let Location: String
    let EpicenterLatitude, EpicenterLongitude: Double
}

struct EarthquakeMagnitude: Codable {
    let MagnitudeType: String
    let MagnitudeValue: Double
}

struct Intensity: Codable {
    let ShakingArea: [ShakingArea]
}

struct ShakingArea: Codable, Identifiable {
    var id: String
    let AreaDesc, AreaIntensity: String
    enum CodingKeys: String, CodingKey {
        case id = "CountyName"
        case AreaDesc = "AreaDesc"
        case AreaIntensity = "AreaIntensity"
        
    }
    //let EqStation: [EqStation]
}

//struct EqStation: Codable {
//    let StationName, StationID: String
//    let InfoStatus: String
//    let BackAzimuth, EpicenterDistance: Double
//    let SeismicIntensity: String  // Changed from Double to String
//    let StationLatitude, StationLongitude: Double
//    let WaveImageURI: String?
//    let pga, pgv: SeismicData?
//}
//
//struct SeismicData: Codable {
//    let unit: String
//    let EWComponent, NSComponent, VComponent, IntScaleValue: Double
//}
