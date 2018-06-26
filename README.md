# TLSerializable

[![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/ysCharles/TLSerializable/master/LICENSE)
[![Pods Versions](https://img.shields.io/cocoapods/v/TLSerializable.svg?style=flat)](http://cocoapods.org/pods/TLSerializable)
[![CI Status](http://img.shields.io/travis/ysCharles/TLSerializable.svg?style=flat)](https://travis-ci.org/ysCharles/TLSerializable)
[![Swift Version Compatibility](https://img.shields.io/badge/swift4-compatible-4BC51D.svg?style=flat-square)](https://developer.apple.com/swift)
[![swiftyness](https://img.shields.io/badge/pure-swift-ff3f26.svg?style=flat)](https://swift.org/)
[![Swift Version](https://img.shields.io/badge/Swift-4.0-orange.svg?style=flat)](https://swift.org)
[![GitHub stars](https://img.shields.io/github/stars/ysCharles/TLSerializable.svg)](https://github.com/ysCharles/TLSerializable/stargazers)



## Installation

### Manually

* clone this repo.
* Simply drop the `Sources` folder into your project.
* Enjoy！ 

### Cocoapods

`TLSerializable` is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'TLSerializable'
```

### Carthage

```ruby
github "ysCharles/TLSerializable"
```

## Usage

* JSON string convert to Model

```swift
import TLSerializable

/// 转换成模型
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
    
    var jsonStr : String?
}
struct Test2: TLSerializable {
    lazy var name: String? = { return "我是test_name转换之后的\(test_name ?? "")" }()
    /// 测试文字
    var test_name:String?
    
    var detial:[Detial]?
    
}

// json字符串一键转模型
func test1(){
    let jsonString = "{\"status\":1000,\"message\":\"操作成功\",\"data\":{\"test\":\"0.05\",\"jsonStr\":\"{\\\"orderid\\\":1000,\\\"ordername\\\":\\\"hello kity\\\"}\"}}"
    var model = ModelObjetT<Test1>.deserialize(from: jsonString)
    print(model?.data?.test ?? "test无值")
    print(model?.data?.name ?? 0.00)
    print("============华丽的分割线==============")
}
func test2(){
    let jsonString = "{\"status\":1000,\"message\":\"操作成功\",\"data\":{\"test_name\":\"Decodable\",\"detial\":[{\"detial_name\":\"看吧嵌套毫无压力\"}]}}"
    var model = ModelObjetT<Test2>.deserialize(from: jsonString)
    print(model?.data?.test_name ?? "test无值")
    print(model?.data?.name ?? "name无值")
    print(model?.data?.detial?.first?.detial_name ?? "detial_name无值")
}

```

* Model convert to JSON string

  ```swift
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
  
  func test3() {
      let pet = Pet(name:"Kitty", desc : "It is a cat.")
      let person = Person(name: "Charles", age: 31, pet: pet)
      let str = person.serialize2JsonString()
      print(str)
  }
  ```

  

## License

`TLSerializable` is available under the MIT license. See the `LICENSE` file for more info.


