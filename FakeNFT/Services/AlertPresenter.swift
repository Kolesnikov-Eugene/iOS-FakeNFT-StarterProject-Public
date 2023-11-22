//
//  AlertPresenter.swift
//  FakeNFT
//
//  Created by Eugene Kolesnikov on 04.11.2023.
//

import UIKit

final class AlertPresenter {

    private init() {}

    static func show(in viewController: UIViewController, model: AlertModel) {
        let alert = UIAlertController(
            title: nil,
            message: model.message,
            preferredStyle: .actionSheet)

        let nameSort = UIAlertAction(title: model.nameSortText, style: .default) { _ in
            model.sortNameCompletion()
        }

        alert.addAction(nameSort)

        let quantitySort = UIAlertAction(title: model.quantitySortText, style: .default) { _ in
            model.sortQuantityCompletion()
        }

        alert.addAction(quantitySort)

        let cancelAction = UIAlertAction(title: model.cancelButtonText, style: .cancel)

        alert.addAction(cancelAction)

        viewController.present(alert, animated: true)
    }

    static func showError(in viewController: UIViewController, completion: @escaping () -> Void) {
        let alert = UIAlertController(
            title: L10n.NetworkErrorAlert.title,
            message: L10n.NetworkErrorAlert.message,
            preferredStyle: .alert
        )

        let action = UIAlertAction(title: L10n.NetworkErrorAlert.okButton, style: .default) { _ in
            completion()
        }
        alert.addAction(action)
        viewController.present(alert, animated: true)
    }

    static func showLikeError(in viewController: UIViewController) {
        let alert = UIAlertController(
            title: "Like error", message: "Try again", preferredStyle: .alert
        )

        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        viewController.present(alert, animated: true)
    }
}