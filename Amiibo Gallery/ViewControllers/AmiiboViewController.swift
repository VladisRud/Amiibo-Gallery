//
//  AmiiboViewController.swift
//  Amiibo Gallery
//
//  Created by Влад Руденко on 21.05.2024.
//

import UIKit

final class AmiiboViewController: UIViewController {
    
    //MARK: - Properties
    var amiiboImageURL = ""
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        doConstrains()
        fetchImageAF()
    }
    
    //MARK: - UI Elements
    let amiiboImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
}

private extension AmiiboViewController {
    //MARK: - Set Up UI
    func setUpView() {
        view.addSubview(amiiboImage)
        view.backgroundColor = .systemBackground
    }
    
    func doConstrains() {
        NSLayoutConstraint.activate([
            amiiboImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amiiboImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            amiiboImage.heightAnchor.constraint(equalToConstant: 300),
            amiiboImage.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
    
    //MARK: - Network
    func fetchImageAF() {
        NetworkManager.shared.fetchImageAF(from: amiiboImageURL) { [unowned self] result in
            switch result {
            case .success(let imageData):
                self.amiiboImage.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
