//
//  QuestionTableViewCell.swift
//  ChatBot
//
//  Created by мак on 26.01.2023.
//

import Foundation
import UIKit

class ChatTableViewCell: UITableViewCell {

    var image: UIImageView = {
        let image = UIImageView(image: UIImage(named: "robot"))
        
        return image
    }()
    
    let text: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 1, green: 0.9921568627, blue: 0.9921568627, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(image)
        contentView.addSubview(text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        image.frame = CGRect(x: contentView.frame.width, y: 0, width: 32, height: 32)
        text.frame = CGRect(x: 0, y: 0, width: 150, height: contentView.frame.height)

    }
}
