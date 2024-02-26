//
//  StudentAttendanceModel.swift
//  MVC
//
//  Created by Sneha Gargade on 19/02/24.
//

import Foundation
// MARK: - Welcome
struct StudentAttendanceModel: Codable {
    let isSuccess: Bool
    let messageCaption, message, jsonMessageType, returnURL: String
    let flag: String
    let data: DataClass4?

    enum CodingKeys: String, CodingKey {
        case isSuccess, messageCaption, message, jsonMessageType
        case returnURL = "returnUrl"
        case flag
        case data
    }
}

// MARK: - DataClass
struct DataClass4: Codable {
    let contentType, serializerSettings, statusCode: JSONNull?
    let value: [Value2]
}

// MARK: - Value
struct Value2: Codable {
    let id: Int?
    let className: String?
    let gradeID: Int?
    let gradeName, icon, color: String?
    let classTermID, isEnrichmentClass: Int?
    let students: [Student1]

    enum CodingKeys: String, CodingKey {
        case id, className, gradeID, gradeName, icon, color
        case classTermID = "classTermId"
        case isEnrichmentClass, students
    }
}

// MARK: - Student
struct Student1: Codable, Hashable  {
    let classID: Int?
    let fullName: String?
    let userID: Int?
    let profilePicture, attendanceType: String?
    let attendanceID: Int?
    let attendance: JSONNull?
    let joiningDate: String?
    let admissionDate: JSONNull?
    let createdDate: String?
}
