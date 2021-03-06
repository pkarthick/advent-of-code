import strutils

let input = """..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#"""

func countTrees(lines: seq[string]): int =
    let 
        treeid = '#'
        cols = lines[0].len 
        right = 3
    
    var 
        col = 0
    
    for r in countup(1, lines.len-1):
        col += right
        
        if col >= cols:
            col = col %% cols

        if lines[r][col] == treeid:
            inc result
    
echo countTrees(input.splitLines)