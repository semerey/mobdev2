
import Foundation

// Part 1

// Given string with format "Student1 - Group1; Student2 - Group2; ..."

let studentsStr = "Бортнік Василь - ІВ-72; Чередніченко Владислав - ІВ-73; Гуменюк Олександр - ІВ-71; Корнійчук Ольга - ІВ-71; Киба Олег - ІВ-72; Капінус Артем - ІВ-73; Овчарова Юстіна - ІВ-72; Науменко Павло - ІВ-73; Трудов Антон - ІВ-71; Музика Олександр - ІВ-71; Давиденко Костянтин - ІВ-73; Андрющенко Данило - ІВ-71; Тимко Андрій - ІВ-72; Феофанов Іван - ІВ-71; Гончар Юрій - ІВ-73"

// Task 1
// Create dictionary:
// - key is a group name
// - value is sorted array with students

var studentsGroups: [String: [String]] = [:]

// Your code begins

for record in studentsStr.components(separatedBy: "; ") {
    struct Pair {
        let name: String
        let group: String

        init(_ pairOfStrings: [String]) {
            name = pairOfStrings[0]
            group = pairOfStrings[1]
        }
    }

    let recordPair = Pair(record.components(separatedBy: " - "))

    if studentsGroups[recordPair.group] == nil {
        studentsGroups[recordPair.group] = [recordPair.name]
    } else {
        studentsGroups[recordPair.group]!.append(recordPair.name)
    }
}

for group in studentsGroups.keys {
    studentsGroups[group]!.sort()
}

// Your code ends

print(studentsGroups)
print()

// Given array with expected max points

let points: [Int] = [5, 8, 12, 12, 12, 12, 12, 12, 15]

// Task 2
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is array with points (fill it with random values, use function `randomValue(maxValue: Int) -> Int` )

func randomValue(maxValue: Int) -> Int {
    switch(arc4random_uniform(6)) {
    case 1:
        return Int(ceil(Float(maxValue) * 0.7))
    case 2:
        return Int(ceil(Float(maxValue) * 0.9))
    case 3, 4, 5:
        return maxValue
    default:
        return 0
    }
}

var studentPoints: [String: [String: [Int]]] = [:]

// Your code begins

for group in studentsGroups.keys {
    studentPoints[group] = [:]

    for name in studentsGroups[group]! {
        studentPoints[group]![name] = []

        for point in points {
            studentPoints[group]![name]!.append(randomValue(maxValue: point))
        }
    }
}


// Your code ends

print(studentPoints)
print()

// Task 3
// Create dictionary:
// - key is a group name
// - value is dictionary:
//   - key is student
//   - value is sum of student's points

var sumPoints: [String: [String: Int]] = [:]

// Your code begins

for group in studentPoints.keys {
    sumPoints[group] = [:]

    for name in studentPoints[group]!.keys {
        sumPoints[group]![name] = studentPoints[group]![name]!.reduce(0, +)
    }
}

// Your code ends

print(sumPoints)
print()

// Task 4
// Create dictionary:
// - key is group name
// - value is average of all students points

var groupAvg: [String: Float] = [:]

// Your code begins

for group in sumPoints.keys {
    let sum = Float(sumPoints[group]!.values.reduce(0, +))
    let count = Float(sumPoints[group]!.count)

    groupAvg[group] = sum / count
}

// Your code ends

print(groupAvg)
print()

// Task 5
// Create dictionary:
// - key is group name
// - value is array of students that have >= 60 points

var passedPerGroup: [String: [String]] = [:]

// Your code begins

for group in sumPoints.keys {
    passedPerGroup[group] = [String](sumPoints[group]!.filter({
        $0.value >= 60
    }).keys)
}

// Your code ends

print(passedPerGroup)

// Example of output. Your results will differ because random is used to fill points.
//
//["ІВ-73": ["Гончар Юрій", "Давиденко Костянтин", "Капінус Артем", "Науменко Павло", "Чередніченко Владислав"], "ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-71": ["Андрющенко Данило", "Гуменюк Олександр", "Корнійчук Ольга", "Музика Олександр", "Трудов Антон", "Феофанов Іван"]]
//
//["ІВ-73": ["Давиденко Костянтин": [5, 8, 9, 12, 11, 12, 0, 0, 14], "Капінус Артем": [5, 8, 12, 12, 0, 12, 12, 12, 11], "Науменко Павло": [4, 8, 0, 12, 12, 11, 12, 12, 15], "Чередніченко Владислав": [5, 8, 12, 12, 11, 12, 12, 12, 15], "Гончар Юрій": [5, 6, 0, 12, 0, 11, 12, 11, 14]], "ІВ-71": ["Корнійчук Ольга": [0, 0, 12, 9, 11, 11, 9, 12, 15], "Музика Олександр": [5, 8, 12, 0, 11, 12, 0, 9, 15], "Гуменюк Олександр": [5, 8, 12, 9, 12, 12, 11, 12, 15], "Трудов Антон": [5, 0, 0, 11, 11, 0, 12, 12, 15], "Андрющенко Данило": [5, 6, 0, 12, 12, 12, 0, 9, 15], "Феофанов Іван": [5, 8, 12, 9, 12, 9, 11, 12, 14]], "ІВ-72": ["Киба Олег": [5, 8, 12, 12, 11, 12, 0, 0, 11], "Овчарова Юстіна": [5, 8, 12, 0, 11, 12, 12, 12, 15], "Бортнік Василь": [4, 8, 12, 12, 0, 12, 9, 12, 15], "Тимко Андрій": [0, 8, 11, 0, 12, 12, 9, 12, 15]]]
//
//["ІВ-72": ["Бортнік Василь": 84, "Тимко Андрій": 79, "Овчарова Юстіна": 87, "Киба Олег": 71], "ІВ-73": ["Капінус Артем": 84, "Науменко Павло": 86, "Чередніченко Владислав": 99, "Гончар Юрій": 71, "Давиденко Костянтин": 71], "ІВ-71": ["Корнійчук Ольга": 79, "Трудов Антон": 66, "Андрющенко Данило": 71, "Гуменюк Олександр": 96, "Феофанов Іван": 92, "Музика Олександр": 72]]
//
//["ІВ-71": 79.333336, "ІВ-72": 80.25, "ІВ-73": 82.2]
//
//["ІВ-72": ["Бортнік Василь", "Киба Олег", "Овчарова Юстіна", "Тимко Андрій"], "ІВ-73": ["Давиденко Костянтин", "Капінус Артем", "Чередніченко Владислав", "Гончар Юрій", "Науменко Павло"], "ІВ-71": ["Музика Олександр", "Трудов Антон", "Гуменюк Олександр", "Феофанов Іван", "Андрющенко Данило", "Корнійчук Ольга"]]


