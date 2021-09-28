//
//  StoreItem.swift
//  iTunesSearch
//
//  Created by Eric Davis on 28/09/2021.
//

import Foundation



struct StoreItem: Codable {
    var name: String
    var artist: String
//    var kinder: String
    var description: String
    var artwork: URL
    
    enum CodingKeys: String, CodingKey {
        case name = "trackName"
        case artist = "artistName"
//        case kinder = "kind"
        case description
        case artwork = "artworkUrl100"
    }
    
    enum AdditionalKeys: CodingKey {
        case longDescription
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: CodingKeys.name)
        artist = try values.decode(String.self, forKey: CodingKeys.artist)
//        kinder = try values.decode(String.self, forKey: CodingKeys.kinder)
        artwork = try values.decode(URL.self, forKey: CodingKeys.artwork)
        
        if let description = try? values.decode(String.self, forKey: CodingKeys.description) {
            self.description = description
        } else {
            let additionalValues = try decoder.container(keyedBy: AdditionalKeys.self)
            description = (try? additionalValues.decode(String.self, forKey: AdditionalKeys.longDescription)) ?? ""
        }
    }
}
