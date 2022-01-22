//
//  TwitterPostCell.swift
//  MoscowMetroTwitter
//
//  Created by Andrey Rusinovich on 19.01.2022.
//

import UIKit
import SwiftyJSON
import SwiftDate

class TwitterPostCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var twitterNameLabel: UILabel!
    @IBOutlet weak var twitterAliasLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func fillCell(post: JSON) {
        postTextLabel.text = post["text"].string
        commentsCountLabel.text = "0"
        retweetCountLabel.text = String(post["retweetCount"].intValue)
        favoriteCountLabel.text = String(post["favoriteCount"].intValue)
        
        let regionMS = Region(calendar: Calendar(identifier: .gregorian), zone: Zones.europeMoscow, locale: Locales.russian)
        let date = DateInRegion(milliseconds: post["createdAt"].int!, region: regionMS)
        
        dateLabel.text = "\(date.toFormat("dd.MM HH:mm", locale: Locales.russian))"
    }
    
    private func configureCell() {
        logoImage.layer.cornerRadius = 20
        twitterAliasLabel.textColor = .gray
    }
}
