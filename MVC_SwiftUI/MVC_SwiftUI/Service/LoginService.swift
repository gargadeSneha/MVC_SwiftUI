//
//  Service.swift
//  MVC
//
//  Created by Sneha Gargade on 14/02/24.
//

import Foundation

struct MyClass {
    static var id = 0
    static var schoolID = 0
    static var userID = 0
}

// Define a completion handler type that takes an optional LoginResponse object
typealias LoginCompletionHandler = (LoginResponse?) -> Void

func LoginAPICall(requestJson: LoginModel, completion: @escaping LoginCompletionHandler) {
    
    let url = URL(string: Constant.baseUrl + Constant.admain + "Login")! //change the url
    
    //create the session object
    let session = URLSession.shared
    
    //now create the URLRequest object using the url object
    var request = URLRequest(url: url)
    request.httpMethod = "POST" //set http method as POST
    
    do {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(requestJson)
        request.httpBody = jsonData
        print(request.httpBody)
    } catch let error {
        print(error.localizedDescription)
    }
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    //create dataTask using the session object to send data to the server
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
        guard error == nil else {
            print("Error: \(error!)")
            completion(nil) // Call completion with nil if there's an error
            return
        }
        
        guard let data = data else {
            print("No data received")
            completion(nil) // Call completion with nil if there's no data
            return
        }
        print(data)
        
        do {
            //create json object from data
            let objEmployee = try JSONDecoder().decode(LoginResponse.self, from: data)
            DispatchQueue.main.async {
                completion(objEmployee) // Call completion with the decoded object
//              print("Response: ", objEmployee)
            }
            
        } catch let error {
            print("Error decoding data: \(error)")
            completion(nil) // Call completion with nil if there's an error in decoding
        }
    })
    task.resume()
}

typealias signUp1CompletionHandler = (SignUp1?) -> Void

func getSignUp(_loginCode: Any, _userName: Any , completion: @escaping signUp1CompletionHandler) {
    let loginCodeString = String(describing: _loginCode)
       let userNameString = String(describing: _userName)
    guard let urlC = URL(string: Constant.baseUrl + Constant.admain + Constant.getTeacher + "?LoginCode=" + loginCodeString + "&username=" + userNameString)
       else{
           return
       }
    print(urlC)
       
       URLSession.shared.dataTask(with: urlC) { data, responce, error in
           if let error = error {
               print(error.localizedDescription)
           }
           if let data = data {
               do {
                   let jsondata = try JSONDecoder().decode(SignUp1.self, from: data)
                   
                   DispatchQueue.main.async {
                       print("jsondata:  ", jsondata)
                       completion(jsondata)
                       MyClass.id = jsondata.data.value[0].id
                       MyClass.schoolID = jsondata.data.value[0].schoolID
                       MyClass.userID = jsondata.data.value[0].userID
                   }
                   
               }catch {
                   print("somthing went wrong")
               }
           }
       }.resume()
   }


typealias SignUptionHandler = (SignUpResponse?) -> Void

func SignUpCall(requestJson: SignUp) {
    
    let url = URL(string: Constant.baseUrl + Constant.admain + Constant.saveTeacher)! //change the url
    print(url)
    //create the session object
    let session = URLSession.shared
    
    //now create the URLRequest object using the url object
    var request = URLRequest(url: url)
    request.httpMethod = "POST" //set http method as POST
    
    do {
        let jsonEncoder = JSONEncoder()
        let jsonData = try jsonEncoder.encode(requestJson)
        request.httpBody = jsonData
        print(request.httpBody)
    } catch let error {
        print(error.localizedDescription)
    }
    
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    //create dataTask using the session object to send data to the server
    let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
        
        guard error == nil else {
            print("Error: \(error!)")
//            completion(nil) // Call completion with nil if there's an error
            return
        }
        
        guard let data = data else {
            print("No data received")
//            completion(nil) // Call completion with nil if there's no data
            return
        }
        print(data)
        
        do {
            //create json object from data
            let objEmployee = try JSONDecoder().decode(SignUpResponse.self, from: data)
            DispatchQueue.main.async {
                print("-->",objEmployee)
//                completion(objEmployee) // Call completion with the decoded object
//              print("Response: ", objEmployee)
            }
            
        } catch let error {
            print("Error decoding data: \(error)")
//            completion(nil) // Call completion with nil if there's an error in decoding
        }
    })
    task.resume()
}
