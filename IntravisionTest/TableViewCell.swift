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
    
    var title: String!
    var placeholder: String!
    var disclosureIndicator = false
    var segmented = false
    
    let titleFont = UIFont.boldSystemFont(ofSize: 16)
    let placeholderFont = UIFont.systemFont(ofSize: 14)
    
    var detailLabel = UILabel()
    var segmentedControl = UISegmentedControl()
    
    func configureCell() {
        
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
            detailLabel.tag = 250
            detailLabel.text = text
            detailLabel.font = placeholderFont
            detailLabel.textColor = .gray
            detailLabel.textAlignment = .right
            detailLabel.adjustsFontSizeToFitWidth = true
            detailLabel.minimumScaleFactor = 0.4
            
            if disclosureIndicator {
                let imageView = UIImageView()
                imageView.tag = 250
                imageView.image = UIImage(named: "arrow")
                imageView.frame = CGRect(x: width - 20, y: 15, width: 15, height: 15)
                imageView.contentMode = .scaleAspectFit
                imageView.clipsToBounds = true
                self.addSubview(imageView)
                
                let tap = UITapGestureRecognizer()
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tap)
                tap.add {
                    print(self.detailLabel.text!)
                }
                
                detailLabel.frame = CGRect(x: 130, y: 5, width: width - 152, height: bounds.height - 10)
            } else {
                detailLabel.frame = CGRect(x: 130, y: 5, width: width - 140, height: bounds.height - 10)
            }
            
            let tap = UITapGestureRecognizer()
            detailLabel.isUserInteractionEnabled = true
            detailLabel.addGestureRecognizer(tap)
            tap.add {
                print(self.detailLabel.text!)
            }
            
            self.addSubview(detailLabel)
        }
        
        if segmented {
            segmentedControl.tag = 250
            if segmentedControl.numberOfSegments == 0 {
                segmentedControl.insertSegment(withTitle: "Господин", at: 0, animated: false)
                segmentedControl.insertSegment(withTitle: "Госпожа", at: 1, animated: false)
                segmentedControl.selectedSegmentIndex = 0
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
