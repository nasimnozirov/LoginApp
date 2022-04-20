//
//  ViewController.swift
//  LoginApp
//
//  Created by Nasim Nozirov on 14.04.2022.
//

import UIKit

class TopViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet var userNameTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    
    let user = User.getUser()
    
    // to store the current active textfield
    //    private var activeTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userNameTF.delegate = self
        passwordTF.delegate = self
        
        //        // call the 'keyboardWillShow' function when the view controller receive notification that keyboard is going to be shown
        //            NotificationCenter.default.addObserver(
        //                self,
        //                selector: #selector(keyboardWillShow(notification:)),
        //                name: UIResponder.keyboardWillShowNotification,
        //                object: nil
        //            )
        //
        //        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        //            NotificationCenter.default.addObserver(
        //                self,
        //                selector: #selector(keyboardWillHide(notification:)),
        //                name: UIResponder.keyboardWillHideNotification,
        //                object: nil
        //            )
        registerForKeyboardNotifications()
    }
    //    deinit {
    //        registerForKeyboardNotifications()
    //    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarController = segue.destination as? UITabBarController else { return }
        guard let viewControllers = tabBarController.viewControllers else { return }
        
        for viewController in viewControllers {
            if let welcomeVC = viewController as? WelcomeViewController {
                welcomeVC.welcome = user.person.fullName
            } else if let navigationVC = viewController as? UINavigationController {
                
                guard  let aboutUserVC = navigationVC.topViewController as? AboutMeViewController else { return }
                aboutUserVC.aboutMe = user.person.aboutMe
            }
        }
        
    }
    
    // MARK: IBActions
    @IBAction func switchToAnotherScreen() {
        if userNameTF.text != user.userName, passwordTF.text != user.password {
            showAlert(
                title: "Invalid login or password",
                massage: "Please, enter correct login and password",
                textField: passwordTF
            )
        }
        performSegue(withIdentifier: "setVC", sender: nil)
    }
    
    @IBAction func showAlertOnClick(_ sender: UIButton) {
        sender.tag == 0
        ? showAlert(title: "Hi", massage: "Your name is \(user.userName)")
        : showAlert(title: "Hi", massage: "Your password is \(user.password)")
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        userNameTF.text = ""
        passwordTF.text = ""
    }
}

// MARK: - Keyboard
extension TopViewController: UITextFieldDelegate {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTF {
            passwordTF.becomeFirstResponder()
        } else {
            switchToAnotherScreen()
        }
        return true
    }
}

// MARK: - Alert Controller
extension TopViewController {
    private func showAlert(title: String, massage: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: massage, preferredStyle: .alert)
        let okAction =  UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

/// MARK: Setting - Keyboard
extension TopViewController {
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(kbWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(kbWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification ,
            object: nil
        )
    }
    
    @objc func kbWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        guard let kbFrameSize = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else
        { return }
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    @objc func kbWillHide() {
        scrollView.contentOffset = CGPoint.zero
    }
}

//// MARK: - Keyboard Appears
//extension TopViewController {
//    @objc func keyboardWillShow(notification: NSNotification) {
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
//            // if keyboard size is not available for some reason, dont do anything
//            return
//        }
//
//        var shouldMoveStackViewUp = false
//
//        // поднимаем stackview с кнопками
//        if let _ = activeTextField {
//
//            let bottomOfStackView = scrollView.convert(scrollView.bounds, to: self.view).maxY
//            let topOfKeyboard = self.view.frame.height - keyboardSize.height
//
//            // if the bottom of Textfield is below the top of keyboard, move up
//            if bottomOfStackView > topOfKeyboard {
//                shouldMoveStackViewUp = true
//            }
//        }
//
//        if shouldMoveStackViewUp {
//            scrollView.frame.origin.y = self.view.frame.height - keyboardSize.height - 56
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        // move back the root view origin to zero
//        self.scrollView.frame.origin.y = self.view.frame.height - 96
//    }
//
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.activeTextField = textField
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        self.activeTextField = nil
//    }
//}
