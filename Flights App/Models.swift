//
//  File.swift
//  Flights App
//
//  Created by Shohzod Rajabov on 27/01/22.
//

import UIKit
import MapKit
import CoreLocation

class SearchModel {
    var data: Data?
    
    init(_ json: [String: AnyObject]) {
        if let dict = json["data"] as? [String: AnyObject] {
            self.data = Data.init(dict)
        }
    }
    
}

class Data {
    var cities = [City]()
    
    init(_ json: [String: AnyObject]) {
        if let array = json["cities"] as? [[String : AnyObject]]{
            var result = [City]()
            for js in array{
                let obj = City.init(js)
                result.append(obj)
            }
            self.cities = result
        }
    }
    
}


class City {
    var cc: String?
    var city: String?
    var citycode: String?
    var country: String?
    var lng: Double?
    var lat: Double?
    

    init(_ json: [String: AnyObject]) {

        self.cc = json["cc"] as? String
        self.city = json["city"] as? String
        self.citycode = json["citycode"] as? String
        self.country = json["country"] as? String
        self.lng = json["lng"] as? Double
        self.lat = json["lat"] as? Double
    }
}




class Routes {
    
    var flights = [[Flights]]()
    var aircarriers = [String:Aircarriers]()
    
    var airports = [String:Airports]()
    
    
    var directdist: Int?
    
    init(_ json: [String: AnyObject]) {
        
        if let array = json["flights"] as? [[[String : AnyObject]]]{
            var result = [[Flights]]()
            for arr in array{
                var massiv = [Flights]()
                for js in arr{
                    let obj = Flights.init(js)
                    massiv.append(obj)
                }
                result.append(massiv)
            }
            self.flights = result
        }
    
        if let dict = json["aircarriers"] as? [String: AnyObject] {
            var result = [String: Aircarriers]()
            for js in dict{
                if let key = js.key as? String {
                    if let val = js.value as? [String : AnyObject]{
                        let obj = Aircarriers.init(val)
                        result["\(key)"] = obj
                    }
                }
            }
            self.aircarriers = result
        }
        
        if let dict = json["airports"] as? [String: AnyObject] {
            var result = [String: Airports]()
            for js in dict{
                if let key = js.key as? String {
                    if let val = js.value as? [String : AnyObject]{
                        let obj = Airports.init(val)
                        result["\(key)"] = obj
                    }
                }
            }
            self.airports = result
        }
        
        self.directdist = json["directdist"] as? Int
    }
    
}

class Flights {
    var ac: String?
    var dest: String?
    var dist: String?
    var orig: String?
    var acImage: String?
    
    init(_ json: [String: AnyObject]) {

        self.ac = json["ac"] as? String
        self.dest = json["d"] as? String
        self.dist = json["dist"] as? String
        self.orig = json["o"] as? String
        self.acImage = "\("http://d35b7z08saz1n2.cloudfront.net/logo/" + (json["ac"] as? String ?? "FDB") + ".png")"
    }
    
}


class Aircarriers {
    
    var aircarrier: String?
    var alliance: String?
    var href: String?
    var iata2: String?
    var lcc: String?
    var name: String?
    
    init(_ json: [String: AnyObject]) {

        self.aircarrier = json["aircarrier"] as? String
        self.alliance = json["alliance"] as? String
        self.href = json["href"] as? String
        self.iata2 = json["iata2"] as? String
        self.lcc = json["lcc"] as? String
        self.name = json["name"] as? String
    }
    
    
}


class Airports {
    
    var cc: String?
    var city: String?
    var city_en: String?
    var city_lat: String?
    var city_lng: String?
    var citycode: String?
    var country: String?
    var iata: String?
    var lat: String?
    var lng: String?
    var name: String?
    var ri: String?
    
    init(_ json: [String: AnyObject]) {

        self.cc = json["cc"] as? String
        self.city = json["city"] as? String
        self.city_en = json["city_en"] as? String
        self.city_lat = json["city_lat"] as? String
        self.city_lng = json["city_lng"] as? String
        self.citycode = json["citycode"] as? String
        self.country = json["country"] as? String
        self.iata = json["iata"] as? String
        self.lat = json["lat"] as? String
        self.lng = json["lng"] as? String
        self.name = json["name"] as? String
        self.ri = json["ri"] as? String
    }
    
}

