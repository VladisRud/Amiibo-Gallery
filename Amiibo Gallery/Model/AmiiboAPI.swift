//
//  AmiiboAPI.swift
//  Amiibo Gallery
//
//  Created by Влад Руденко on 11.05.2024.
//

import Foundation

enum Links {
    case gameSeriesURL
    
    var url: URL {
        switch self {
        case .gameSeriesURL:
            return URL(string: "https://amiiboapi.com/api/gameseries/")!
        }
    }
}

struct AmiiboAPIGameSeries: Codable {
    let amiibo: [GameSeries]
}

struct GameSeries: Codable {
    let key: String
    let name: String
}


