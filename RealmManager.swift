//
//  RealmManager.swift
//  RealmCountryApp (iOS)
//
//  Created by Сергей Кривошеев on 01.05.2022.
//

import Foundation
import RealmSwift

class RealmManager: ObservableObject {
    
    private(set) var realm: Realm?
    @Published var countries: Results<Country>?
    
    var countriesArray: [Country] {
        if let countries = countries {
            return Array(countries)
        } else {
            return []
        }
    }
    
    
    
    private var countriesToken: NotificationToken?
    
    init(name: String){
        inizializeSchema(name: name)
        setupObserver()
    }
    
    func setupObserver(){
        guard let realm = realm else { return }
        let observedCountries = realm.objects(Country.self)
        countriesToken = observedCountries.observe({ [weak self] _ in
            self?.countries = observedCountries
        })
    }
    
    func inizializeSchema(name: String) {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let realmFileUrl = docDir.appendingPathComponent("\(name).realm")
        let config = Realm.Configuration(fileURL: realmFileUrl,schemaVersion: 1) { migration, oldSchemaVersion in
            if oldSchemaVersion < 1 {
                migration.enumerateObjects(ofType: Country.className()) { oldObject, newObject in
                    newObject!["flag"] = "🏳️"
                }
            }
        }
        Realm.Configuration.defaultConfiguration = config
        print(docDir.path)
        do {
            realm = try Realm()
        } catch {
            print("Error opening default realm", error)
        }
    }
    
    func add(_ country: Country){
        if let realm = realm {
            do {
                try realm.write{
                    realm.add(country)
                }
            } catch  {
                print("Error adding country to realm", error)
            }
        }
    }
    
    func remove(_ country: Country){
        if let realm = realm {
            if let countryToDelete = realm.object(ofType: Country.self, forPrimaryKey: country.id) {
                do {
                    try realm.write({
                        realm.delete(countryToDelete)
                    })
                } catch {
                    print("Could not delete country", error)
                }
            }
        }
    }
}

