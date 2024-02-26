//
//  ContentView.swift
//  MVC_SwiftUI
//
//  Created by Sneha Gargade on 21/02/24.
//

import SwiftUI

struct ContentView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var loggedIn: Bool = false
    @State private var signUp: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var loginResponse: LoginResponse? = nil // Hold the response
    var body: some View {
        NavigationStack{
            VStack {
                CustomTextField(placeholder: "Email", text: $email)
                CustomTextField(placeholder: "password", text: $password)
                
                
            }
            Button(action: {performLogin(email: email, password: password)}) {
                Text("LOGIN")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
                    .frame(width: 200, height: 45)
                    .background(Color.blue)
            }
            .buttonStyle(PlainButtonStyle())
            .position(x: 200, y:20)
            NavigationLink(destination: HomeScreen(), isActive: $loggedIn) {
              var _ = print("afgrg")
            }
            NavigationLink(destination: SignUpScreen(_loginCode: password, _userEmail: email), isActive: $signUp) {
              var _ = print("afgrdfg")
            }
            .alert(isPresented: $showAlert) {
                            Alert(title: Text("Error!!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
        }
        
    }
    func performLogin(email: String, password: String) {
        print(email, password)
        let dictionary = Bundle.main.infoDictionary!
        let version = dictionary["CFBundleShortVersionString"] as! String
        let build = dictionary["CFBundleVersion"] as! String
        let accseMember = AccessMember(id: 0, userID: 0, platform: "iOS", deviceName: UIDevice.current.name, operatingSystem: UIDevice.current.systemVersion, deviceType: "iOS", deviceModel:  UIDevice.current.model, build: build, version: version)
        
        let login = LoginModel(userName: email, password: password, deviceID: UIDevice.current.identifierForVendor!.uuidString, loginMode: "APP", accessMember: accseMember, fcmToken: "cVUp3-flQuu3avaNK_XRNJ:APA91bFd6o73yXzRc_xfUdCO_SMdfEp1V6-LYfA3UUwBBWD_quFYQesA7OAnBDaqXZw64Ro1R4misqA9yBzENIs4MK8ZpQq5BjGA_VK1m0tp8bhyGjReEncRDBiG_pYTkOMjCcHQ03_L")
        
        LoginAPICall(requestJson: login) { loginResponse in
            // Handle the loginResponse here
            print(loginResponse)
            if let response = loginResponse {
                print("Message: \(response.message)")
                if response.message == "Data Saved Successfully" {
                    if(response.flag == "LOGIN_USING_CODE"){
                        //SignUp
                        signUp = true
                    }
                    else{
                        //Home
                        loggedIn = true
                    }
                    
                }else if(response.message == "Wrong password or email" || response.message == "Password not set, please use login code" || response.message == "This account is not associated with Toondemy Academy"){
                    showAlert = true
                    alertMessage = response.message
                }
                
                else {
                    print("something went wrong")
                }
            } else {
                // Handle error or nil response
                print("Error or nil response received")
            }
        }
    }
}



#Preview {
    ContentView()
}
