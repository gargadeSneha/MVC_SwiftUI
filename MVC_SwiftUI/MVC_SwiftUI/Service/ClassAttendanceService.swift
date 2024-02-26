//
//  AttendanceClassService.swift
//  MVC
//
//  Created by Sneha Gargade on 19/02/24.
//

import Foundation

typealias attendanceClassCompletionHandler = (AttendanceClassModel?) -> Void
func getAttendanceClassData(completion: @escaping attendanceClassCompletionHandler) {
    guard let urlC = URL(string:"https://tdacademy.logthis.in/api/Class/GetClass/13446?AttendanceDate=13-11-23&SchoolStudents=true&SrNo=0&Limit=0")
       else{
           return
       }
    print(urlC)
       
       URLSession.shared.dataTask(with: urlC) { data, responce, error in
           if let error = error {
               print(error.localizedDescription)
           }
           guard let data = data else {
               print("No data received")
               completion(nil) // Call completion with nil if there's no data
               return
           }
           print(data)
//           if let data = data {
               print("fafg")
               do {
                   let jsondata = try JSONDecoder().decode(AttendanceClassModel.self, from: data)
                   print("sff")
                   DispatchQueue.main.async {
                       completion(jsondata)
                   }
               }catch {
                   print("somthing went wrong :", error.localizedDescription)
               }
//           }
       }.resume()
   }
