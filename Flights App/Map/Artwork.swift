//
//  Artwork.swift
//  Flights App
//
//  Created by Shohzod Rajabov on 02/02/22.
//

import MapKit
import Contacts

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D

    init(title: String?, locationName: String?, coordinate: CLLocationCoordinate2D) {
    self.title = title
    self.locationName = locationName
    self.coordinate = coordinate
    }

    var subtitle: String? {
        return locationName
    }
    
    var mapItem: MKMapItem? {
      guard let location = locationName else {
        return nil
      }
      let addressDict = [CNPostalAddressStreetKey: location]
      let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
      let mapItem = MKMapItem(placemark: placemark)
      mapItem.name = title
      return mapItem
    }
    
}
