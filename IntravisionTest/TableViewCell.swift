//
//  TableViewCell.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 01.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var delegate: TableViewController!
    var index: IndexPath!
    
    func configureCell() {
        
        self.backgroundColor = delegate.tableView.backgroundColor
        
        let titleLabel = UILabel()
        switch index.section {
        case 0:
            titleLabel.text = Constants().userTitles[index.row]
        case 1:
            titleLabel.text = Constants().autoTitles[index.row]
        default:
            break
        }
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 20, y: 5, width: 100, height: bounds.height - 10)
        self.addSubview(titleLabel)
    }
}
