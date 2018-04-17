//
//  FilterViewController.swift
//  RandomUser
//
//  Created by San on 16.04.18.
//  Copyright © 2018 San. All rights reserved.
//

import UIKit

class FilterManager {
    
    static let sharedManager = FilterManager()
    
    var isFiltered : Bool = false
    var nationals : NSSet = []
    var gender : Bool = false {
        didSet {
            isFiltered = true
        }
    }
    var nationality : String? {
        didSet {
            isFiltered = true
        }
    }
}

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var nationalityBatton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var nationals : [String] = []
    var selectNat : String!
    

    @IBAction func actionGenderSwith(_ sender: UISwitch) {
        FilterManager.sharedManager.gender = sender.isOn
    }
    
    @IBAction func nationalityAction(_ sender: UIButton) {
        FilterManager.sharedManager.nationality = selectNat
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        genderSwitch.isOn = FilterManager.sharedManager.gender
        nationals.removeAll()
        FilterManager.sharedManager.nationals.allObjects.forEach { natElem in
            nationals.append(natElem as! String)
        }
        pickerView.reloadAllComponents()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nationals.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nationals[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectNat = nationals[row]
    }
}
