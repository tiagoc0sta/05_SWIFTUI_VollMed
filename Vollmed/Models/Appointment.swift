//
//  Appointment.swift
//  Vollmed
//
//  Created by Tiago de Freitas Costa on 2024-06-06.
//

import Foundation

struct Appointment: Identifiable, Codable {
    let id: String
    let date: String
    let specialist: Specialist
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case date = "data"
        case specialist = "especialista"
    }
}

