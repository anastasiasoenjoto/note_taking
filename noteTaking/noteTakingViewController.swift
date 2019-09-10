//
//  noteTakingViewController.swift
//  noteTaking
//
//  Created by Anastasia Riawan Soenjoto on 8/18/19.
//  Copyright © 2019 Anastasia Riawan Soenjoto. All rights reserved.
//

import UIKit

class noteTakingViewController: UIViewController {

    let mainView = noteTakingView()
    let detailView = notesView()
    var noteDetails: [notesData] = []
    var isSortByDate: Bool = true
    let viewModel: noteTakingViewModel = noteTakingViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.view = mainView
        setupNavBar()
        setUpCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNew))
        if isSortByDate {
            
            sortByDate()
        }
        else {
            
            sortByAlpha()
        }
        
        mainView.collectionView.reloadData()
    }
    
    func setupNavBar() {
        let label =  UIBarButtonItem(title: "Sort by: ", style: .plain, target: self, action: nil)
        let dateButton = UIBarButtonItem(title: "Date", style: .plain, target: self, action: #selector(sortByDate))
        let alphabetButton = UIBarButtonItem(title: "Aa", style: .plain, target: self, action: #selector(sortByAlpha))
        self.navigationItem.leftBarButtonItems = [label, dateButton, alphabetButton]

    }
    
    func setUpCollectionView() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
    }
    
    func editTitle() -> UIAlertController {
        let alert = UIAlertController(title: "Enter Title", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter title"

        })

        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { action in
            if let titleEntered = alert.textFields?.first?.text {

                guard let idx = self.noteDetails.last?.idx else { return }
                let title = self.viewModel.setTitle(title: titleEntered)
                
                self.noteDetails[idx].title = title
                
                let vc = detailsViewController(notes: self.noteDetails[self.noteDetails.count - 1])
                vc.delegate = self
                self.navigationController?.pushViewController(vc, animated: false)
            
            }
        }))

        return alert
    }


    @objc func sortByDate() {
        isSortByDate = true
        let sortedNotes = viewModel.sortByDate(noteDetails: noteDetails)
        noteDetails = sortedNotes
        mainView.collectionView.reloadData()
    }
    
    @objc func sortByAlpha() {
        isSortByDate = false
        let sortedNotes = viewModel.sortByAlpha(noteDetails: noteDetails)
        noteDetails = sortedNotes
        
        mainView.collectionView.reloadData()
    }
    
    @objc func createNew() {
        noteDetails.append(notesData(idx: noteDetails.count, title: "", data: "", time: Date()))
        let alert = editTitle()
        self.present(alert, animated: true)
        
    }
    
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource
extension noteTakingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noteDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        cell.title.text = noteDetails[indexPath.item].title
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = detailsViewController(notes: noteDetails[indexPath.item])
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

// MARK: detailsViewControllerDelegate
extension noteTakingViewController: detailsViewControllerDelegate {
   
    //  updates contents of notes
    func updateNotes(notes: notesData) {
        noteDetails[notes.idx] = notes
    }
    
    //  deletes note at index idx
    func deleteNotes(idx: Int) {
        noteDetails.remove(at: idx)
    }
    // reloads collectionView
    func reloadCollectionView() {
        mainView.collectionView.reloadData()
    }
    
    
    
}

