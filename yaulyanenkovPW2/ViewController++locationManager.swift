//
//  ViewController++locationManager.swift
//  yaulyanenkovPW2
//
//  Created by Ярослав Ульяненков on 23.09.2021.
//
import UIKit
import CoreLocation

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let coord: CLLocationCoordinate2D =
                manager.location?.coordinate else { return }
        locationTextView.text = "Coordinates = \(coord.latitude) \(coord.longitude)"
    }
}
