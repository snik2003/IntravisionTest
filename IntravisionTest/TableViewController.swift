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
        
        cell.configureCell()
        
        return cell
    }
}
