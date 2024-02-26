//
//  StudentAttendanceScreen.swift
//  MVC_SwiftUI
//
//  Created by Sneha Gargade on 22/02/24.
//

import SwiftUI
import Combine

class MyData {
    static let shared = MyData()
    var attendanceClass: [Student1] = []
    
    private init() {}
}

struct StudentAttendanceScreen: View {
    @State private var attendanceClass1: [Student1] = []
    @State private var isLoadingData = true // State variable to track
    @State private var scrolledToBottom = false
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var offset = 0
    @State private var isSelected = false
    @State private var scrollOffset: CGFloat = 0 // Track previous content height
    var limit = 5
    var totalStudent = 0
    var id: Int
    
    let dropDwnArray = ["Sort by A to Z","Sort by Z to A","Sort by Date 1-30","Sort by Date 30-1"]
    
    var body: some View {
        NavigationView {
            ScrollViewReader { scrollView in
                ZStack {
                    List(attendanceClass1, id: \.self) { item in
                        Text(item.fullName!)
                            .frame(width: 200, height: 100, alignment: .leading)
                            .onAppear {
                                if item == attendanceClass1.last {
                                    scrolledToBottom = true
                                }
                            }
                    }.position(x: 200, y: 300)
                        .onChange(of: scrolledToBottom) { scrolled in
                            if scrolled {
                                print("Scrolled to bottom")
                                isLoadingData = true
                                loadMoreData(scrollView: scrollView)
                                scrolledToBottom = false
                                
                            }
                        }
                        .onAppear {
                            scrollView.scrollTo(attendanceClass1.last, anchor: .bottom)
                        }
                    if isLoadingData {
                        ProgressView("Loading...")
                    }
                    if isSelected{
                        var _ = print("dfsfsfsfsf")
                        VStack(alignment: .leading){
                            Button(action: {
                                isSelected.toggle()
                                SortByFullName(type: "nameAZ")
                            }){
                                Text("Sort A-Z")
                                    .foregroundColor(.black)
                            }
                            Button(action: {
                                SortByFullName(type: "nameZA")
                                isSelected.toggle()
                            }){
                                Text("Sort Z-A")
                                    .foregroundColor(.black)
                            }
                            Button(action: {
                                isSelected.toggle()
                                SortByFullName(type: "date130")
                            }){
                                Text("Sort 1-30")
                                    .foregroundColor(.black)
                            }
                            Button(action: {
                                isSelected.toggle()
                                SortByFullName(type: "date301")
                            }){
                                Text("Sort 30-1")
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: 200, height: 100, alignment: .leading)
                        .background(.gray)
                        .position(x: 300, y: 52)
                    }
                }
                .toolbar {
                    Button("Sort") {
                        isSelected.toggle()
                    }
                }.background(
                    GeometryReader { proxy in
                        Color.clear
                            .preference(key: ViewOffsetKey.self, value: proxy.frame(in: .named("scroll")).minY)
                    }
                )
                .onPreferenceChange(ViewOffsetKey.self) { value in
                    scrollOffset = value
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("No More Data"), message: Text("There are no more students to display."), dismissButton: .default(Text("OK")))
            }
            
        }
        .onAppear {
            getStudentAttendanceData(id: id, offset: offset) { studentData in
                if let attendanceData = studentData?.data {
                    attendanceClass1 = attendanceData.value[0].students
                    isLoadingData = false
                }
            }
        }
        
    }
    
    func SortByFullName(type: String) {
        print("Called", attendanceClass1)
        attendanceClass1.sort { (student1, student2) -> Bool in
            // Access the value associated with the key "fullName" from each dictionary
            if type == "nameAZ"{
                print("===> ", student1.fullName, student2.fullName)
                if let fullName1 = student1.fullName, let fullName2 = student2.fullName {
                    // Compare the full names in ascending order
                    return fullName1 < fullName2
                }
            }else if type == "nameZA"{
                if let fullName1 = student1.fullName, let fullName2 = student2.fullName {
                    return fullName1 > fullName2
                }
            }else if type == "date130"{
                print("===> ", student1.createdDate, student2.createdDate)
                if let createdDate1 = student1.createdDate, let createdDate2 = student2.createdDate {
                    return createdDate1 < createdDate2
                }
            }else {
                if let createdDate1 = student1.createdDate, let createdDate2 = student2.createdDate {
                    return createdDate1 > createdDate2
                }
            }
            // Handle the case when fullName is not available
            return false
        }
        
    }
    
    func loadMoreData(scrollView: ScrollViewProxy) {
        isLoadingData = true
        let currentOffset = scrollOffset // Store current scroll offset
        print("API")
        offset = offset + 10
        print("offset: ",offset)
        
        getStudentAttendanceData(id: id, offset: offset) { [self] Student in
            isLoadingData = false
            if let attendanceData = Student?.data,  !attendanceData.value[0].students.isEmpty {
                
                // Append the new data to the existing array
                print(attendanceData.value[0].students)
                attendanceClass1.append(contentsOf: attendanceData.value[0].students)
                
                DispatchQueue.main.async {
                    scrollView.scrollTo(currentOffset, anchor: .top)
                }
            }else{
                DispatchQueue.main.async {
                    
                    showAlert = true
                }
            }
        }
    }
    
    
    
}
struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
#Preview {
    StudentAttendanceScreen(id: 45)
}

