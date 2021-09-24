//
//  SettingsViewController.swift
//  yaulyanenkovPW2
//
//  Created by Ярослав Ульяненков on 23.09.2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    var mainViewController:ViewController?
    
    private let settingsView = UIView();
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSettingsView()
        setupLocationToggle()
        setupSliders()
    }
    
    private func setupSettingsView() {
        view.addSubview(settingsView)
        settingsView.backgroundColor = .white
        settingsView.translatesAutoresizingMaskIntoConstraints = false
        settingsView.pin(to: view)
    }
    
    private func setupLocationToggle() {
        let locationToggle = UISwitch()
        settingsView.addSubview(locationToggle)
        locationToggle.isOn = mainViewController?.locationToggle.isOn ?? false
        locationToggle.translatesAutoresizingMaskIntoConstraints = false
        locationToggle.pinTop(to: settingsView.safeAreaLayoutGuide.topAnchor, 50)
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
        locationLabel.pinTop(to: settingsView.safeAreaLayoutGuide.topAnchor, 55)
        locationLabel.pinLeft(to: settingsView, 10)
        locationLabel.pinRight(to: locationToggle.leadingAnchor, 10)
    }
    
    @objc
    func locationToggleSwitched(_ sender: UISwitch) {
        mainViewController?.switchLocation(state: sender.isOn)
    }
    
    
    private let sliders = [UISlider(), UISlider(), UISlider()]
    private let colors = ["Red", "Green", "Blue"]
    private func setupSliders() {
        var top = 150
        for i in 0..<sliders.count {
            let view = UIView()
            settingsView.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.pinLeft(to: settingsView.safeAreaLayoutGuide.leadingAnchor, 10)
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
            slider.setValue(mainViewController?.sliders[i].value ?? 0, animated: false)
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
    @objc private func sliderChangedValue() {
        mainViewController?.sliders[0].setValue(sliders[0].value, animated: false)
        mainViewController?.sliders[1].setValue(sliders[1].value, animated: false)
        mainViewController?.sliders[2].setValue(sliders[2].value, animated: false)
        mainViewController?.sliderChangedValue()
    }
    
}
