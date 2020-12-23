import UIKit

var str = "Hello, playground"

// Some operators
// Shift enter to run
let firstScore = 12
let secondScore = 4
let total = firstScore + secondScore
let appended = [1,2] + [3,4]

firstScore == firstScore
firstScore != 12
"swift" == "swift" // Compare strings straight

let firstCard = 11
let secondCard = 10
if firstCard + secondCard == 21 {
    print("Blackjack!")
}

let age1 = 12
let age2 = 21
if age1 > 18 && age2 > 18 { // and syntax
    print("Both are over 18")
}

// Switch syntax
let weather = "sunny"
switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}

let range = 0...5
