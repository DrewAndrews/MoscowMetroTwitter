//
//  TwitterPostCell.swift
//  MoscowMetroTwitter
//
//  Created by Andrey Rusinovich on 19.01.2022.
//

import UIKit

class TwitterPostCell: UITableViewCell {

    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var twitterNameLabel: UILabel!
    @IBOutlet weak var twitterAliasLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func configureCell() {
        logoImage.layer.cornerRadius = 20
        twitterAliasLabel.textColor = .gray
        postTextLabel.text = "Движение на Солнцевской линии (8А) вводится в график."
    }
}
