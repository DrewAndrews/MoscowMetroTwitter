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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        spinner.center = view.center
        spinner.hidesWhenStopped = true
        tableView.addSubview(spinner)
        
        self.tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !NetworkMonitor.shared.isConnected {
            let networkErrorViewController = NetworkErrorViewController(nibName: "NetworkErrorViewController", bundle: .main)
            self.navigationController?.pushViewController(networkErrorViewController, animated: true)
        } else {
            spinner.startAnimating()
            loadPosts()
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
            let cell = Bundle.main.loadNibNamed("OfficialTwitterAccountCell", owner: self, options: nil)?.first as! OfficialTwitterAccountCell
            cell.isUserInteractionEnabled = false
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("TwitterPostCell", owner: self, options: nil)?.first as! TwitterPostCell
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if posts.count != 0 {
            spinner.stopAnimating()
        }
    }
    
    
    //MARK: - Network
    
    func loadPosts() {
        let url = URL(string: "https://devapp.mosmetro.ru/api/tweets/v1.0/")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            if let rawData = data, let data = try? JSON(data: rawData)["data"].array {
                DispatchQueue.main.async {
                    self.posts = data
                    self.tableView.reloadData()
                }
            }
        }.resume()
    }
}
