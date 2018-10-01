//
//  ViewController.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 01.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem?.title = ""
        
        let formButton = UIBarButtonItem(title: "Форма заявки", style: .done, target: self, action: #selector(self.openFormController))
        self.navigationItem.rightBarButtonItem = formButton
        
        openFormController()
    }
    
    @objc func openFormController() {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as! TableViewController
        
        self.navigationController?.pushViewController(controller, animated: true)
    }
}


