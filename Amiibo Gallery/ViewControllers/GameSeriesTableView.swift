//
//  GameSeriesTableView.swift
//  Amiibo Gallery
//
//  Created by Влад Руденко on 11.05.2024.
//

import UIKit

final class GameSeriesTableView: UITableViewController {
    
    //MARK: - Properties
    private var listGameSeries: [String] = []
    private let networkManager = NetworkManager.shared
    private let gameSeriesURL = Links.gameSeriesURL.url

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGameSeries()
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
    func fetchGameSeries() {
        networkManager.fetch(AmiiboAPIGameSeries.self, gameSeriesFrom: gameSeriesURL) { [weak self] result in
            switch result {
            case .success(let listGM):
                self?.listGameSeries = self!.sortGameSeries(from: listGM)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                print("No Data")
            }
        }
    }
    
    func sortGameSeries(from amiiboGM: AmiiboAPIGameSeries) -> [String] {
        var list: [String] = []
        for GM in 0...amiiboGM.amiibo.count - 1 {
            list.append(amiiboGM.amiibo[GM].name)
        }
        let returnList = Array(Set(list)).sorted()
        return returnList
    }
}
