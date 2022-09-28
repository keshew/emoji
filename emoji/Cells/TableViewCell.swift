//
//  TableViewCell.swift
//  emoji
//
//  Created by Артём Коротков on 28.09.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

 
    @IBOutlet weak var emojiLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    func set(with object: Emoji) {
        self.emojiLabel.text = object.emoji
        self.nameLabel.text = object.name
        self.descLabel.text = object.description
    }
    
}
