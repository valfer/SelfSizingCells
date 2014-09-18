//
//  Parser.swift
//  Parser
//
//  Created by Valerio2 on 26/06/14.
//  Copyright (c) 2014 Valerio2. All rights reserved.
//

import Foundation

class Parser {
    
    func parse() -> ([Photo], NSError?) {
        
        var error:NSError?
        var resultArray = [Photo]()
        
        // leggo il file
        let filePath = NSBundle.mainBundle().pathForResource("photos", ofType: "txt")
        if let filePathT = filePath {
            
            let fileContent = String.stringWithContentsOfFile(filePathT, encoding: NSUTF8StringEncoding, error: &error)
            
            if let _fileContent = fileContent {
                
                // trasformo tutto in un array (unwrap implicito)
                let linesArray:[String]! = _fileContent.componentsSeparatedByString("\n")
                
                // la prima riga contiene il nome dei campi
                var fields = String(format: linesArray[0])
                let fieldsArray = fields.componentsSeparatedByString("$")
                let totLines = linesArray.count
                
                for var i = 1; i < totLines; i++ {
                    
                    let line = linesArray[i] as String
                    
                    let tokens = line.componentsSeparatedByString("$")
                    var photo = Photo()
                        
                    for (index, value) in enumerate(tokens) {
                        
                        let fieldName = fieldsArray[index]
                        photo.setValue(value, forKey: fieldName.lowercaseString)
                    }
                    resultArray.append(photo)

                }
            } else {
                
                // in questo caso l'errore rimane error
            }
        } else {
            
            error = NSError.errorWithDomain("Parser", code: 101, userInfo: [NSLocalizedDescriptionKey:"File not found"])
        }
     
        return (resultArray, error)
    }
    
}