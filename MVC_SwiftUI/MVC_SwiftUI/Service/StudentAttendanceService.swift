//
//  StudentAttendanceService.swift
//  MVC
//
//  Created by Sneha Gargade on 19/02/24.
//


import Foundation

typealias StudentAttendanceCompletionHandler = (StudentAttendanceModel?) -> Void

func getStudentAttendanceData(id: Int, offset: Int, completion: @escaping StudentAttendanceCompletionHandler) {
    guard let url = URL(string: "https://tdacademy.logthis.in/api/Class/GetClass/13446?AttendanceDate=19-02-24&SchoolStudents=true&SrNo=\(offset)&ClassID=\(id)&Limit=10") else {
        print("Invalid URL")
        completion(nil) // Call completion handler with nil when URL is invalid
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("Error fetching data: \(error.localizedDescription)")
            completion(nil) // Call completion handler with nil when there's an error
            return
        }
        
        guard let data = data else {
            print("Data is empty")
            completion(nil) // Call completion handler with nil when data is empty
            return
        }
        
        do {
            let jsonData = try JSONDecoder().decode(StudentAttendanceModel.self, from: data)
            DispatchQueue.main.async {
                completion(jsonData) // Call completion handler with decoded data
            }
        } catch {
            print("Error decoding data: \(error.localizedDescription)")
           
                DispatchQueue.main.async {
                    completion(nil) // Call completion handler with nil when there's an error in decoding
                }
        }
    }.resume()
}
