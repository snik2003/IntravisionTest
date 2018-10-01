//
//  TableViewController.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 01.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let readyButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.tapReadyButton(sender:)))
        self.navigationItem.rightBarButtonItem = readyButton
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "testCell")
    }

    @objc func tapBackButton(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func tapReadyButton(sender: UIBarButtonItem) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 10
        }
        return 0.0001
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return Constants().userTitles.count
        case 1:
            return Constants().autoTitles.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "testCell", for: indexPath) as! TableViewCell
        
        cell.delegate = self
        cell.index = indexPath
        
        switch indexPath.section {
        case 0:
            cell.title = Constants().userTitles[indexPath.row]
            if indexPath.row == 0 {
                cell.segmented = true
            } else {
                cell.placeholder = Constants().userPlaceholder[indexPath.row]
            }
        case 1:
            cell.title = Constants().autoTitles[indexPath.row]
            cell.placeholder = Constants().autoPlaceholder[indexPath.row]
            if indexPath.row != 0 {
                cell.disclosureIndicator = true
            }
        default:
            break
        }
        
        cell.configureCell()
        
        return cell
    }
}
