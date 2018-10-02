//
//  TableViewController.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 01.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import UIKit
import SwiftyJSON

class TableViewController: UITableViewController {

    var cityID: Int!
    var cities: [ListObject] = []
    var classes: [ListObject] = []
    var showrooms: [ListObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let readyButton = UIBarButtonItem(title: "Готово", style: .done, target: self, action: #selector(self.tapReadyButton(sender:)))
        self.navigationItem.rightBarButtonItem = readyButton
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "formCell")
        
        let tap = UITapGestureRecognizer()
        self.view.addGestureRecognizer(tap)
        tap.add {
            self.view.endEditing(true)
        }
        
        Constants.shared.order.readPersonalData()
        
        IntraAPI().getClasses() { (objects) -> (Void) in
            self.classes = objects
            IntraAPI().getCities() { (objects) -> (Void) in
                self.cities = objects
                OperationQueue.main.addOperation {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @objc func tapReadyButton(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        
        if Constants.shared.order.checkValidation(controller: self) {
            IntraAPI().sendForm(controller: self)
            self.navigationController?.popViewController(animated: true)
        }
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
            return Constants.shared.userTitles.count
        case 1:
            return Constants.shared.autoTitles.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "formCell", for: indexPath) as! TableViewCell
        
        cell.delegate = self
        cell.index = indexPath
        
        cell.segmented = false
        cell.disclosureIndicator = false
        cell.placeholder = nil
        cell.textValue = ""
        
        switch indexPath.section {
        case 0:
            cell.title = Constants.shared.userTitles[indexPath.row]
            
            switch indexPath.row {
            case 0:
                cell.segmented = true
            case 1:
                cell.placeholder = Constants.shared.userPlaceholder[indexPath.row]
                cell.textValue = Constants.shared.order.lastName
            case 2:
                cell.placeholder = Constants.shared.userPlaceholder[indexPath.row]
                cell.textValue = Constants.shared.order.firstName
            case 3:
                cell.placeholder = Constants.shared.userPlaceholder[indexPath.row]
                cell.textValue = Constants.shared.order.middleName
            case 4:
                cell.placeholder = Constants.shared.userPlaceholder[indexPath.row]
                cell.textValue = Constants.shared.order.phone
            case 5:
                cell.placeholder = Constants.shared.userPlaceholder[indexPath.row]
                cell.textValue = Constants.shared.order.email
            default:
                break
            }
        case 1:
            cell.title = Constants.shared.autoTitles[indexPath.row]
            cell.placeholder = Constants.shared.autoPlaceholder[indexPath.row]
            if indexPath.row != 0 {
                cell.disclosureIndicator = true
            }
            
            switch indexPath.row {
            case 0:
                cell.textValue = Constants.shared.order.vin
            case 1:
                cell.textValue = Constants.shared.order.year
                cell.pickerData.removeAll(keepingCapacity: false)
                if let year = Calendar.current.dateComponents([.year], from: Date()).year {
                    for value in year-15...year-2 {
                        cell.pickerData.append("\(value)")
                    }
                }
            case 2:
                if let auto = classes.filter({ $0.id == Constants.shared.order.classID }).first?.name {
                    cell.textValue = auto
                }
                
                cell.objects = classes
                cell.pickerData.removeAll(keepingCapacity: false)
                for object in cell.objects {
                    cell.pickerData.append(object.name)
                }
            case 3:
                if let id = self.cityID, let city = cities.filter({ $0.id == id }).first?.name {
                    cell.textValue = city
                }
                
                cell.objects = cities
                cell.pickerData.removeAll(keepingCapacity: false)
                for object in cell.objects {
                    cell.pickerData.append(object.name)
                }
            case 4:
                if let showroom = showrooms.filter({ $0.id == Constants.shared.order.showroomID }).first?.name {
                    cell.textValue = showroom
                }
                
                cell.objects = showrooms
                cell.pickerData.removeAll(keepingCapacity: false)
                for object in cell.objects {
                    cell.pickerData.append(object.name)
                }
            default:
                break
            }
        default:
            break
        }
        
        cell.configureCell()
        
        return cell
    }
    
    func showErrorMessage(message: String, pop: Bool = false) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "OK", style: .cancel)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true)
    }
    
    func showOrder() {
        print("Обращение: \(Constants.shared.order.gender)")
        print("Фамилия: \(Constants.shared.order.lastName)")
        print("Имя: \(Constants.shared.order.firstName)")
        print("Отчество: \(Constants.shared.order.middleName)")
        print("Телефон: \(Constants.shared.order.phone)")
        print("Email: \(Constants.shared.order.email)")
        print("Vin: \(Constants.shared.order.vin)")
        print("Год: \(Constants.shared.order.year)")
        print("Класс: \(Constants.shared.order.classID)")
        print("Дилер: \(Constants.shared.order.showroomID)")
    }
}
