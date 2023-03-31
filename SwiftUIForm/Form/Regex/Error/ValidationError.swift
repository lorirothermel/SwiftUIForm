//
//  ValidationError.swift
//  SwiftUIForm
//
//  Created by Lori Rothermel on 3/30/23.
//

import Foundation

enum ValidationError: Error {
    case custom(message: String)
}


extension ValidationError {
    var errorDescription: String {
        switch self {
        case .custom(let message):
            return message
        }
    }
}
