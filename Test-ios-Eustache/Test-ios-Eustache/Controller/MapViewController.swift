//
//  MapViewController.swift
//  Test-ios-Eustache
//
//  Created by jeremy eustache on 03/07/2019.
//  Copyright © 2019 jeremy eustache. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    var mapView : MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = label.font.withSize(30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageViewCell : UIImageView = {
        let imageViewCell = UIImageView()
        
        imageViewCell.clipsToBounds = true
        imageViewCell.layer.borderWidth = 5
        imageViewCell.layer.borderColor = UIColor.white.cgColor
        
        imageViewCell.contentMode = UIView.ContentMode.scaleAspectFill
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        
        return imageViewCell
    }()
    
    var delivery : Delivery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Delivery detail"
        
        setupView()
        setupLocation()
        
        if let delivery = delivery, let imageUrl = delivery.imageUrl {
            imageViewCell.imageFromServer(urlString: imageUrl, placeholder: UIImage(named: "placeholder"))
            nameLabel.text = delivery.description
        }
    }
    
    func setupView(){
        
        view.backgroundColor = AppColor.mainColor
        
        view.addSubview(mapView)
        setupMapViewConstraint()
        
        view.addSubview(imageViewCell)
        setupImageViewConstraint()
        
        view.addSubview(nameLabel)
        setupLabelViewConstraint()
    }

    func setupMapViewConstraint() {

        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -300).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    }
    
    func setupImageViewConstraint() {

        imageViewCell.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 30).isActive = true
        imageViewCell.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        imageViewCell.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageViewCell.heightAnchor.constraint(equalTo:  imageViewCell.widthAnchor, multiplier: 1).isActive = true
        
        imageViewCell.layoutIfNeeded()
        imageViewCell.setRounded()

    }
    
    func setupLabelViewConstraint() {
        
        nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        nameLabel.topAnchor.constraint(equalTo: imageViewCell.bottomAnchor, constant: 10).isActive = true
    }
    
    func setupLocation(){
        
        guard let delivery = delivery,
            let location = delivery.location,
            let lat = location.lat,
            let lng = location.lng,
            let address = location.address
            else { return  }
        
        let initialLocation = CLLocation(latitude: lat, longitude: lng)
        
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let deliveryLocation = DeliveryLocation(title: address,
                                                coordinate: CLLocationCoordinate2D(latitude: lat, longitude:lng))
        mapView.addAnnotation(deliveryLocation)
        
    }
}
