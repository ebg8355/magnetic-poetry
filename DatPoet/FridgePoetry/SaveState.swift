//
//  SaveState.swift
//  DatPoet
//
//  Created by student on 10/16/16.
//  Copyright © 2016 Erik Gerharter. All rights reserved.
//

import UIKit

class SaveState
{
    static let sharedData = SaveState()
    var wordList: String = "standardList"
    {
        didSet
        {
            let defaults = UserDefaults.standard
            defaults.set(wordList, forKey: WORDLIST_KEY)
        }
    }
    
    /*var background: UIImage?
    {
        didSet
        {
            let defaults = UserDefaults.standard
            defaults.set(background, forKey: BACKGROUND_KEY)
        }
    }*/
    
    let WORDLIST_KEY = "wordListKey"
    //let BACKGROUND_KEY = "backgroundKey"
    
    private init()
    {
        readDefaultsData()
    }
    
    private func readDefaultsData()
    {
        let defaults = UserDefaults.standard
        
        if let s = defaults.object(forKey: WORDLIST_KEY)
        {
            wordList = s as! String
        }
        
        else
        {
            wordList = "standardList"
        }
        
        /*if let image = defaults.object(forKey: BACKGROUND_KEY)
        {
            background = image as? UIImage
        }*/
    }
}
