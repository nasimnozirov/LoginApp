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
        self.title = user.person.fullName
       
    }
    


}
