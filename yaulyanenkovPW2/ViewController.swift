//
//  ViewController.swift
//  yaulyanenkovPW2
//
//  Created by Ярослав Ульяненков on 23.09.2021.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    private let settingsView = UIView()
    let locationTextView = UITextView()
    private let locationManager = CLLocationManager()
    let locationToggle = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationTextView()
        setupSettingsButton()
        setupSettingsView()
        setupLocationToggle()
        setupSliders()
        locationManager.requestWhenInUseAuthorization()
        // Do any additional setup after loading the view.
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private var buttonCount = 0
    @objc private func settingsButtonPressed() {
        let sv = SettingsViewController()
        sv.mainViewController = self
        switch buttonCount {
        case 0, 1:
            UIView.animate(withDuration: 0.1, animations: {
                self.settingsView.alpha = 1 - self.settingsView.alpha
            })
        case 2:
            navigationController?.pushViewController(sv, animated: true)
        case 3:
            present(sv, animated: true, completion: nil)
            buttonCount = -1
        default:
            buttonCount = -1
        }
        buttonCount += 1
        
    }
    
    private func setupSettingsButton() {
        let settingsButton = UIButton()
        view.addSubview(settingsButton)
        settingsButton.setImage(UIImage(named: "settings")?
                                    .withRenderingMode(.alwaysOriginal), for: .normal)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        settingsButton.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 20)
        settingsButton.addTarget(self, action: #selector(settingsButtonPressed),
                                 for: .touchUpInside)
        
    }
    
    private func setupSettingsView() {
        view.addSubview(settingsView)
        settingsView.backgroundColor = .white
        settingsView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 60)
        settingsView.pinRight(to: view.safeAreaLayoutGuide.trailingAnchor, 10)
        settingsView.setHeight(to: 300)
        settingsView.setWidth(to: 200)
        settingsView.alpha = 0
    }
    
    private func setupLocationTextView() {
        view.addSubview(locationTextView)
        locationTextView.backgroundColor = UIColor(hex: "#D6EAF8FF")
        locationTextView.layer.cornerRadius = 20
        locationTextView.translatesAutoresizingMaskIntoConstraints = false
        locationTextView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 60)
        locationTextView.pinCenter(to:  view.centerXAnchor)
        locationTextView.setHeight(to: 300)
        locationTextView.pinLeft(to: view.leadingAnchor, 15)
        locationTextView.isUserInteractionEnabled = false
    }
    
    private func setupLocationToggle() {
        settingsView.addSubview(locationToggle)
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.pinTop(to: settingsView, 50)
        locationToggle.pinRight(to: settingsView, 10)
        locationToggle.addTarget(
            self,
            action: #selector(locationToggleSwitched),
            for: .valueChanged
        )
        
        let locationLabel = UILabel()
        settingsView.addSubview(locationLabel)
        locationLabel.text = "Location"
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.pinTop(to: settingsView, 55)
        locationLabel.pinLeft(to: settingsView, 10)
        locationLabel.pinRight(to: locationToggle.leadingAnchor, 10)
    }
    
    @objc
    func locationToggleSwitched(_ sender: UISwitch) {
        if sender.isOn {
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy =
                    kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                sender.setOn(false, animated: true)
            }
        } else {
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
    }
    
    func switchLocation(state: Bool) {
        if state {
            locationToggle.setOn(true, animated: true)
            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy =
                    kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
            } else {
                locationToggle.setOn(false, animated: true)
            }
        } else {
            locationToggle.setOn(false, animated: false)
            locationTextView.text = ""
            locationManager.stopUpdatingLocation()
        }
    }
    
    let sliders = [UISlider(), UISlider(), UISlider()]
    private let colors = ["Red", "Green", "Blue"]
    private func setupSliders() {
        var top = 80
        for i in 0..<sliders.count {
            let view = UIView()
            settingsView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.leadingAnchor.constraint(
                equalTo: settingsView.leadingAnchor,
                constant: 10
            ).isActive = true
            view.trailingAnchor.constraint(
                equalTo: settingsView.trailingAnchor,
                constant: -10
            ).isActive = true
            view.topAnchor.constraint(
                equalTo: settingsView.topAnchor,
                constant: CGFloat(top)
            ).isActive = true
            view.heightAnchor.constraint(equalToConstant: 30).isActive =
                true
            top += 40
            
            let label = UILabel()
            view.addSubview(label)
            label.text = colors[i]
            label.translatesAutoresizingMaskIntoConstraints = false
            label.topAnchor.constraint(
                equalTo: view.topAnchor,
                constant: 5
            ).isActive = true
            label.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ).isActive = true
            label.widthAnchor.constraint(
                equalToConstant: 50
            ).isActive = true
            
            let slider = sliders[i]
            slider.translatesAutoresizingMaskIntoConstraints = false
            slider.minimumValue = 0
            slider.maximumValue = 1
            slider.addTarget(self, action:
                                #selector(sliderChangedValue), for: .valueChanged)
            view.addSubview(slider)
            slider.topAnchor.constraint(equalTo: view.topAnchor,
                                        constant: 5).isActive = true
            slider.heightAnchor.constraint(equalToConstant: 20).isActive
                = true
            slider.leadingAnchor.constraint(equalTo:
                                                label.trailingAnchor, constant: 10).isActive = true
            slider.trailingAnchor.constraint(equalTo:
                                                view.trailingAnchor).isActive = true
        }
    }
    @objc func sliderChangedValue() {
        let red: CGFloat = CGFloat(sliders[0].value)
        let green: CGFloat = CGFloat(sliders[1].value)
        let blue: CGFloat = CGFloat(sliders[2].value)
        view.backgroundColor = UIColor(red: red, green: green, blue:
                                        blue, alpha: 1)
    }
}

