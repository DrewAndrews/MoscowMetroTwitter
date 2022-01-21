//
//  OfficialTwitterAccountCell.swift
//  MoscowMetroTwitter
//
//  Created by Andrey Rusinovich on 20.01.2022.
//

import UIKit

class OfficialTwitterAccountCell: UITableViewCell {
    
    @IBOutlet weak var moscowMetroLabel: UILabel!
    @IBOutlet weak var verifiedLogoImage: UIImageView!
    @IBOutlet weak var moscowMetroLogo: UIImageView!
    @IBOutlet weak var twitterAliasLabel: UILabel!
    @IBOutlet weak var officialTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func configureCell() {
        moscowMetroLogo.layer.cornerRadius = 20
    }
}
