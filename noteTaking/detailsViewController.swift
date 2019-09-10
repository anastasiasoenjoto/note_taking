//
//  detailsViewController.swift
//  noteTaking
//
//  Created by Anastasia Riawan Soenjoto on 8/22/19.
//  Copyright © 2019 Anastasia Riawan Soenjoto. All rights reserved.
//

import UIKit

protocol detailsViewControllerDelegate {
    func updateNotes(notes: notesData)
    func deleteNotes(idx: Int)
    func reloadCollectionView()
}

class detailsViewController: UIViewController {

    var delegate: detailsViewControllerDelegate?
    let mainView = notesView()
    var currentNote: notesData

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = mainView
        setupNavBar()
        setupToolBar()
    }
    
    init(notes: notesData) {
        self.currentNote = notes
        super.init(nibName: nil, bundle: nil)
        self.title = currentNote.title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainView.text.attributedText = NSAttributedString(string: currentNote.data)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let title = currentNote.title
        if !mainView.text.text.isEmpty {
            delegate?.updateNotes(notes: notesData(idx: currentNote.idx, title: title, data: mainView.text.text, time: Date()))
        }
        else {
            delegate?.deleteNotes(idx: currentNote.idx)
        }
    }
    
    func setupNavBar() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(saveNotes))
        
        self.navigationItem.rightBarButtonItem = doneButton
        self.navigationController?.isToolbarHidden = false
    }
    
    func setupToolBar() {
        let editButton = UIBarButtonItem(title: "Rename", style: .plain, target: self, action: #selector(editTitle))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let delete = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteNote))
        
        self.setToolbarItems([flexibleSpace, editButton, flexibleSpace, delete], animated: true)
    }
    
    @objc func deleteNote() {
        self.mainView.text.text = ""
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func editTitle() {
        let alert = UIAlertController(title: "Edit Title", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter new title"
            
        })
        
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            if let title = alert.textFields?.first?.text {
                self.title = title
                self.currentNote.title = title
            }
        }))
        
        self.present(alert, animated: true)

    }
    
    @objc func saveNotes() {
        let title = currentNote.title
        if !mainView.text.text.isEmpty {
            delegate?.updateNotes(notes: notesData(idx: currentNote.idx, title: title, data: mainView.text.text, time: Date()))
        }
        self.navigationController?.popViewController(animated: true)
    }
}
