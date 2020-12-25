import UIKit

var str = "Hello, playground"

// Breaking out of many loops
outerLoop: for i in 1...2 {
    for j in 1...2 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")
        
        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

// Functions

func printHelp() {
    let message = """
Welcome to MyApp!

Run this app inside a directory of images and
MyApp will resize them all into thumbnails
"""
    
    print(message)
}
printHelp()

func square(number: Int) -> Int {
    return number
}
square(number: 2)

// parameter lables
func sayHello(to name: String) { // to is external, name is internal
    // To not need this, instead of "to", put "_"
    print("Hello, \(name)!")
}
sayHello(to: "your Momma")

// Variable length parameters
func squares(numbers: Int...) {
    for number in numbers {
        print("\(number) squared is \(number * number)")
    }
}
squares(numbers: 1,2)

// Setting throws
enum PasswordError: Error {case obvious}
func checkPassword(_ password: String) throws -> Bool {
    if (password == "password") {
        throw PasswordError.obvious
    }
    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}

if let result = try? checkPassword("password") {
    print("Result was \(result)")
} else {
    print("Oops")
}

// Pass by reference
var changingValue: Int = 3
func changeVal(_ num: inout Int) {
    num = 4
}
changeVal(&changingValue)
changingValue

// Closures
let driving = { (place: String) -> String in
    return "I'm driving to \(place) in my car"
}

// function that takes in a closure
func travel(place:String, action: (String) -> String) {
    let desc = action(place)
    print(desc)
}
travel(place: "London", action: driving)
travel(place: "Johor") { (place: String) -> String in
    return "I'm driving to \(place) in my car" // Trailing closure syntax
}
// The following is possible because it know we must return a String and take in a string
travel(place: "Urmahderhous") {
    "I'm driving to \($0) in my car" // Short hand syntax
}

let travelClosure = {
    (place: String, action: (String) -> String) -> Void in
    let desc = action(place)
    print("closure: " + desc)
}
// No parameter labels for closures
travelClosure("London", driving)
travelClosure("Johor") { (place: String) -> String in
    return "I'm driving to \(place) in my car" // Trailing closure syntax
}
travelClosure("Urmahderhous") {
    "I'm driving to \($0) in my car" // Short hand syntax
}

// DAY 8

struct Person {
    var name: String
    // static
    static var population = 0
    init(name: String) {
        self.name = name
        self.age = 0
        Person.population += 1
    }
    
    var age: Int {
        // property observer
        didSet {
            print("old value: \(oldValue)") // didSet has a oldValue
            self.congratulate()
        }
        
        // willSet will have a value called newValue
    }
    var canDrink: Bool {
        return age >= 18
    }
    func congratulate() {
        print("Happy birthday! You are now \(age)!")
    }
    mutating func setName(name newName: String) {
        name = newName
    }
}
// Note that only var person can set name changes
var person1 = Person(name: "Bob")
person1.setName(name: "Ann")
person1.name
person1.canDrink
person1.age = 18
person1.canDrink

// DAY 10

// Child class must always call super.init

class Handbag {
    var price: Int
    init(price: Int) {
        self.price = price
    }
}
class DesignerHandbag: Handbag {
    var brand: String
    init(brand: String, price: Int) {
        self.brand = brand
        super.init(price: price)
    }
}

// Struct object on assignment make a copy of the old struct object,
// class on the other points to the same place in memory
struct A {
    var name = "A"
}
var a = A()
a.name
var aa = a
aa.name = "changed"
a.name

class B {
    var name = "B"
}
var b = B()
b.name
var bb = b
bb.name = "changed"
b.name

// Classes have deinit function rather than just init
/*
 The final difference between classes and structs is the way they deal with constants.
 If you have a constant struct with a variable property, that property can’t be changed
 because the struct itself is constant.
 
 However, if you have a constant class object with a variable property, that property can be
 changed. Because of this, classes don’t need the mutating keyword with methods that
 change properties; that’s only needed with structs.
 */

// DAY 11: PROTOCOLS AND EXTENSIONS

// Sounds like similar to interface, there are no implementation
protocol Identifiable {
    var id: String { get set }
    func identify()
}

// Protocol oriented programming, we extend the protool we create
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}

struct User: Identifiable {
    var id: String
}

let twostraws = User(id: "twostraws")
twostraws.identify()

// Can do something like this for inheritance
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}

// Extensions: helps us extend classes
extension Int {
    var isEven: Bool {
        return self % 2 == 0
    }
    
    func squared() -> Int {
        return self * self;
    }
}
var eight = 8
eight.squared()
eight.isEven

// Protocol extensions
// We can extend protocols so that all structs / classes implementing will have func/derived property
extension Collection {
    func summarize() {
        var names = ""
        for name in self {
            names += "\(name) "
        }
        print("There are \(count) of us: \(names)")
    }
}

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])
pythons.summarize()
beatles.summarize()

// DAY 12:

// OPTIONAL
// var age: Int = nil // is wrong!
var age: Int? = nil
age = 13

// Unwrapping
var name: String? = nil
// name.count // is unsafe

// if let syntax lets us unwraps the optional
if let unwrapped = name {
    print("\(unwrapped.count) letters")
} else {
    print("Missing name")
}

// guard let also unwraps
func greet(_ name: String?) {
    // Deal with unhappy path first
    guard let unwrapped = name else {
        print("You didn't provide a name!")
        return
    }
    
    print("Hello, \(unwrapped)!")
}
greet(nil)
greet("Urmahdur")

// Force unwrap
let five = "5"
let numFive = Int(five) // This makes numFive an Optional Int
let actualFive = Int(five)! // actualFive will be Int not Int?

// Implicitly unwrapped optionals, only use this if we know val starts at nil then assigned
var ageBang: Int! = nil
ageBang = 5
ageBang == 5 // Don't get the difference actually, probs won't use this

// Nil coalescing
var nonNilNum = nil ?? 0

// Optional chaining
/*
 Swift provides us with a shortcut when using optionals: if you want to access something like a.b.c and b is optional, you can write a question mark after it to enable optional chaining: a.b?.c.
 */
let names: [String?] = ["John" , "Paul", "George", "Ringo", nil]
let beatle1 = names[0]?.uppercased()
let beatle2 = names[4]?.uppercased()

struct PersonWithId {
    var id: String
    
    init?(id: String) {
        if id.count == 9 {
            self.id = id
        } else {
            return nil
        }
    }
}

var p1: PersonWithId? = PersonWithId(id: "123456789") // This is a failable init, it will return optional PersonWithId
//var p1: PersonWithId = PersonWithId(id: "123456789") // This would be wrong

// Type cast
class Animal { }
class Fish: Animal { }

class Dog: Animal {
    func makeNoise() {
        print("Woof!")
    }
}
let pets = [Fish(), Dog(), Fish(), Dog()]
for pet in pets {
    if let dog = pet as? Dog {
        dog.makeNoise()
    }
}

