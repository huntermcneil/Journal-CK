//
//  DateExtension.swift
//  Journal-CK
//
//  Created by Hunter McNeil on 6/29/20.
//  Copyright © 2020 Hunter McNeil. All rights reserved.
//

import Foundation

extension Date {
    
    func dateAsString() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        
        return formatter.string(from: self)
    }
    
}
