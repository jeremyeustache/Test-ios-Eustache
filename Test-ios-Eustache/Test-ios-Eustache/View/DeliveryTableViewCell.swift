//
//  DeliveryTableViewCell.swift
//  Test-ios-Eustache
//
//  Created by jeremy eustache on 03/07/2019.
//  Copyright © 2019 jeremy eustache. All rights reserved.
//

import UIKit

class DeliveryTableViewCell: UITableViewCell {
    
    var imageUrl : String?
    var descriptionDelivery : String?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let subView : UIView = {
        let subView = UIView()
        subView.layer.borderWidth = 1
        subView.layer.cornerRadius = 20
        subView.backgroundColor = UIColor.white
        subView.translatesAutoresizingMaskIntoConstraints = false
        return subView
    }()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.text = "Sample item"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageViewCell : UIImageView = {
        let imageViewCell = UIImageView()
        imageViewCell.image = UIImage(named: "placeholder")
        
        imageViewCell.clipsToBounds = true
        imageViewCell.layer.borderWidth = 1
        
        imageViewCell.contentMode = UIView.ContentMode.scaleAspectFill
        imageViewCell.translatesAutoresizingMaskIntoConstraints = false
        
        return imageViewCell
    }()
    
    func setupViews(){
        
        self.backgroundColor = AppColor.mainColor
        self.selectionStyle = .none

        addSubview(subView)
        setupSubViewConstraint()

        subView.addSubview(imageViewCell)
        setupImageViewCellConstraint()
        
        subView.addSubview(nameLabel)
        setupSubViewNameLabelConstraint()
        
        imageViewCell.layoutIfNeeded()
        imageViewCell.setRounded()
    }
    
    func setupSubViewConstraint(){
        subView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        subView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        subView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        subView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true

    }

    func setupImageViewCellConstraint(){
        imageViewCell.topAnchor.constraint(equalTo: subView.topAnchor, constant: 10).isActive = true
        imageViewCell.bottomAnchor.constraint(equalTo: subView.bottomAnchor, constant: -10).isActive = true
        imageViewCell.leadingAnchor.constraint(equalTo: subView.leadingAnchor, constant: 20).isActive = true
        imageViewCell.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageViewCell.heightAnchor.constraint(equalTo:  imageViewCell.widthAnchor, multiplier: 1).isActive = true
    }
    
    func setupSubViewNameLabelConstraint(){
        nameLabel.leadingAnchor.constraint(equalTo: self.imageViewCell.trailingAnchor, constant: 20).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: subView.trailingAnchor, constant: -10).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
