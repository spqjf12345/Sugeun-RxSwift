//
//  UIViewController.swift
//  First-RxSwift
//
//  Created by JoSoJeong on 2022/02/16.
//

import Foundation
import UIKit
import RxSwift

struct AlertAction {
    var title: String
    var style: UIAlertAction.Style
    
    static func action(title: String, style: UIAlertAction.Style = .default) -> AlertAction {
        return AlertAction(title: title, style: style)
    }
}

extension UIViewController {
    func alertViewController(title: String, message: String, completion: @escaping  (String) -> Void){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "확인", style: .default, handler:  { _ in
            completion("OK")
        })
        alertVC.addAction(OKAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func alertWithNoViewController(title: String, message: String, completion: @escaping  (String) -> Void){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "확인", style: .default, handler:  { _ in
            completion("OK")
        })
        let CANCELAction = UIAlertAction(title: "취소", style: .default, handler:  nil)
        alertVC.addAction(OKAction)
        alertVC.addAction(CANCELAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func showAlert(title: String?, message: String?, style: UIAlertController.Style, actions: [AlertAction]) -> Observable<Int>
    {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(index)
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }
            
            self.present(alertController, animated: true, completion: nil)
            
            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
    
    func showTextfieldAlert(title: String?, message: String?, style: UIAlertController.Style, actions: [AlertAction]) -> Observable<Int>
    {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            actions.enumerated().forEach { index, action in
                let action = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext(index)
                    observer.onCompleted()
                }
                alertController.addAction(action)
            }
            
            self.present(alertController, animated: true, completion: nil)
            
            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
    }
}
