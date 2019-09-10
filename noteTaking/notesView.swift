//
//  notesView.swift
//  noteTaking
//
//  Created by Anastasia Riawan Soenjoto on 8/19/19.
//  Copyright © 2019 Anastasia Riawan Soenjoto. All rights reserved.
//

import UIKit

class notesView: UIView {

    let text: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.clipsToBounds = true
        
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let constraints = [
            text.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            text.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            text.leftAnchor.constraint(equalTo: self.leftAnchor),
            text.rightAnchor.constraint(equalTo: self.rightAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
