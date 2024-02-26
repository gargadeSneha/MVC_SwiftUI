//
//  AttendanceClassModel.swift
//  MVC
//
//  Created by Sneha Gargade on 19/02/24.
//

import Foundation
// MARK: - Welcome
struct AttendanceClassModel: Codable {
    let isSuccess: Bool
    let messageCaption, message, jsonMessageType, returnURL: String
    let flag: String
    let data: DataClass3?

    enum CodingKeys: String, CodingKey {
        case isSuccess, messageCaption, message, jsonMessageType
        case returnURL = "returnUrl"
        case flag, data
    }
}

// MARK: - DataClass
struct DataClass3: Codable {
    let contentType, serializerSettings, statusCode: JSONNull?
    let value: [Value1]
}

// MARK: - Value
struct Value1: Codable, Hashable {
    
    let id: Int
    let className: String
    let gradeID: Int
    let gradeName, icon, color: String
    let classTermID, isEnrichmentClass: Int
    let students: [Student]

    enum CodingKeys: String, CodingKey {
        case id, className, gradeID, gradeName, icon, color
        case classTermID = "classTermId"
        case isEnrichmentClass, students
    }
}

// MARK: - Student
struct Student: Codable, Hashable  {

    let classID: Int
    let fullName: String
    let userID: Int
    let profilePicture: String
    let attendanceType: JSONNull?
    let attendanceID: Int
    let attendance: JSONNull?
    let joiningDate, admissionDate, createdDate: String
}
