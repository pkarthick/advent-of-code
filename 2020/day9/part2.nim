import strutils
import sequtils
import algorithm
import options

let input="""35
20
15
25
47
40
62
55
65
95
102
117
150
182
127
219
299
277
309
576"""

let nums = input.splitLines.mapIt(it.parseInt)

let preamblecount = 5

proc findInvalid(nums: seq[int]): int =

    proc checkTwoSum(nums: seq[int], total: int): bool =

        var s = 0
        var e = len(nums) - 1
        var xs = nums.mapIt(it).sorted()

        while true:
            let sum = xs[s] + xs[e]
            if sum == total:
                return true
            elif sum > total:
                dec e
            elif sum < total:
                inc s
            
            if s >= e: break

        return false

    for i in preamblecount ..< len(nums):
        if not checkTwoSum(nums[i-preamblecount .. i-1], nums[i]):
            return nums[i]


let invalid = findInvalid(nums)

proc checkSum(): Option[int] =

    for i in 0 ..< nums.len:
        
        var total = 0

        for j in i ..< nums.len:
            total += nums[j]
            if total == invalid:
                let xs = nums[i .. j].sorted()
                return some(xs.min + xs.max)

    return none(int)

echo checkSum().get()
