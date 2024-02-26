//
//  HomeScreen.swift
//  MVC_SwiftUI
//
//  Created by Sneha Gargade on 21/02/24.
//

import SwiftUI

struct HomeScreen: View {
    @State private var attendanceClass = [Value1]()

    var body: some View {
        NavigationView {
            List {
                ForEach(attendanceClass, id: \.id) { item in
                    NavigationLink(destination: StudentAttendanceScreen(id: item.id)) {
                            Text(item.className)
                        }
                }
            }
        }.onAppear {
            getAttendanceClassData {[self] AttendanceClassModel in
                    if let attendanceData = AttendanceClassModel?.data {
                     attendanceClass = attendanceData.value
                        DispatchQueue.main.async {
                           
                        }
                    }
                }
        }
    }
}

#Preview {
    HomeScreen()
}
