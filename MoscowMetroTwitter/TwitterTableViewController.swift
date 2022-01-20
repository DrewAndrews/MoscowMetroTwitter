//
//  TwitterTableViewController.swift
//  MoscowMetroTwitter
//
//  Created by Andrey Rusinovich on 19.01.2022.
//

import UIKit
import SwiftyJSON

class TwitterTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadPosts()

        self.tableView.largeContentTitle = "News"
        tableView.rowHeight = UITableView.automaticDimension
        
        self.tableView.separatorStyle = .none
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TwitterPostCell", owner: self, options: nil)?.first as! TwitterPostCell

        // Configure the cell...

        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    //MARK: - Network
    
    func loadPosts() {
        let url = URL(string: "https://devapp.mosmetro.ru/api/tweets/v1.0/")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            if let rawData = data, let data = try? JSON(data: rawData)["data"] {
                print(data)
            }
        }.resume()
    }
}
