//
//  UserModel.swift
//  RandomUser
//
//  Created by San on 16.04.18.
//  Copyright © 2018 San. All rights reserved.
//

import UIKit

struct nameFull {
    let title : String
    let first : String
    let last : String
}

struct locationFull {
    let street : String
    let city : String
    let state : String
    let postcode : String
}

struct loginFull {
    let username : String
    let password : String
    let salt : String
    let md5 : String
    let sha1 : String
    let sha256 : String
}

struct idUserFull {
    let name : String
    let value : String
}

struct pictureFull {
    let large : String
    let medium : String
    let thumbnail : String
}

class UserModel: NSObject {
    
    typealias JSONDictionary = [String: Any]
    
    let gender : String?
    let name : nameFull
    let location : locationFull
    let email : String?
    let login : loginFull
    let dob : Date?
    let registered : Date?
    let phone : String?
    let cell : String?
    let idUser : idUserFull
    let picture : pictureFull
    let nat : String?
    
    init(gender : String? = nil,
         name : nameFull = nameFull.init(title: "", first: "", last: ""),
         location : locationFull = locationFull.init(street: "", city: "", state: "", postcode: ""),
         email : String? = nil,
         login : loginFull = loginFull.init(username: "", password: "", salt: "", md5: "", sha1: "", sha256: ""),
         dob : Date? = nil,
         registered : Date? = nil,
         phone : String? = nil,
         cell : String? = nil,
         idUser : idUserFull = idUserFull.init(name: "", value: ""),
         picture : pictureFull = pictureFull.init(large: "", medium: "", thumbnail: ""),
         nat : String? = nil) {
        self.gender = gender
        self.name = name
        self.location = location
        self.email = email
        self.login = login
        self.dob = dob
        self.registered = registered
        self.phone = phone
        self.cell = cell
        self.idUser = idUser
        self.picture = picture
        self.nat = nat
    }

    func parseDictionary (dict: JSONDictionary) -> UserModel {
        
        let gender = dict["gender"] as? String

        let nameDict = dict["name"] as? NSDictionary ?? [:]
        let title = nameDict["title"] as? String ?? ""
        let first = nameDict["first"] as? String ?? ""
        let last = nameDict["last"] as? String ?? ""
        
        let locationDict = dict["location"] as? NSDictionary ?? [:]
        let street = locationDict["street"] as? String ?? ""
        let city = locationDict["city"] as? String ?? ""
        let state = locationDict["state"] as? String ?? ""
        let postcode = locationDict["postcode"] as? String ?? ""
        
        let email = dict["email"] as? String ?? ""
        
        let loginDict = dict["login"] as? NSDictionary ?? [:]
        let username = loginDict["username"] as? String ?? ""
        let password = loginDict["password"] as? String ?? ""
        let salt = loginDict["salt"] as? String ?? ""
        let md5 = loginDict["md5"] as? String ?? ""
        let sha1 = loginDict["sha1"] as? String ?? ""
        let sha256 = loginDict["sha256"] as? String ?? ""
        
        let dobStr = dict["dob"] as? String ?? ""
        let dob = Date.convertStringToDate(dateStr: dobStr) ?? Date()
        
        let registeredStr = dict["registered"] as? String ?? ""
        let registered = Date.convertStringToDate(dateStr: registeredStr) ?? Date()
        
        let phone = dict["phone"] as? String ?? ""
        let cell = dict["cell"] as? String ?? ""
        
        let idDict = dict["id"] as? NSDictionary ?? [:]
        let nameId = idDict["name"] as? String ?? ""
        let value = idDict["value"] as? String ?? ""
        
        let pictureDict = dict["picture"] as? NSDictionary ?? [:]
        let large = pictureDict["large"] as? String ?? ""
        let medium = pictureDict["medium"] as? String ?? ""
        let thumbnail = pictureDict["thumbnail"] as? String ?? ""
        
        let nat = dict["nat"] as? String ?? ""
        
        let nameF = nameFull.init(title: title, first: first, last: last)
        let locationF = locationFull.init(street: street, city: city, state: state, postcode: postcode)
        let login = loginFull.init(username: username, password: password, salt: salt, md5: md5, sha1: sha1, sha256: sha256)
        let idUser = idUserFull.init(name: nameId, value: value)
        let picture = pictureFull.init(large: large, medium: medium, thumbnail: thumbnail)
        
        return UserModel.init(gender: gender, name: nameF, location: locationF, email: email, login: login, dob: dob, registered: registered, phone: phone, cell: cell, idUser: idUser, picture: picture, nat: nat)
    }
    
}

//"gender": "female",
//"name": {
//    "title": "mrs",
//    "first": "elsa",
//    "last": "mattila"
//},
//"location": {
//    "street": "2089 pyynikintie",
//    "city": "jämijärvi",
//    "state": "tavastia proper",
//    "postcode": 20255
//},
//"email": "elsa.mattila@example.com",
//"login": {
//    "username": "yellowgoose840",
//    "password": "hetfield",
//    "salt": "lFtFs80J",
//    "md5": "eee781179a698725fb3eeb1a222a4298",
//    "sha1": "7e33115307158f6ebf9bdda36cf6971c5e0b4c15",
//    "sha256": "e097a0552121754a9b56c99453a01c3e9306852d7ecfa923e825a3c894fdf053"
//},
//"dob": "1982-10-07 23:03:14",
//"registered": "2006-09-28 00:51:35",
//"phone": "09-051-259",
//"cell": "046-587-50-14",
//"id": {
//    "name": "HETU",
//    "value": "1382-252S"
//},
//"picture": {
//    "large": "https://randomuser.me/api/portraits/women/67.jpg",
//    "medium": "https://randomuser.me/api/portraits/med/women/67.jpg",
//    "thumbnail": "https://randomuser.me/api/portraits/thumb/women/67.jpg"
//},
//"nat": "FI"

