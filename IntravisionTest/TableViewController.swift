//
//  TableViewController.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 01.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let sectionUserTitles: [String] = ["Обращение",
                                    "Фамилия",
                                    "Имя",
                                    "Отчество",
                                    "Телефон",
                                    "Email"]
    
    let sectionAutoTitles: [String] = ["VIN",
                                       "Год выпуска",
                                       "Класс",
                                       "Город",
                                       "Дилер"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let readyButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.tapReadyButton(sender:)))
        self.navigationItem.rightBarButtonItem = readyButton
        self.navigationItem.hidesBackButton = true
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
            return sectionUserTitles.count
        case 1:
            return sectionAutoTitles.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test1", for: indexPath)

        cell.textLabel?.textColor = .white
        
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = sectionUserTitles[indexPath.row]
        case 1:
            cell.textLabel?.text = sectionAutoTitles[indexPath.row]
        default:
            break
        }
        
        return cell
    }
}
