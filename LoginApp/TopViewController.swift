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
    
    // MARK: - Private properties
    private let userName = "Nas"
    private let password = "ppp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerForKeyboardNotifications()
    }
    deinit {
        registerForKeyboardNotifications()
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let welcomeVC = segue.destination as? WelcomeViewController else { return }
        welcomeVC.welcome = userName
        
    }
    
    // MARK: IBActions
    @IBAction func switchToAnotherScreen() {
        if userNameTF.text != userName, passwordTF.text != password {
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
        ? showAlert(title: "Hi", massage: "Your name is \(userName)")
        : showAlert(title: "Hi", massage: "Your password is \(password)")
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

