//
//  UIViewController+Util.swift
//  Digital14
//
//  Created by Narendra Goojer on 21/10/21.
//

import UIKit

extension UIViewController {
    func alert(_ title: String? = "Alert", message: String, comlpetion:  @escaping ()->Void) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            comlpetion()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true) {
            
        }
    }
}
