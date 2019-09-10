//
//  noteTakingViewModel.swift
//  noteTaking
//
//  Created by Anastasia Riawan Soenjoto on 9/10/19.
//  Copyright © 2019 Anastasia Riawan Soenjoto. All rights reserved.
//

import Foundation
import UIKit


public class noteTakingViewModel: NSObject {
    
    // sorts noteDetails based on the time created
    func sortByDate(noteDetails: [notesData]) -> [notesData] {
        let sortedNotes = noteDetails.sorted(by: {
            $0.time > $1.time
        })
        
        return sortedNotes
    }
    
    //  sorts noteDetails alphabetically
    func sortByAlpha(noteDetails: [notesData]) -> [notesData] {
        let sortedNotes = noteDetails.sorted(by: {
            $0.title.lowercased() < $1.title.lowercased()
            
        })
        
        return sortedNotes
    }
    
    // sets title based on title entered by user
    func setTitle(title: String) -> String {
        return title.isEmpty ? "Untitled" : title
    }
}
