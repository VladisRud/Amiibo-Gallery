//
//  CharactersTableViewController.swift
//  Amiibo Gallery
//
//  Created by Влад Руденко on 21.05.2024.
//

import UIKit

final class CharactersTableViewController: UITableViewController {
    
    //MARK: - Properties
    var gameSerie = ""
    private var listAmiiboCharacters: [charactersList] = []
    private let characterListURL = Links.characterList.url
    private let networkManager = NetworkManager.shared
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacters()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "character")
        
    }

    // MARK: - TableView DataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listAmiiboCharacters.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "character", for: indexPath)
        cell.textLabel?.font = .init(name: "Verdana", size: 20)
        cell.textLabel?.text = listAmiiboCharacters[indexPath.row].name
        return cell
    }
    
    //MARK: - TableView Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let amiiboVC = AmiiboViewController()
        amiiboVC.amiiboImageURL = listAmiiboCharacters[indexPath.row].image
        show(amiiboVC, sender: self)
    }
    
}

private extension CharactersTableViewController {
    //MARK: - Network
    func fetchCharacters() {
        networkManager.fetch(AmiiboAPIListCharacters.self, gameSeriesName: gameSerie, gameSeriesFrom: characterListURL) { [weak self] result in
            switch result {
            case .success(let listCharacters):
                self?.listAmiiboCharacters = listCharacters.amiibo
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(_):
                print("No Data")
            }
        }
    }
}
