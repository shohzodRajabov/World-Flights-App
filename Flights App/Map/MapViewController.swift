//
//  MapViewController.swift
//  Flights App
//
//  Created by Shohzod Rajabov on 02/02/22.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    var mapView = MKMapView()
    let backButton = UIBarButtonItem()
    let w = UIScreen.main.bounds.width
    let h = UIScreen.main.bounds.height
    
    var routes: Routes?
    var artworks = [Artwork]()
    var regions = [CLLocationCoordinate2D]()
    var tabIndex: Int?
    var collIndex: Int?
    let mapTypes: [String] = ["Standard", "Hybrid", "HybridFlyover"]
    
    lazy var segmentControl: UISegmentedControl = {
        let sc: UISegmentedControl = UISegmentedControl(items: mapTypes)
        sc.layer.position = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height-100)
        sc.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        sc.tintColor = UIColor.white.withAlphaComponent(0.6)
        sc.addTarget(self, action: #selector(segconChanged(_:)), for: .valueChanged)
        sc.selectedSegmentIndex = 0
        return sc
    }()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureSearchBar()
    }
    
    func configureSearchBar() {
        backButton.title = nil
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.backgroundColor = .clear
        
        view.addSubview(mapView)
        mapView.frame = CGRect(x: 0, y: 0, width: w, height: h)
        mapView.delegate = self
        self.view.addSubview(segmentControl)
        
        if let route = routes {
            createAnnotations(routes: route, index: tabIndex ?? 0)
            for item in artworks {
                mapView.addAnnotation(item)
            }
            let span = MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180)
            let region = MKCoordinateRegion(center: regions[collIndex ?? 0] , span: span)
            mapView.setRegion(region, animated: true)
            for i in 0..<regions.count {
                drawLine(x1: artworks[2*i].coordinate.latitude, y1: artworks[2*i].coordinate.longitude, x2: artworks[2*i+1].coordinate.latitude, y2: artworks[2*i+1].coordinate.longitude)
            }
        }
    }
    
    @objc private func segconChanged(_ segcon: UISegmentedControl) {
        switch(segcon.selectedSegmentIndex) {
        case 0: mapView.mapType = MKMapType.standard
            self.navigationController?.navigationBar.tintColor = .black
        case 1: mapView.mapType = MKMapType.hybrid
            self.navigationController?.navigationBar.tintColor = .black
        case 2: mapView.mapType = MKMapType.hybridFlyover
            self.navigationController?.navigationBar.tintColor = .white
        default: print("Error")
        }
    }
    
    func drawLine(x1: Double, y1: Double, x2: Double, y2: Double) {
        var coordinates_1 = [CLLocationCoordinate2D(latitude: x1, longitude: y1), CLLocationCoordinate2D(latitude: x2, longitude: y2)]
        let myPolyLine_1: MKPolyline = MKPolyline(coordinates: &coordinates_1, count: coordinates_1.count)
        mapView.addOverlay(myPolyLine_1)
    }
    
    func createAnnotations(routes: Routes, index: Int) {
        if  routes.flights.count != 0 {
            for item in routes.flights[index] {
                let from = item.orig ?? ""
                let to = item.dest ?? ""

                let ftitle = routes.airports["\(from)"]?.city_en ?? ""
                let fcoord = CLLocationCoordinate2D(
                    latitude: Double(routes.airports["\(from)"]?.lat ?? "") ?? 0,
                    longitude: Double(routes.airports["\(from)"]?.lng ?? "") ?? 0)
                let finfo = "\(routes.airports["\(from)"]?.country ?? ""), \(routes.airports["\(from)"]?.iata ?? ""), \(routes.airports["\(from)"]?.name ?? "")"
                
                let ttitle = routes.airports["\(to)"]?.city_en ?? ""
                let tcoord = CLLocationCoordinate2D(
                    latitude: Double(routes.airports["\(to)"]?.lat ?? "") ?? 0,
                    longitude: Double(routes.airports["\(to)"]?.lng ?? "") ?? 0)
                let tinfo = "\(routes.airports["\(to)"]?.country ?? ""), \(routes.airports["\(to)"]?.iata ?? ""), \(routes.airports["\(to)"]?.name ?? "")"
                
                artworks.append(Artwork(title: ttitle,locationName: tinfo,coordinate: tcoord))
                artworks.append(Artwork(title: ftitle, locationName: finfo, coordinate: fcoord))
                regions.append(fcoord)
            }
        }
    }
    
    
    
    
    
}


extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let myPolyLineRendere: MKPolylineRenderer = MKPolylineRenderer(overlay: overlay)
        myPolyLineRendere.lineWidth = 3
        myPolyLineRendere.strokeColor = UIColor.red
        return myPolyLineRendere
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Artwork else {
          return nil
        }
        let identifier = "artwork"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(
          withIdentifier: identifier) as? MKMarkerAnnotationView {
          dequeuedView.annotation = annotation
          view = dequeuedView
        } else {
          view = MKMarkerAnnotationView(
            annotation: annotation,
            reuseIdentifier: identifier)
            view.tag = 100
          view.canShowCallout = true
          view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIImageView(image: UIImage(named: "map")) //UIButton(type: .infoLight)
        }
        return view
      }
}
