//
//  WordList.swift
//  DatPoet
//
//  Created by student on 10/3/16.
//  Copyright © 2016 Erik Gerharter. All rights reserved.
//

import Foundation

class WordBank
{
    static let sharedData = WordBank()
    
    var wordLists = ["standardList":["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her","drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y", "write","while","on"], "snafuList":["you","have","been","coax","into","a","snafu","paypay","the","croaker","here","comes",                                                                                         "the","man","hi","how","are","you","yes","no","le","nice","maymay","man","why","ed","step","pls","it","is","twelve","o’clock","my","female","facial","hair","in","the","throat","area"], "vintageList":["awesum","sauce","never","gonna","give","you","up","trololo","y","u","do","dis","forever","alone","better","than","expected","pls","derp","poker","face","deal","with","it","good","guy","scumbag","bad","luck","gooby","over","nine","thousand","1337","hax","bro"]]
    
    private init()
    {
        
    }
    
    func getKeys() -> [String]
    {
        return Array(wordLists.keys.sorted())
    }
}
