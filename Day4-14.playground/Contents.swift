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
    var age: Int {
        // property observer
        didSet {
            self.congratulate()
        }
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
var person1 = Person(name: "Bob", age: 17)
person1.setName(name: "Ann")
person1.name
person1.canDrink
person1.age = 18
person1.canDrink


