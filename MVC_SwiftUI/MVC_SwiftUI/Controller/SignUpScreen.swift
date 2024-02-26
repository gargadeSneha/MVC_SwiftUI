//
//  SignUpScreen.swift
//  MVC_SwiftUI
//
//  Created by Sneha Gargade on 21/02/24.
//

import SwiftUI

struct SignUpScreen: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var confirmPass: String = ""
    @State private var signUp: Bool = false
    
    var _loginCode: String
    var _userEmail: String

    
    var body: some View {
        NavigationStack{
            CustomTextField(placeholder: "FirstName", text: $firstName)
            CustomTextField(placeholder: "LastName", text: $lastName)
            CustomTextField(placeholder: "UserName", text: $userName)
            CustomTextField(placeholder: "Password", text: $password)
            CustomTextField(placeholder: "Confirm Password", text: $confirmPass)
            
            Button(action: {performSignUp()}, label: {
                Text("SIGNUP")
            }).font(.system(size: 20))
                .foregroundColor(.white)
                .frame(width: 200, height: 45)
                .background(Color.blue)
            
            NavigationLink(destination: HomeScreen(), isActive: $signUp) {
              var _ = print("afgrdfg")
            }
        }.onAppear{
            print("desrfg", _loginCode, _userEmail)
            getSignUp(_loginCode: _loginCode, _userName: _userEmail){ [self] signUp in
                if let response = signUp {
                    print("Message: \(response.data.value)")
                    lastName = response.data.value[0].lastName
                    firstName = response.data.value[0].firstName
                    userName = response.data.value[0].userName
                    
                }
            }
        }
    }
    
    func performSignUp(){
        signUp = true
        print("id: \(MyClass.id), statusID: \(1), lastName: \(lastName), firstName: \(firstName)!, userName: \(userName)!, id: \(MyClass.userID), schoolID: \(MyClass.schoolID), password: \(password)!")
        let teacherDetail = TeacherDetail(id: MyClass.id, statusID: 1)
        let user = User(lastName: lastName, firstName: firstName, userName: userName, id: MyClass.userID, schoolID: MyClass.schoolID, password: password, fcmToken: "cVUp3-flQuu3avaNK_XRNJ:APA91bFd6o73yXzRc_xfUdCO_SMdfEp1V6-LYfA3UUwBBWD_quFYQesA7OAnBDaqXZw64Ro1R4misqA9yBzENIs4MK8ZpQq5BjGA_VK1m0tp8bhyGjReEncRDBiG_pYTkOMjCcHQ03_L")
        let signUp = SignUp(teacherDetails: teacherDetail, users: user, edUQualification: nil, previousEMP: nil)
        
        SignUpCall(requestJson: signUp)
    }
}

#Preview {
    SignUpScreen(_loginCode: "1234", _userEmail: "teacher8AA1@wits.bz")
}
