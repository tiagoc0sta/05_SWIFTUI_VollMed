//
//  String+.swift
//  Vollmed
//
//  Created by Tiago de Freitas Costa on 2024-06-05.
//

import Foundation


extension String {
    func convertDateStringToReadableDate() -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyy-MM-dd'T'HH:mm.SSSZ"
        
        if let date = inputFormatter.date(from: self){
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yyy 'às' HH:mm"
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
}
