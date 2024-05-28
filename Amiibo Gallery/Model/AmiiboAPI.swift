//
//  AmiiboAPI.swift
//  Amiibo Gallery
//
//  Created by Влад Руденко on 11.05.2024.
//

import Foundation

struct GameSeries: Codable {
    let key: String
    let name: String
    
    init(data: [String: Any]) {
        self.key = data["key"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
    }
    
    static func getGameSeries(from jsonValue: Any) -> [GameSeries] {
        guard let amiibo = jsonValue as? [String: Any] else { return [] }
        guard let listAmiibo = amiibo["amiibo"] as? [[String: Any]] else { return [] }
        
        var gameSeries: [GameSeries] = []
        
        for dataGM in listAmiibo {
            let gameSerie = GameSeries(data: dataGM)
            gameSeries.append(gameSerie)
        }
        print(type(of: gameSeries))
        
        return gameSeries
    }
    
}

struct CharactersList: Codable {
    let amiiboSeries: String
    let character: String
    let gameSeries: String
    let head: String
    let image: String
    let name: String
    let release: Release
    let tail, type: String
    
    init(data: [String: Any]) {
        self.amiiboSeries = data["amiiiboSeries"] as? String ?? ""
        self.character = data["character"] as? String ?? ""
        self.gameSeries = data["gameSeries"] as? String ?? ""
        self.head = data["head"] as? String ?? ""
        self.image = data["image"] as? String ?? ""
        self.name = data["name"] as? String ?? ""
        self.release = data["release"] as? Release ?? Release(au: nil,
                                                              eu: nil,
                                                              jp: nil,
                                                              na: nil)
        self.tail = data["tail"] as? String ?? ""
        self.type = data["type"] as? String ?? ""
    }
    
    static func getCharactersList(from jsonValue: Any) -> [CharactersList] {
        guard let amiibo = jsonValue as? [String: Any] else { return [] }
        guard let listAmiibo = amiibo["amiibo"] as? [[String: Any]] else { return [] }
        
        var charactersList: [CharactersList] = []
        
        for character in listAmiibo {
            let characters = CharactersList(data: character)
            charactersList.append(characters)
        }
        
        return charactersList
    }
    
}

struct Release: Codable {
    let au, eu, jp, na: String?
    
    init(au: String?, 
         eu: String?,
         jp: String?,
         na: String?)
    {
        self.au = au
        self.eu = eu
        self.jp = jp
        self.na = na
    }
    
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


