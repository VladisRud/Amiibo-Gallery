//
//  Network Manager.swift
//  Amiibo Gallery
//
//  Created by Влад Руденко on 21.05.2024.
//

import Foundation
import Alamofire

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImageAF(from url: String, completion: @escaping (Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { responseData in
                switch responseData.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchGameSeriesAF(from url: String, completion: @escaping (Result<[GameSeries], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let jsonValue):
                    let listGM = GameSeries.getGameSeries(from: jsonValue)
                    completion(.success(listGM))
                    print(type(of: listGM))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchCharactersAF(from url: String, completion: @escaping (Result<[CharactersList], AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let jsonValue):
                    let listCH = CharactersList.getCharactersList(from: jsonValue)
                    completion(.success(listCH))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
}
