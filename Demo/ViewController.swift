//
//  ViewController.swift
//  Demo
//
//  Created by Charles on 2018/5/18.
//  Copyright © 2018 Charles. All rights reserved.
//

import UIKit
import TLSerializable

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        test1()
        test2()
        test3()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK:- 编码使用的 结构体
struct Person : TLSerializable {
    //    enum CodingKeys: String, CodingKey {
    //        case name = "_name"
    //        case age = "_age"
    //    }
    
    let name: String
    let age: Int
    let pet: Pet
}

struct Pet: TLSerializable {
    let name: String
    let desc: String
}
// MARK: - 测试 decode
/// 只有状态值和提示信息的模型转化
struct ModelObjet: TLSerializable {
    /// 状态值
    var status:Int? = nil
    /// 提示信息
    var message:String? = nil
}

/// 转换成数组模型
struct ModelObjetT<T: TLSerializable>: TLSerializable {
    /// 状态值
    var status:Int? = nil
    /// 提示信息
    var message:String? = nil
    /// 嵌套模型
    var data:T? = nil
}

// 转换成数组模型
struct ModelArrayT<T: TLSerializable>: TLSerializable {
    /// 状态值
    var status:Int? = nil
    /// 提示信息
    var message:String? = nil
    /// 嵌套模型
    var data:[T]? = nil
}

struct Test1: TLSerializable {
    lazy var name: Double? = { return (Double(test ?? "0.00") ?? 0.00) * 100 }()
    /// 测试文字
    var test:String?
}
struct Test2: TLSerializable {
    lazy var name: String? = { return "我是test_name转换之后的\(test_name ?? "")" }()
    /// 测试文字
    var test_name:String?
    
    var detial:[Detial]?
    
}
struct Detial: TLSerializable {
    var detial_name: String?
}

// json字符串一键转模型
func test1(){
    let jsonString = "{\"status\":1000,\"message\":\"操作成功\",\"data\":{\"test\":\"0.05\"}}"
    //    let model = jsonString.jsonStringMapModel(ModelObjetT<Test1>.self)
    var model = ModelObjetT<Test1>.deserialize(from: jsonString)
    print(model?.data?.test ?? "test无值")
    print(model?.data?.name ?? 0.00)
    print("============华丽的分割线==============")
}
func test2(){
    let jsonString = "{\"status\":1000,\"message\":\"操作成功\",\"data\":{\"test_name\":\"Decodable\",\"detial\":[{\"detial_name\":\"看吧嵌套毫无压力\"}]}}"
    //    let model = jsonString.jsonStringMapModel(ModelObjetT<Test2>.self)
    var model = ModelObjetT<Test2>.deserialize(from: jsonString)
    print(model?.data?.test_name ?? "test无值")
    print(model?.data?.name ?? "name无值")
    print(model?.data?.detial?.first?.detial_name ?? "detial_name无值")
}

func test3() {
    let jsonString = """
        {
            "status":1000,
            "message":"操作成功",
            "data":[
                {"name":"Pet1","desc": "pet1 desc"},{"name":"Pet2","desc": "pet2 desc"},{"name":"Pet3","desc": "pet3 desc"},{"name":"Pet4","desc": "pet4 desc"},
            ]
        }
    """
    let model = ModelArrayT<Pet>.deserialize(from: jsonString)
    print(model)
}


