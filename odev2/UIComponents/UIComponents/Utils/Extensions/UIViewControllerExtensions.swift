//
//  UIViewControllerExtensions.swift
//  UIComponents
//
//  Created by Oğuz Parlak on 13.01.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(
        title: String,
        message: String,
        positiveText: String,
        negativeText: String,
        onPositiveButtonTapped: (() -> Void)? = nil,
        onNegativeButtonTapped: (() -> Void)? = nil)
    {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alertController.addAction(
            UIAlertAction(
                title: positiveText,
                style: .default,
                handler: { _ in
                    onPositiveButtonTapped?()
                })
        )
        alertController.addAction(
            UIAlertAction(
                title: negativeText,
                style: .destructive,
                handler: { _ in
                    alertController.dismiss(animated: true)
                    onNegativeButtonTapped?()
        }))
        present(alertController, animated: true, completion: nil)
    }
    
}
