//
//  WebService.swift
//  Vollmed
//
//  Created by Giovanna Moeller on 12/09/23.
//

import UIKit

let patientID = "08d0a7a3-925e-4402-a43b-ec0fd0b12708"

struct WebService {
    
    private let baseURL = "http://localhost:3000"
    
    func scheduleAppointment(specialistID: String, 
                             patientID: String,
                             date: String) async throws -> ScheduleAppointmentResponse? {
            let endpoint = baseURL + "/consulta"
        
        guard let url = URL(string:endpoint) else {
            print("Erro na URL!")
            return nil
        }
        let appointment = ScheduleAppointmentRequest(specialist: specialistID, patient: patientID, date: date)
        
        let jsonData = try JSONEncoder().encode(appointment)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
        request.httpBody = jsonData
        
        let (data, _) = try await URLSession.shared.data(for:request)
        let appointmentResponse = try JSONDecoder().decode(ScheduleAppointmentResponse.self, from:data)
        
        return appointmentResponse
    }
    
    func downloadImage(from imageURL: String) async throws -> UIImage? {
        guard let url = URL(string: imageURL) else{
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data:data)
    }
    
    
    func getAllSpecialists() async throws -> [Specialist]? {
        let endpoint = baseURL + "/especialista"
        
        guard let url = URL (string: endpoint) else {
            print("Erro na URL!")
            return nil
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let specialists = try JSONDecoder().decode([Specialist].self, from: data)
        
        return specialists
    }
}
