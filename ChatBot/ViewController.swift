//
//  ViewController.swift
//  ChatBot
//
//  Created by мак on 25.01.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let itemsA = ["Language", "Your Plan", "Voice"]
    let itemsB = ["Help", "Restore Purchases"]
    let itemsC = ["Rate Us", "Share with Friends", "Terms of Use", "Privace Policy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
               case 0:
                  return itemsA.count
               case 1:
                  return itemsB.count
               case 2:
                  return itemsC.count
               default:
                  return 1
            }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        switch (indexPath.section) {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "settings", for: indexPath) as! TableViewCell
            cell.titleRowSettings.text = itemsA[indexPath.row]
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "settings2", for: indexPath) as! TableViewCell2
            cell.titleRowSettings2.text = itemsB[indexPath.row]
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "settings3", for: indexPath) as! TableViewCell3
            cell.titleRowSettings3.text = itemsC[indexPath.row]
            return cell
        default:
            return cell!
     }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var sectionName: String?
        switch section {
        case 0:
            sectionName = "Settings"
        case 1:
            sectionName = "Support"
        case 2:
            sectionName = "About"
        default:
            sectionName = ""
        }
        return sectionName
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cornerRadius = 15
        var corners: UIRectCorner = []

        if indexPath.row == 0
        {
            corners.update(with: .topLeft)
            corners.update(with: .topRight)
        }

        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1
        {
            corners.update(with: .bottomLeft)
            corners.update(with: .bottomRight)
        }

        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(roundedRect: cell.bounds,
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
        cell.layer.mask = maskLayer
    }
    
    
}
