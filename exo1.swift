import UIKit

func drawTree(size: Int) -> Int? {
    var count = 0;
    for i in 0...(size-1) {
        print(String(repeating: " ", count: size - i - 1) + String(repeating: "*", count: 1 + i * 2))
        count = count + 1 + i*2
    }
    print(String(repeating: " ", count: size-1) + "|")
    return count
}
print(drawTree(size: 3))
