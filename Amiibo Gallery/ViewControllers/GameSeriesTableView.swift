//
//  GameSeriesTableView.swift
//  Amiibo Gallery
//
//  Created by Влад Руденко on 11.05.2024.
//

import UIKit
import Alamofire

final class GameSeriesTableView: UITableViewController {
    
    //MARK: - Properties
    private var listGameSeries: [String] = []
    private let networkManager = NetworkManager.shared
    private let gameSeriesURL = Links.gameSeriesURL.url

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGameSeriesAF()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    //MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGameSeries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.font = .init(name: "Verdana", size: 20)
        cell.textLabel?.text = listGameSeries[indexPath.row]
        
        

        return cell
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let characterTVC = CharactersTableViewController()
        characterTVC.gameSerie = listGameSeries[indexPath.row]
        show(characterTVC, sender: self)
    }

}


//MARK: - Network
private extension GameSeriesTableView {
    func fetchGameSeriesAF() {
        networkManager.fetchGameSeriesAF(from: gameSeriesURL.absoluteString) { [unowned self] result in
            switch result {
            case .success(let amiiboData):
                self.listGameSeries = sortGameSeries(from: amiiboData)
                print(type(of: self.listGameSeries))
                tableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func sortGameSeries(from amiiboGM: [GameSeries]) -> [String] {
        var list: [String] = []
        for GM in 0...amiiboGM.count - 1 {
            list.append(amiiboGM[GM].name)
        }
        let returnList = Array(Set(list)).sorted()
        return returnList
    }
}
