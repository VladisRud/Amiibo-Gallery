//
//  AmiiboAPI.swift
//  Amiibo Gallery
//
//  Created by Влад Руденко on 11.05.2024.
//

import Foundation

struct AmiiboAPIGameSeries: Codable {
    let amiibo: [GameSeries]
}

struct GameSeries: Codable {
    let key: String
    let name: String
}

struct AmiiboAPIListCharacters: Codable {
    let amiibo: [charactersList]
}

struct charactersList: Codable {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: String
    let name: String
    let release: Release
    let tail, type: String
}

struct Release: Codable {
    let au, eu, jp, na: String?
}

enum Links {
    case gameSeriesURL
    case characterList
    
    var url: URL {
        switch self {
        case .gameSeriesURL:
            return URL(string: "https://amiiboapi.com/api/gameseries/")!
        case .characterList:
            return URL(string: "https://amiiboapi.com/api/amiibo/?name&gameseries=")!
        }
    }
}


