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

    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGameSeries()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    }

    //MARK: - TableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGameSeries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = listGameSeries[indexPath.row]

        return cell
    }

}


//MARK: - Networking
private extension GameSeriesTableView {
    func fetchGameSeries() {
        URLSession.shared.dataTask(with: Links.gameSeriesURL.url) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            let decoder = JSONDecoder()
            do {
                let franchises = try decoder.decode(AmiiboAPIGameSeries.self, from: data)
                print(franchises)
                self.listGameSeries = self.sortGameSeries(from: franchises)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }.resume()
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
