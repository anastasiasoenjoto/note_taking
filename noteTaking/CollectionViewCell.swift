//
//  CollectionViewCell.swift
//  noteTaking
//
//  Created by Anastasia Riawan Soenjoto on 8/18/19.
//  Copyright © 2019 Anastasia Riawan Soenjoto. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.font = label.font.withSize(20)
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(title)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let constraints = [
            title.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -50),
            title.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            title.leftAnchor.constraint(equalTo: self.leftAnchor),
            title.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
