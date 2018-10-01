//
//  Extensions.swift
//  IntravisionTest
//
//  Created by Сергей Никитин on 01.10.2018.
//  Copyright © 2018 Sergey Nikitin. All rights reserved.
//

import UIKit

extension UIControl {
    func add (for controlEvents: UIControl.Event, _ closure: @escaping () -> ()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

extension UIGestureRecognizer {
    func add (_ closure: @escaping () -> ()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke))
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

class ClosureSleeve {
    let closure: () -> ()
    
    init (_ closure: @escaping () -> ()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}
