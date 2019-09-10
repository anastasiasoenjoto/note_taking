//
//  noteTakingView.swift
//  noteTaking
//
//  Created by Anastasia Riawan Soenjoto on 8/18/19.
//  Copyright © 2019 Anastasia Riawan Soenjoto. All rights reserved.
//

import UIKit

class noteTakingView: UIView {
    
    let header: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Notes"
        label.font = label.font.withSize(50)
        label.clipsToBounds = true

        return label
    }()

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 100, height: 150)
        flowLayout.minimumInteritemSpacing = 50
        flowLayout.minimumLineSpacing = 50
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.setCollectionViewLayout(flowLayout, animated: true)
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(header)
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        let constraints = [
        header.topAnchor.constraint(equalTo: self.topAnchor),
        header.heightAnchor.constraint(equalToConstant: 100),
        header.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
        header.rightAnchor.constraint(equalTo: self.centerXAnchor),
        collectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 105),
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor),
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
