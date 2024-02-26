//
//  LoginModel.swift
//  MVC_SwiftUI
//
//  Created by Sneha Gargade on 21/02/24.
//


import Foundation
struct LoginModel: Codable {
    let userName: String?
    let password: String?
    let deviceID: String?
    let loginMode: String?
    let accessMember: AccessMember
    let fcmToken: String

    enum CodingKeys: String, CodingKey {
        case userName = "UserName"
        case password = "Password"
        case deviceID = "DeviceID"
        case loginMode = "LoginMode"
        case accessMember = "AccessMember"
        case fcmToken
    }
}

// MARK: - AccessMember
struct AccessMember: Codable {
    let id, userID: Int
    let platform: String
    let deviceName: String
    let operatingSystem: String
    let deviceType: String
    let deviceModel: String
    let build: String
    let version: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case userID = "UserID"
        case platform = "Platform"
        case deviceName = "DeviceName"
        case operatingSystem = "OperatingSystem"
        case deviceType = "DeviceType"
        case deviceModel = "DeviceModel"
        case build = "Build"
        case version = "Version"
    }
}


struct LoginResponse: Codable {
    let isSuccess: Bool
    let messageCaption: String
    let message: String
    let jsonMessageType: String
    let returnURL: String?
    let flag: String?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case isSuccess = "isSuccess"
        case messageCaption = "messageCaption"
        case message = "message"
        case jsonMessageType = "jsonMessageType"
        case returnURL = "returnUrl"
        case flag, data
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let joiningDate, className, fullName, userID: JSONNull?
    let age: Int
    let gradeMasterID, gradeName, address, dateOfBirth: JSONNull?
    let classID, studentDetailsID: Int
    let lstcontactDetails: JSONNull?
    let profilePicture: String
    let profilePictureName, profilePictureExtention: JSONNull?
    let loginCode, fcmToken: String
    let studentName: JSONNull?
    let isPrimaryContact, studentCount, teacherCount, parentCount: Int
    let accessToken, refreshToken: String
    let objectChanged: Bool
    let id: Int
    let userName, deviceID, password, firstName: String
    let lastName: String
    let schoolID: Int
    let alternateEmail, phoneNumber: String
    let roleID, parentID, languageID: Int
    let isEmailVerified: Bool
    let emailVerificationDate, emailVerficationCode: String
    let statusID, isBulkUpload: Int
    let createdDate, updatedDate, fUserName, fPassword: String
    let loginMode: JSONNull?
    let isAdded: Int
    let relation: JSONNull?
    let schoolName: String?

    enum CodingKeys: String, CodingKey {
        case joiningDate, className, fullName
        case userID = "userId"
        case age, gradeMasterID, gradeName, address, dateOfBirth, classID, studentDetailsID
        case lstcontactDetails = "_lstcontactDetails"
        case profilePicture, profilePictureName, profilePictureExtention, loginCode, fcmToken, studentName, isPrimaryContact, studentCount, teacherCount, parentCount, accessToken, refreshToken, objectChanged, id, userName, deviceID, password, firstName, lastName, schoolID, alternateEmail, phoneNumber, roleID, parentID
        case languageID = "languageId"
        case isEmailVerified, emailVerificationDate, emailVerficationCode
        case statusID = "statusId"
        case isBulkUpload, createdDate, updatedDate, fUserName, fPassword, loginMode, isAdded, relation
        case schoolName = "schoolName"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}


struct SignUp: Codable {
    let teacherDetails: TeacherDetail
    let users: User
    let edUQualification, previousEMP: JSONNull?

    enum CodingKeys: String, CodingKey {
        case teacherDetails, users
        case edUQualification = "edU_Qualification"
        case previousEMP = "previous_EMP"
    }
}

// MARK: - TeacherDetails
struct TeacherDetail: Codable {
    let id, statusID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case statusID = "statusId"
    }
}
// MARK: - Users
struct User: Codable {
    let lastName, firstName, userName: String
    let id, schoolID: Int
    let password, fcmToken: String
}


struct SignUpResponse: Codable {
    let isSuccess: Bool
    let messageCaption, message, jsonMessageType, returnURL: String
    let flag: String
    let data: DataClass1?

    enum CodingKeys: String, CodingKey {
        case isSuccess, messageCaption, message, jsonMessageType
        case returnURL = "returnUrl"
        case flag, data
    }
}

// MARK: - DataClass
struct DataClass1: Codable {
    let teacherDetails: TeacherDetails
    let users: Users
    let edUQualification, previousEMP: JSONNull?

    enum CodingKeys: String, CodingKey {
        case teacherDetails, users
        case edUQualification = "edU_Qualification"
        case previousEMP = "previous_EMP"
    }
}

// MARK: - TeacherDetails
struct TeacherDetails: Codable {
    let statusID, id: Int

    enum CodingKeys: String, CodingKey {
        case statusID = "statusId"
        case id
    }
}

// MARK: - Users
struct Users: Codable {
    let fcmToken: String
    let id: Int
    let userName, password, firstName, lastName: String
    let schoolID, roleID: Int
}


// MARK: - getSignUp data
struct SignUp1: Codable {
    let isSuccess: Bool
    let messageCaption, message, jsonMessageType, returnURL: String
    let flag: String
    let data: DataClass2

    enum CodingKeys: String, CodingKey {
        case isSuccess, messageCaption, message, jsonMessageType
        case returnURL = "returnUrl"
        case flag, data
    }
}

// MARK: - DataClass
struct DataClass2: Codable {
    let contentType, serializerSettings, statusCode: JSONNull?
    let value: [Value]
}

// MARK: - Value
struct Value: Codable {
    let lastName, firstName, userName: String
    let roleID, id: Int
    let schoolID: Int
    let userID: Int
}

