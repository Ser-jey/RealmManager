//
//  Country.swift
//  RealmCountryApp (iOS)
//
//  Created by Сергей Кривошеев on 21.04.2022.
//

import Foundation
import RealmSwift

class Country:Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var cities: List<City>
    @Persisted var flag = "🏳️"
    
    convenience init(name: String){
        self.init()
        self.name = name
    }
}

class City: Object, ObjectKeyIdentifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted(originProperty: "cities") var country: LinkingObjects<Country>
    convenience init(name: String){
        self.init()
        self.name = name
    }
}
