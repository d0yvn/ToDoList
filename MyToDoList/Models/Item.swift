//
//  Item.swift
//  MyToDoList
//
//  Created by doyun on 2021/08/18.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var subtitle : String = ""
    @objc dynamic var date : String = ""
}
