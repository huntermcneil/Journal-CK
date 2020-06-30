//
//  EntryError.swift
//  Journal-CK
//
//  Created by Hunter McNeil on 6/29/20.
//  Copyright © 2020 Hunter McNeil. All rights reserved.
//

import Foundation

enum EntryError: LocalizedError {
    case ckError(Error)
    case couldNotUnwrap
}
