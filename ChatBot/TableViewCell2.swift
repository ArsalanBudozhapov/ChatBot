//
//  TableViewCell2.swift
//  ChatBot
//
//  Created by epmvito on 25.01.2023.
//

import UIKit

class TableViewCell2: UITableViewCell {
    
    
    @IBOutlet weak var iconRowSettings2: UIImageView!
    
    @IBOutlet weak var titleRowSettings2: UILabel!
    
    @IBOutlet weak var backIconRowSettings2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
