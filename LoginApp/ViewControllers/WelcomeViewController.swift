//
//  WelcomeViewController.swift
//  LoginApp
//
//  Created by Nasim Nozirov on 14.04.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet var welcomeLabel: UILabel!
    
    var user: User!
    
    private let colorOne = UIColor(
        red: 200/250,
        green: 100/250,
        blue: 130/250,
        alpha: 1
    )
    private let colorTwo = UIColor(
        red: 110/250,
        green: 150/250,
        blue: 250/250,
        alpha: 1
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        view.gradientLayer(topColor: colorOne, bottomColor: colorTwo)
        welcomeLabel.text = " Hello, \(user.person.fullName)!"
    }
}

extension UIView {
    func gradientLayer(topColor: UIColor, bottomColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [topColor.cgColor, bottomColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        layer.insertSublayer(gradient, at: 0)
    }
}

