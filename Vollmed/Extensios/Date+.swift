//
//  Date+.swift
//  Vollmed
//
//  Created by Tiago de Freitas Costa on 2024-06-05.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyy-MM-dd'T'HH:mm.SSSZ"
        return dateFormatter.string(from: self)
    }
}