enum Direction {
    case N
    case S
    case W
    case E
}

enum MyExceptions: Error {
    case wrongDeg
    case wrongSec
    case wrongMin
}

class CoordinateAS {
    var lat_direction, lon_direction: Direction
    var lon_minutes, lat_minutes, lon_seconds, lat_seconds: Int
    var lat_deg, lon_deg: Int

    init() {
        lat_direction = .S
        lon_direction = .W
        lat_deg = 0
        lon_deg = 0
        lon_minutes = 0
        lon_seconds = 0
        lat_minutes = 0
        lat_seconds = 0

    }

    init(_ lat_d: Int, _ lon_d: Int, _ lat_m: Int, _ lon_m: Int, _ lat_s: Int, _ lon_s: Int) throws {
        lat_deg = lat_d
        lon_deg = lon_d
        lat_seconds = lat_s
        lon_seconds = lon_s
        lat_minutes = lat_m
        lon_minutes = lon_m
        lat_direction = lat_deg < 0 ? Direction.S : Direction.N
        lon_direction = lon_deg < 0 ? Direction.W : Direction.E

        let lon_deg_range = -90...90
        let lat_deg_range = -180...180
        let minSec_range = 0...59

        if !lat_deg_range.contains(lat_deg) || !lon_deg_range.contains(lon_deg) {
            throw MyExceptions.wrongDeg
        }
        if !minSec_range.contains(lon_minutes) || !minSec_range.contains(lat_minutes) {
            throw MyExceptions.wrongMin
        }
        if !minSec_range.contains(lat_seconds) || !minSec_range.contains(lon_seconds) {
            throw MyExceptions.wrongSec
        }
    }

    func geoStyle() -> String {
        return "\(abs(lat_deg))°\(lat_minutes)\'\(lat_seconds)\"\(lat_direction), \(abs(lon_deg))°\(lon_minutes)\'\(lon_seconds)\"\(lon_direction)"
    }

    func degStyle() -> String {
        return "\(abs(lat_deg + lat_minutes/60 + lat_seconds/3600))°\(lat_direction), \(abs(lon_deg + lon_minutes/60 + lon_seconds/3600))°\(lon_direction) "
    }

    func middlePoint(_ other: CoordinateAS) -> CoordinateAS? {
        if lat_direction == other.lat_direction && lon_direction == other.lon_direction {
            return try! CoordinateAS(
                (lat_deg + other.lat_deg)/2,
                (lon_deg + other.lon_deg)/2,
                (lat_minutes + other.lat_minutes)/2,
                (lon_minutes + other.lon_minutes)/2,
                (lat_seconds + other.lat_seconds)/2,
                (lon_seconds + other.lon_seconds)/2
            )
        } else {
            return nil
        }
    }

    static func middlePoint(_ first: CoordinateAS, _ second: CoordinateAS) -> CoordinateAS? {
        if first.lat_direction == second.lat_direction && first.lon_direction == second.lon_direction {
            return try! CoordinateAS(
                (first.lat_deg + second.lat_deg)/2,
                (first.lon_deg + second.lon_deg)/2,
                (first.lat_minutes + second.lat_minutes)/2,
                (first.lon_minutes + second.lon_minutes)/2,
                (first.lat_seconds + second.lat_seconds)/2,
                (first.lon_seconds + second.lon_seconds)/2
            )
        } else {
            return nil
        }
    }
}

var coord1 = CoordinateAS()
var coord2 = try! CoordinateAS(-6, -6, 6, 6, 6, 6)

print(coord2.geoStyle())
print(coord2.degStyle())

var coordmid = coord2.middlePoint(coord1)
print(coordmid!.degStyle()+"\n"+coordmid!.geoStyle())

var coordmid2 = CoordinateAS.middlePoint(coord2, coord1)
print(coordmid2!.degStyle()+"\n"+coordmid2!.geoStyle())
