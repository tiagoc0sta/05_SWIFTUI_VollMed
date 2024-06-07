//
//  ScheduleAppointmentView.swift
//  Vollmed
//
//  Created by Tiago de Freitas Costa on 2024-06-04.
//

import SwiftUI

struct ScheduleAppointmentView: View {
    
    let service = WebService()
    
    var specialistID: String
    var isRescheduledView: Bool
    var appointmentID: String?
    
    @State private var selectedDate = Date()
    @State private var showAlert = false
    @State private var isAppointmentScheduled = false
    
    init(specialistID: String, isRescheduledView: Bool = false, appointmentID: String? = nil ){
        self.specialistID = specialistID
        self.isRescheduledView = isRescheduledView
        self.appointmentID = appointmentID
    }
    
    func rescheduleAppointment() async{
        
    }
    
    func scheduleAppointment() async {
        do{
            if let _ = try await
                service.scheduleAppointment(specialistID: specialistID, patientID: patientID, date: selectedDate.convertToString()) {
                isAppointmentScheduled = true
            } else {
                isAppointmentScheduled = false
            }
        } catch {
            isAppointmentScheduled = false
            print("Ocorreu um erro ao agendar consulta: \(error)")
        }
        showAlert = true
        
    }
    
    var body: some View {
        VStack{
            Text("Selecione a data e o horario da Consulta")
                .font(.title3)
                .bold()
                .foregroundStyle(.accent)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            DatePicker("Escolha a data da consulta", selection:$selectedDate, in: Date()...)
                .datePickerStyle(.graphical)
            
            Button(action: {
                Task{
                    if isRescheduledView{
                        await rescheduleAppointment()
                    } else {
                        
                        await scheduleAppointment()
                    }
                }
            }, label: {
                ButtonView(text: isRescheduledView ? "Reagendar            consulta" : "Agendar consulta")
            })
        }
        .padding()
        .navigationTitle(isRescheduledView ? "Reagendar consulta" : "Agendar consulta")
        .navigationBarTitleDisplayMode(.large)
        .onAppear{
            UIDatePicker.appearance().minuteInterval = 15
        }
        .alert(isAppointmentScheduled ? "Sucesso!" : "Ops, algo deu errado!", isPresented: $showAlert, presenting: isAppointmentScheduled) { _ in
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Ok")
            })
        } message: { isScheduled in
            if isScheduled {
                Text("A consulta foi \(isRescheduledView ? "reagendada" : "agendada") com sucesso!")
            } else {
                Text("Houve um erro ao \(isRescheduledView ? "reagendar" : "agendar") sua consulta. Por favor tente novamente ou entre em contato via telefone.")
            }
        }

    }
}

#Preview {
    ScheduleAppointmentView(specialistID: "123")
}
