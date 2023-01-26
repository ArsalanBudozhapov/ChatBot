//
//  TableViewCell.swift
//  ChatBot
//
//  Created by epmvito on 25.01.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
   
    @IBOutlet weak var iconRowSettings: UIImageView!
    @IBOutlet weak var titleRowSettings: UILabel!
    @IBOutlet weak var backIconRowSettings: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
