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
    
    var objects: [ListObject] = []
    var pickerData: [String] = []
    
    var index: IndexPath!
    
    var title: String!
    var textValue: String = ""
    var placeholder: String!
    var disclosureIndicator = false
    var segmented = false
    
    let titleFont = UIFont.boldSystemFont(ofSize: 16)
    let textFont = UIFont.boldSystemFont(ofSize: 14)
    let placeholderFont = UIFont.systemFont(ofSize: 13)
    
    var textField = UITextField()
    var segmentedControl = UISegmentedControl()
    
    var pickerView: UIPickerView {
        get {
            let pickerView = UIPickerView()
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.backgroundColor = .darkGray
            pickerView.tintColor = .white
            pickerView.setValue(UIColor.white, forKeyPath: "textColor")
            return pickerView
        }
    }
    
    func configureCell() {
        
        self.removeAllSubviews()
        
        let width = delegate.tableView.bounds.width
        self.backgroundColor = delegate.tableView.backgroundColor
        
        if let text = self.title {
            let label = UILabel()
            label.tag = 250
            label.text = text
            label.font = titleFont
            label.textColor = .white
            label.frame = CGRect(x: 20, y: 5, width: 100, height: bounds.height - 10)
            self.addSubview(label)
        }
        
        if let text = self.placeholder {
            textField.tag = 250
            textField.delegate = self
            textField.text = textValue
            textField.attributedPlaceholder = NSAttributedString(string: text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: placeholderFont])
            
            textField.font = textFont
            textField.textColor = .white
            textField.textAlignment = .right
            textField.inputView = nil
            textField.returnKeyType = .done
            
            if disclosureIndicator {
                let imageView = UIImageView()
                imageView.tag = 250
                imageView.image = UIImage(named: "arrow")
                imageView.frame = CGRect(x: width - 20, y: 15, width: 15, height: 15)
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                self.addSubview(imageView)
                
                textField.frame = CGRect(x: 130, y: 5, width: width - 152, height: bounds.height - 10)
            } else {
                textField.frame = CGRect(x: 130, y: 5, width: width - 140, height: bounds.height - 10)
            }
            
            self.addSubview(textField)
        }
        
        if segmented {
            segmentedControl.tag = 250
            if segmentedControl.numberOfSegments == 0 {
                segmentedControl.insertSegment(withTitle: "Господин", at: 0, animated: false)
                segmentedControl.insertSegment(withTitle: "Госпожа", at: 1, animated: false)
                if Constants.shared.order.gender == 0 {
                    segmentedControl.selectedSegmentIndex = 0
                    Constants.shared.order.gender = 1
                } else {
                    segmentedControl.selectedSegmentIndex = Constants.shared.order.gender
                    if Constants.shared.order.gender == 1 {
                        segmentedControl.selectedSegmentIndex = 0
                    } else {
                        segmentedControl.selectedSegmentIndex = 1
                    }
                }
            }
            segmentedControl.add(for: .valueChanged) {
                if self.segmentedControl.selectedSegmentIndex == 0 {
                    Constants.shared.order.gender = 1
                } else {
                    Constants.shared.order.gender = 2
                }
            }
            segmentedControl.tintColor = .white
            segmentedControl.frame = CGRect(x: width - 190, y: 7, width: 180, height: bounds.height - 14)
            self.addSubview(segmentedControl)
        }
    }
    
    func removeAllSubviews() {
        for subview in self.subviews {
            if subview.tag == 250 {
                subview.removeFromSuperview()
            }
        }
    }
}

extension TableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.delegate.view.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        switch index.section {
        case 0:
            switch index.row {
            case 1...3:
                textField.keyboardType = .default
            case 4:
                textField.keyboardType = .phonePad
                if textField.text == nil {
                    textField.text = "+7"
                }
            case 5:
                textField.keyboardType = .emailAddress
            default:
                break
            }
        case 1:
            switch index.row {
            case 0:
                textField.keyboardType = .default
                textField.autocapitalizationType = .allCharacters
            case 1:
                textField.inputView = pickerView
            case 2:
                textField.inputView = pickerView
            case 3:
                textField.inputView = pickerView
            case 4:
                if delegate.cityID == nil {
                    delegate.view.endEditing(true)
                    delegate.showErrorMessage(message: "Пожалуйста, сначала выберите город")
                    return false
                } else {
                    textField.inputView = pickerView
                }
            default:
                break
            }
        default:
            break
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        switch index.section {
        case 0:
            switch index.row {
            case 4:
                if let text = textField.text, text != "", !text.isValidPhone() {
                    Constants.shared.order.phone = text
                    delegate.showErrorMessage(message: "Некорректное значение номера телефона")
                    return false
                }
            case 5:
                if let text = textField.text, text != "", !text.isValidEmail() {
                    Constants.shared.order.email = text
                    delegate.showErrorMessage(message: "Некорректное значение email")
                    return false
                }
            default:
                break
            }
        case 1:
            switch index.row {
            case 0:
                if let text = textField.text, text != "", !text.isValidVin() {
                    Constants.shared.order.vin = text
                    delegate.showErrorMessage(message: "Некорректное значение номера VIN")
                    return false
                }
            default:
                break
            }
        default:
            break
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch index.section {
        case 0:
            switch index.row {
            case 1:
                if let text = textField.text {
                    Constants.shared.order.lastName = text
                }
            case 2:
                if let text = textField.text {
                    Constants.shared.order.firstName = text
                }
            case 3:
                if let text = textField.text {
                    Constants.shared.order.middleName = text
                }
            case 4:
                if let text = textField.text {
                    Constants.shared.order.phone = text
                }
            case 5:
                if let text = textField.text {
                    Constants.shared.order.email = text
                }
            default:
                break
            }
        case 1:
            switch index.row {
            case 0:
                if let text = textField.text {
                    Constants.shared.order.vin = text
                }
            case 1:
                if let text = textField.text {
                    Constants.shared.order.year = text
                }
            case 2:
                if let text = textField.text, let classID = objects.filter({ $0.name == text}).first?.id {
                    Constants.shared.order.classID = classID
                }
            case 3:
                if let text = textField.text {
                    Constants.shared.order.city = text
                }
            case 4:
                if let text = textField.text, let showroomID = objects.filter({ $0.name == text}).first?.id {
                    Constants.shared.order.showroomID = showroomID
                }
            default:
                break
            }
        default:
            break
        }
    }
    
    internal func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            textField.text!.removeLast()
            return false
        }
        
        if index.section == 0 && index.row == 4 {
            if (textField.text?.count)! == 2 {
                textField.text = "\(textField.text!) ("
            } else if (textField.text?.count)! == 7 {
                textField.text = "\(textField.text!)) "
            } else if (textField.text?.count)! == 12 {
                textField.text = "\(textField.text!)-"
            } else if (textField.text?.count)! == 15 {
                textField.text = "\(textField.text!)-"
            } else if (textField.text?.count)! > 17 {
                return false
            }
        }
        
        return true
    }

}

extension TableViewCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
}

extension TableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = pickerData[row]
        pickerView.selectRow(row, inComponent: 0, animated: true)
        
        if index.section == 1 && index.row == 3 {
            if let city = objects.filter({ $0.name == pickerData[row] }).first {
                delegate.cityID = city.id
                Constants.shared.order.showroomID = 0
                IntraAPI().getShowrooms(cityID: city.id) { (objects) -> (Void) in
                    self.delegate.showrooms = objects
                    OperationQueue.main.addOperation {
                        self.delegate.tableView.reloadRows(at: [IndexPath(row: 4, section: 1)], with: .automatic)
                    }
                }
            }
        }
    }
}
