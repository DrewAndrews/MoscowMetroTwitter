//
//  NetworkErrorViewController.swift
//  MoscowMetroTwitter
//
//  Created by Andrey Rusinovich on 22.01.2022.
//

import UIKit

class NetworkErrorViewController: UIViewController {
    
    @IBOutlet weak var crossImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var retryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.title = "Новости"
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        retryButton.layer.cornerRadius = 8
    }

    @IBAction func retry(_ sender: UIButton) {
        if NetworkMonitor.shared.isConnected {
            self.navigationController?.popViewController(animated: true)
        }
    }
}
