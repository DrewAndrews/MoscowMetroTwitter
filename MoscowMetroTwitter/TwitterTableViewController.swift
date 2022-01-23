//
//  TwitterTableViewController.swift
//  MoscowMetroTwitter
//
//  Created by Andrey Rusinovich on 19.01.2022.
//

import UIKit
import SwiftyJSON
import SafariServices

class TwitterTableViewController: UITableViewController {
    
    var posts: [JSON] = []
    var spinner = UIActivityIndicatorView(style: .medium)
    
    enum Props {
        case loading
        case error
        case loaded(data: [JSON])
    }
    
    var props: Props = .loading {
        willSet {
            switch newValue {
            case .loading:
                spinner.startAnimating()
                loadPosts()
            case .error:
                let networkErrorViewController = NetworkErrorViewController(nibName: "NetworkErrorViewController", bundle: .main)
                self.navigationController?.pushViewController(networkErrorViewController, animated: true)
            case .loaded(let data):
                spinner.stopAnimating()
                self.posts = data
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibForTwitterPost = UINib(nibName: "TwitterPostCell", bundle: nil)
        let nibForOfficialTwitter = UINib(nibName: "OfficialTwitterAccountCell", bundle: nil)
        
        tableView.register(nibForTwitterPost, forCellReuseIdentifier: "TwitterPostCell")
        tableView.register(nibForOfficialTwitter, forCellReuseIdentifier: "OfficialAccountCellId")
        
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        tableView.addSubview(spinner)
        
        self.tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !NetworkMonitor.shared.isConnected {
            props = .error
        } else {
            props = .loading
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "OfficialAccountCellId") as? OfficialTwitterAccountCell else { return UITableViewCell() }
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TwitterPostCell") as? TwitterPostCell else { return UITableViewCell() }
            cell.fillCell(post: posts[indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 112
        }
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else { return }
        
        let id = posts[indexPath.row]["id"].intValue
        let url = URL(string: "https://mobile.twitter.com/MetroOperativno/status/\(id)")!
        
        let safari = SFSafariViewController(url: url)
        self.present(safari, animated: true)
    }
    
    //MARK: - Network
    
    func loadPosts() {
        let url = URL(string: "https://devapp.mosmetro.ru/api/tweets/v1.0/")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let rawData = data, let data = try? JSON(data: rawData)["data"].array {
                DispatchQueue.main.async {
                    self.props = .loaded(data: data)
                }
            }
        }.resume()
    }
}
