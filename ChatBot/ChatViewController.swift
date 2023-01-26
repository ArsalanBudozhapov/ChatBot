//
//  ChatViewController.swift
//  ChatBot
//
//  Created by мак on 25.01.2023.
//

import UIKit

class ChatViewController: UIViewController {
    
    
    private var models = [String]()
    
    private let lowerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1170914695, green: 0.1740572751, blue: 0.2324690521, alpha: 1)
        return view
    }()

    private let textField: TextField = {
        let textField = TextField()
        textField.layer.cornerRadius = 24
        textField.attributedPlaceholder = NSAttributedString(
            string: "Write your message",
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        )
        textField.textColor = .white
        textField.tintColor = .white
        textField.clearButtonMode = .never
        textField.autocorrectionType = .no
        textField.returnKeyType = .send
        textField.backgroundColor = #colorLiteral(red: 0.1552174389, green: 0.2194670439, blue: 0.2882269621, alpha: 1)
        return textField
    }()
    
    private lazy var sendQuestionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sendImage2"), for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.08235294118, blue: 0.1176470588, alpha: 1)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.separatorColor = UIColor(red: 212/255, green: 212/255, blue: 216/255, alpha: 0.1)
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.estimatedRowHeight = 50
//        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.08235294118, blue: 0.1176470588, alpha: 1)
        setupViews()
        setupConstraints()
    }
    
    private func setupViews(){
        view.addSubview(chatTableView)
        view.addSubview(lowerView)
        setupLowerView()
//        view.addSubview(textField)
//        view.addSubview(sendQuestionButton)
    }
    
    private func setupLowerView(){
        lowerView.addSubview(textField)
        lowerView.addSubview(sendQuestionButton)
    }
    
    private func setupConstraints(){
        textField.translatesAutoresizingMaskIntoConstraints = false
        chatTableView.translatesAutoresizingMaskIntoConstraints = false
        sendQuestionButton.translatesAutoresizingMaskIntoConstraints = false
        lowerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
//            textField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
//            textField.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100.0),
//            textField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
//            textField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0),
            
            chatTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            chatTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            chatTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            chatTableView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 50+400),
            
//            sendQuestionButton.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -60),
//            sendQuestionButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
//            sendQuestionButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
//            sendQuestionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
//            sendQuestionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            sendQuestionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
            
            lowerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            lowerView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -125),
            lowerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            lowerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),

            textField.leftAnchor.constraint(equalTo: lowerView.leftAnchor, constant: 24),
            textField.topAnchor.constraint(equalTo: lowerView.topAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: lowerView.rightAnchor, constant: -24),
            textField.bottomAnchor.constraint(equalTo: lowerView.bottomAnchor, constant: -50),

            sendQuestionButton.leftAnchor.constraint(equalTo: textField.rightAnchor, constant: -24 - 24),
            sendQuestionButton.topAnchor.constraint(equalTo: textField.topAnchor, constant: 16),
            sendQuestionButton.rightAnchor.constraint(equalTo: textField.rightAnchor, constant: -24),
            sendQuestionButton.bottomAnchor.constraint(equalTo: textField.bottomAnchor, constant: -16),

            
        ])
    }
    
    private func sendQuestion(textField: UITextField) {
        if let text = textField.text {
            models.append(text)
            print(text)
            print("models: \(models.first)")
            APIManager.shared.getResponse(input: text) { [weak self] result in
                switch result {
                case .success(let output):
                    let modifiedOutput = self?.modifyOutput(output: output) ?? output
                    self?.models.append(modifiedOutput.trimmingCharacters(in: .newlines))
                    DispatchQueue.main.async {
                        self?.chatTableView.reloadData()
                        self?.textField.text = nil
                    }
                case .failure:
                    print("ERROR: Failed to get response from APIManager.")
                    DispatchQueue.main.async {
                        self?.textField.text = nil
                    }
                default:
                    print("Unknown result from APIManager get response in ViewController")
                    }
                }
            }
    }
    
    private func modifyOutput(output: String) -> String {
        var modifiedOutput: String = output.trimmingCharacters(in: .newlines)
        var outputChars: [Character] = []
        modifiedOutput = modifiedOutput.replacingOccurrences(of: "\n", with: " ", options: .literal)
        modifiedOutput = modifiedOutput.replacingOccurrences(of: "?", with: "", options: .literal)
        let modifiedOutputLength: Int = modifiedOutput.count
        var i: Int = 0
        var j: Int = 0
        while i < modifiedOutputLength-1 && i < 20 {
            let char = modifiedOutput[modifiedOutput.index(modifiedOutput.startIndex, offsetBy: i)]
            outputChars.append(char)
            i = i + 1
        }
        while (outputChars[0] == " " || outputChars[0] == "?" || outputChars[0] == "!") && j < 5 {
            outputChars.remove(at: 0)
            j = j + 1
        }
        return modifiedOutput
    }
    
    @objc func sendButtonTapped(){
        sendQuestion(textField: textField)
        print("Button Tapped!!!")
    }

}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath)
        if indexPath.row % 2 == 1 {
            cell.imageView?.image = UIImage(named: "robot")
            cell.textLabel?.text = models[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.backgroundColor = #colorLiteral(red: 0.1170914695, green: 0.1740572751, blue: 0.2324690521, alpha: 1)
            return cell

        } else{
            cell.imageView?.image = UIImage(named: "user")
            cell.textLabel?.text = models[indexPath.row]
            cell.textLabel?.textColor = .white
            cell.backgroundColor = #colorLiteral(red: 0.05490196078, green: 0.08235294118, blue: 0.1176470588, alpha: 1)
            return cell

        }
        
    }
    
    
}
