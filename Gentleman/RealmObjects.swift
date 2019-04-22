//
//  RealmObjects.swift
//  Gentleman
//
//  Created by Prasant Kalidindi on 4/18/19.
//  Copyright © 2019 Prasant Kalidindi. All rights reserved.
//

import Foundation

class User: Object{
    var distance = RealmOptional<Int>()
    var speed = RealmOptional<Int>()
}
