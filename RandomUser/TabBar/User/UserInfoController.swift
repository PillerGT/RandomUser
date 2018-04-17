//
//  UserInfoController.swift
//  RandomUser
//
//  Created by San on 16.04.18.
//  Copyright © 2018 San. All rights reserved.
//

import UIKit

class UserInfoController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var birthDateLabel: UILabel!
    @IBOutlet weak var registrationLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var user: UserModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Info"
        
        NetworkManager().loadImage(imageUrlString: user.picture.thumbnail) { [unowned self] (image) in
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }

        nameLabel.text = user.name.first + " " + user.name.last
        genderLabel.text = user.gender
        phoneLabel.text = user.phone
        birthDateLabel.text = Date.convertDataToStringBOD(date: user.dob!)
        registrationLabel.text = Date.convertDataToStringReg(date: user.registered!)
        locationLabel.text = user.location.state + " " + user.location.city + " " + user.location.street + " " + user.location.postcode
    }

    
    
}
