//
//  AboutMeViewController.swift
//  LoginApp
//
//  Created by Nasim Nozirov on 16.04.2022.
//

import UIKit

class AboutMeViewController: UIViewController {
    
    @IBOutlet var aboutMeLabel: UILabel!
    
    let user = User.getUser()
    
    var fullName = ""
    var aboutMe = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutMeLabel.text = aboutMe
        self.title = user.person.fullName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let imageVC = segue.destination as? ImageViewController else { return }
        imageVC.image = user.person.image
    }
}
