//
//  TLSerializable.swift
//  TLSerializable
//
//  Created by Charles on 2018/5/18.
//  Copyright © 2018 Charles. All rights reserved.
//
import Foundation

public protocol TLSerializable : Codable {
    /// 对象序列化为 Data
    ///
    /// - Returns: Data 序列化后的 Data
    func serialize2Data() -> Data?
    /// 对象序列化为 json 字符串
    ///
    /// - Returns: 序列化后的 json 字符串
    func serialize2JsonString() -> String?
    
    
    /// 反序列化
    ///
    /// - Parameter data: 需要反序列化的 Data 数据
    /// - Returns: 返回对象
    static func deserialize(from data: Data) -> Self?
    
    /// 反序列化
    ///
    /// - Parameter jsonString: 需要反序列化的 json 字符串
    /// - Returns: 返回对象
    static func deserialize(from jsonString: String) -> Self?
}

extension TLSerializable {
    /// 对象序列化为 Data
    ///
    /// - Returns: Data 序列化后的 Data
    public func serialize2Data() -> Data? {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(self)
            return encodedData
        } catch {
            print("encode error: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// 对象序列化为 json 字符串
    ///
    /// - Returns: 序列化后的 json 字符串
    public func serialize2JsonString() -> String? {
        guard let encodedData = serialize2Data() else { return nil }
        let encodedString = String(data: encodedData, encoding: .utf8)
        return encodedString
    }
    
    /// 反序列化
    ///
    /// - Parameter data: 需要反序列化的 Data 数据
    /// - Returns: 返回对象
    public static func deserialize(from data: Data) -> Self? {
        do {
            let decoder = JSONDecoder()
            let obj = try decoder.decode(Self.self, from: data)
            return obj
        } catch {
            print("decode error: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// 反序列化
    ///
    /// - Parameter jsonString: 需要反序列化的 json 字符串
    /// - Returns: 返回对象
    public static func deserialize(from jsonString: String) -> Self? {
        guard let data = jsonString.data(using: .utf8) else { return nil }
        return deserialize(from: data)
    }
}
