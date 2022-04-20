//
//  ImageViewController.swift
//  LoginApp
//
//  Created by Nasim Nozirov on 18.04.2022.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    let user = User.getUser()
    
    var image = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.image = UIImage(named: image)
        self.title = user.person.fullName
       
    }

}
