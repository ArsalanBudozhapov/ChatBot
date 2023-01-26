//
//  ChatTextFieldView.swift
//  ChatBot
//
//  Created by мак on 26.01.2023.
//

import UIKit

class ChatTextFieldView: UIView {

    private let textField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 0, width: 345, height: 60))
        textField.layer.cornerRadius = 24
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.08).cgColor
        textField.placeholder = "Write your message"
        textField.clearButtonMode = .whileEditing
        textField.autocorrectionType = .default
        textField.returnKeyType = .send
        textField.backgroundColor = #colorLiteral(red: 0.1552174389, green: 0.2194670439, blue: 0.2882269621, alpha: 1)
        return textField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sendImage2"), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
